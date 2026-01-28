#!/bin/bash
source .env

docker push docker.ub.gu.se/ssl-deploy:${SSL_DEPLOY_VERSION}
