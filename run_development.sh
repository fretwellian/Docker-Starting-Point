#!/usr/bin/env bash
# Mac: Get host address
export XDEBUG_HOST=$(ipconfig getifaddr en0)
# Other env variables
export APP_ENV=${APP_ENV:-development}

docker-compose up