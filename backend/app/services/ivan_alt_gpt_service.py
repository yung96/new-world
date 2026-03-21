"""
Клон клиента LLM для namespace ivan-alt (локальные маршруты).

Отделён от `GptService`, чтобы менять таймауты, ретраи и параметры вызова
без влияния на travel/social.
"""

import asyncio
from json import JSONDecodeError
from typing import Callable

import httpx
from loguru import logger
from pydantic import ValidationError
from pydantic_core import ValidationError as CoreValidationError
from tenacity import (
    RetryCallState,
    _utils,
    retry,
    retry_if_exception_type,
    wait_random_exponential,
    stop_after_attempt,
)
from openai import (
    APIConnectionError,
    APIStatusError,
    APITimeoutError,
    AsyncOpenAI,
    ChatCompletion,
    RateLimitError,
)

from app.api.base_schema import BasePydanticModel
from app.core.config import settings


def _after_log_error_ivan_alt() -> Callable[["RetryCallState"], None]:
    def log_it(retry_state: "RetryCallState") -> None:
        outcome = retry_state.outcome
        if not outcome.failed:
            return
        exc = outcome.exception()
        status = getattr(exc, "status_code", "N/A")
        message = getattr(exc, "message", str(exc))
        logger.warning(
            "[ivan_alt_gpt] openai: status=%s, message=%s, after %.3f(s), attempt %s",
            status,
            message,
            retry_state.seconds_since_start,
            _utils.to_ordinal(retry_state.attempt_number),
        )

    return log_it


class IvanAltGptService:
    def __init__(self):
        self.client = AsyncOpenAI(
            api_key=settings.GPT_CLIENT_KEY,
            base_url=settings.GPT_CLIENT_BASE_URL,
            timeout=httpx.Timeout(connect=10, read=120, write=60, pool=60),
        )
        self.gpt_model = settings.GPT_MODEL

    async def close(self) -> None:
        await self.client.close()

    @retry(
        wait=wait_random_exponential(min=10, max=120),
        retry=retry_if_exception_type(
            (
                RateLimitError,
                APIConnectionError,
                APIStatusError,
                APITimeoutError,
                JSONDecodeError,
                asyncio.TimeoutError,
                asyncio.CancelledError,
            )
        ),
        after=_after_log_error_ivan_alt(),
        stop=stop_after_attempt(10),
    )
    async def request_openai_text_response(
        self,
        sys_prompt: str,
        user_prompt: str,
        max_tokens: int,
        *,
        temperature: float = 0.8,
    ) -> ChatCompletion:
        messages = [
            {"role": "system", "content": sys_prompt},
            {"role": "user", "content": user_prompt},
        ]
        response = await asyncio.wait_for(
            self.client.chat.completions.create(
                model=settings.GPT_MODEL,
                response_format={"type": "text"},
                messages=messages,
                max_tokens=max_tokens,
                temperature=temperature,
            ),
            timeout=90,
        )
        return response

    @retry(
        wait=wait_random_exponential(min=10, max=120),
        retry=retry_if_exception_type(
            (
                RateLimitError,
                APIConnectionError,
                APIStatusError,
                APITimeoutError,
                asyncio.TimeoutError,
                asyncio.CancelledError,
                ValidationError,
                CoreValidationError,
            )
        ),
        after=_after_log_error_ivan_alt(),
        stop=stop_after_attempt(10),
    )
    async def request_openai_pydantic_response(
        self,
        sys_prompt: str,
        user_prompt: str,
        response_model: type[BasePydanticModel],
        *,
        max_tokens: int = 4096,
        temperature: float = 0.45,
    ) -> tuple[BasePydanticModel | None, int]:
        messages = [
            {"role": "system", "content": sys_prompt},
            {"role": "user", "content": user_prompt},
        ]
        response = await asyncio.wait_for(
            self.client.beta.chat.completions.parse(
                model=settings.GPT_MODEL,
                response_format=response_model,
                messages=messages,
                max_tokens=max_tokens,
                temperature=temperature,
            ),
            timeout=90,
        )
        usage = response.usage.completion_tokens if response.usage else 0
        return (response.choices[0].message.parsed, usage)
