"""
Simple asyncio-based job scheduler.

Usage:
    # Periodic (in lifespan):
    scheduler.add("ratings", recalc_ratings, interval=300)
    scheduler.start()

    # One-off (from any router/service):
    request.app.state.scheduler.run_once("gen_narrative", generate_narrative, route_id=42)
"""

import asyncio
from datetime import datetime
from typing import Callable, Awaitable

from loguru import logger


class Job:
    __slots__ = ("name", "fn", "interval", "run_at_start", "_task")

    def __init__(self, name: str, fn: Callable[[], Awaitable[None]], interval: int, run_at_start: bool = False):
        self.name = name
        self.fn = fn
        self.interval = interval
        self.run_at_start = run_at_start
        self._task: asyncio.Task | None = None

    async def _loop(self) -> None:
        if not self.run_at_start:
            await asyncio.sleep(self.interval)
        while True:
            started = datetime.now()
            try:
                logger.info("[scheduler] {} starting", self.name)
                await self.fn()
                elapsed = (datetime.now() - started).total_seconds()
                logger.info("[scheduler] {} done ({:.1f}s)", self.name, elapsed)
            except asyncio.CancelledError:
                raise
            except Exception as e:
                logger.error("[scheduler] {} failed: {}", self.name, e)
            await asyncio.sleep(self.interval)


class Scheduler:
    def __init__(self) -> None:
        self._jobs: list[Job] = []
        self._once_tasks: set[asyncio.Task] = set()

    def add(self, name: str, fn: Callable[[], Awaitable[None]], interval: int, run_at_start: bool = False) -> None:
        self._jobs.append(Job(name, fn, interval, run_at_start))

    def run_once(self, name: str, fn: Callable[..., Awaitable[None]], *args, **kwargs) -> asyncio.Task:
        """Fire-and-forget async job. Call from router/service."""
        async def _wrapper() -> None:
            started = datetime.now()
            try:
                logger.info("[scheduler] once:{} starting", name)
                await fn(*args, **kwargs)
                elapsed = (datetime.now() - started).total_seconds()
                logger.info("[scheduler] once:{} done ({:.1f}s)", name, elapsed)
            except Exception as e:
                logger.error("[scheduler] once:{} failed: {}", name, e)
            finally:
                self._once_tasks.discard(task)

        task = asyncio.create_task(_wrapper())
        self._once_tasks.add(task)
        return task

    def start(self) -> None:
        for job in self._jobs:
            job._task = asyncio.create_task(job._loop())
            logger.info("[scheduler] registered: {} (every {}s)", job.name, job.interval)

    async def stop(self) -> None:
        for job in self._jobs:
            if job._task:
                job._task.cancel()
        for t in self._once_tasks:
            t.cancel()
        for job in self._jobs:
            if job._task:
                try:
                    await job._task
                except asyncio.CancelledError:
                    pass
        for t in self._once_tasks:
            try:
                await t
            except asyncio.CancelledError:
                pass
        logger.info("[scheduler] all jobs stopped")
