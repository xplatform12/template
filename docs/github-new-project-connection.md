# Connect to GitHub repo: NewProjectName

## Status

- Status: `Active`
- Role: `Runbook`
- Source of truth scope: `How to clone and connect to a new Xplatform12 project repository on GitHub`

## Context

- GitHub organization: `Xplatform12`
- Repository name: `NewProjectName`
- Default remote: `https://github.com/Xplatform12/NewProjectName.git`

## Prerequisites

- Git installed.
- A GitHub account with access to `Xplatform12/NewProjectName`.
- One of:
  - GitHub CLI (`gh`) authenticated
  - a configured SSH key in GitHub
  - HTTPS access with a Personal Access Token when prompted

## Verify GitHub access

If you use GitHub CLI:

```bash
gh auth status
```

If you use SSH:

```bash
ssh -T git@github.com
```

## Option A (recommended): GitHub CLI

Authenticate once:

```bash
gh auth login
```

Clone:

```bash
gh repo clone Xplatform12/NewProjectName
```

## Option B: Standard HTTPS remote

Clone:

```bash
git clone https://github.com/Xplatform12/NewProjectName.git
```

Git will prompt for credentials if needed. Use a GitHub Personal Access Token instead of a password when HTTPS authentication is required.

## Option C: SSH remote

Clone:

```bash
git clone git@github.com:Xplatform12/NewProjectName.git
```

## Existing repo: add remote instead of clone

HTTPS:

```bash
git remote add origin https://github.com/Xplatform12/NewProjectName.git
```

SSH:

```bash
git remote add origin git@github.com:Xplatform12/NewProjectName.git
```

## Quick connectivity check

```bash
git ls-remote https://github.com/Xplatform12/NewProjectName.git
```

If you use GitHub CLI, you can also verify repository access with:

```bash
gh repo view Xplatform12/NewProjectName
```

## Suggested Next Steps For A New Development Project

After cloning, keep these baseline files in the repository before adding application code:

- `.editorconfig`
- `.gitignore`
- `.env.example`
- `AGENTS.md`
- `.github/PULL_REQUEST_TEMPLATE.md`

Add application directories when implementation starts:

- `src/`
- `tests/`
