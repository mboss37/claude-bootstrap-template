---
name: deploy
description: Build and deploy services
argument-hint: "[target: local|staging|production]"
disable-model-invocation: true
---

# Deploy

Deploy target: $ARGUMENTS (default: local)

## Pre-deploy Checks
- [ ] All tests pass
- [ ] No lint warnings
- [ ] No type errors
- [ ] Docker builds succeed (if applicable)

## Local Deploy
<!-- TODO: Customize for your project -->
1. Run build commands
2. Run `docker compose build` (if applicable)
3. Run `docker compose up -d` (if applicable)
4. Verify health endpoints
5. Report status
