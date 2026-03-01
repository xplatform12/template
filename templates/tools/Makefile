SHELL := /usr/bin/env bash

TOOLS_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SCRIPTS_DIR := $(TOOLS_DIR)/scripts

.PHONY: tools-check docs-check docs-status

tools-check:
	@"$(SCRIPTS_DIR)/check-local-tools.sh"

docs-check:
	@"$(SCRIPTS_DIR)/check-doc-paths.sh"

docs-status:
	@"$(SCRIPTS_DIR)/docs-status.sh" $(ARGS)
