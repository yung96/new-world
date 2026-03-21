"""
Simple asyncio-based job scheduler.
No external deps — just asyncio.create_task + sleep loops.

Usage in lifespan:
    app.state.scheduler = Scheduler()
    app.state.scheduler.start()
    ...
    await app.state.scheduler.stop()
"""

import asyncio
from datetime import datetime
from typing import Callable, Awaitable

from loguru import logger


class Job:
    __slots__ = ("name", "fn", "interval", "run_at_start", "_task")

    def __init__(
        self,
        name: str,
        fn: Callable[[], Awaitable[None]],
        interval: int,
        run_at_start: bool = False,
    ):
        self.name = name
        self.fn = fn
        self.interval = interval  # seconds
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

    def add(
        self,
        name: str,
        fn: Callable[[], Awaitable[None]],
        interval: int,
        run_at_start: bool = False,
    ) -> None:
        self._jobs.append(Job(name, fn, interval, run_at_start))

    def start(self) -> None:
        for job in self._jobs:
            job._task = asyncio.create_task(job._loop())
            logger.info("[scheduler] registered: {} (every {}s)", job.name, job.interval)

    async def stop(self) -> None:
        for job in self._jobs:
            if job._task:
                job._task.cancel()
        for job in self._jobs:
            if job._task:
                try:
                    await job._task
                except asyncio.CancelledError:
                    pass
        logger.info("[scheduler] all jobs stopped")
