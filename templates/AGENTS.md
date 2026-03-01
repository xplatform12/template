# AI Collaboration Guide

## Status

- Status: `Active`
- Role: `Primary runbook`
- Source of truth scope: `Repository-level instructions for Codex and other AI coding agents`

## Purpose

This file defines default operating assumptions for AI agents working in this repository.

Agents should read this file before making changes, reviewing code, or suggesting operational actions.

## Default Assumptions

- Treat this repository as the source of truth for local project rules.
- Prefer reviewing and explaining before editing when the user asks for a review.
- Ask before making changes to remote systems, shared environments, or production-like infrastructure.
- Never make a change on a remote server unless the user explicitly approves that change first.
- Never run destructive commands against remote systems unless the user explicitly requests them.
- Do not assume missing context. If a deployment target, environment, or credential scope is unclear, stop and ask.
- Prefer safe, reversible changes and document risk when suggesting operational steps.

## Remote Access Rules

- Read-only verification on a remote server is allowed only when the user clearly asked for remote inspection.
- Configuration changes, package installs, service restarts, migrations, or file edits on a remote server always require user approval first.
- If a remote command could change state, treat it as a write action even if the impact seems minor.
- When in doubt, present the command and ask for confirmation before running it.

## Change Rules

- Update the closest source-of-truth file first.
- Do not rewrite large areas of the repository unless the user asked for a broader refactor.
- Preserve existing user changes that are unrelated to the current task.
- Call out assumptions, blockers, and unverified claims clearly.

## Review Rules

- Prioritize bugs, regressions, risky assumptions, and missing validation.
- Keep summaries brief and lead with concrete findings.
- If no issues are found, state that clearly and mention any remaining uncertainty.
