#!/bin/bash
set -e

echo "[entrypoint] Syncing database schema (create_all, safe)..."
python -c "
from sqlalchemy import create_engine
from app.models import Base
from app.core.config import settings

url = settings.db_url.replace('asyncpg', 'psycopg2')
engine = create_engine(url)
Base.metadata.create_all(engine)
engine.dispose()
print('[entrypoint] Schema synced.')
"

echo "[entrypoint] Starting application..."
exec "$@"
