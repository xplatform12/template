SHELL := /usr/bin/env bash

include tools/Makefile

.PHONY: bootstrap-docs setup-check

bootstrap-docs:
	@./scripts/bootstrap-docs-template.sh

setup-check: tools-check docs-check docs-status
	@echo "setup-check passed."
