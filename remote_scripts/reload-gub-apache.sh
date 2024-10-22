#!/usr/bin/env bash
cd /apps/gub-apache
docker compose exec apache apachectl -k graceful -DFOREGROUND

