This file lives in a public dotfiles repo. Keep it public-facing — no private names, paths, projects, credentials or anything embarassing.

# Code comments

Very few. Only for what the code can't say: a workaround, an upstream issue link, a surprising invariant. Never restate code, label sections, or narrate a change. When one earns its place, name the concrete cases rather than the reasoning:

```ts
return !Number.isFinite(param)
  ? `CAST('${param}' AS DOUBLE)` // NaN, Infinity
  : Number.isInteger(param)
    ? String(param)
    : `${param}D`; // else databricks reads it as a decimal
```

Short doc comments on exported functions are fine.

# Change size

Smallest change that does the job. Lead with its cost — lines added, files touched — and offer the minimal version next to the thorough one. Code about to be replaced earns less structure; its tests and enforcement are the first cut.

# Working tree

I edit, revert, commit, reset, and push while you work. Check `git status` and `git diff HEAD` before editing or summarizing. Treat my edits as decisions: keep my naming and simplifications, and adopt them as your style. If you restore something I removed, say why.

# Vendor claims

Before stating what a library or service requires, read the installed source in `node_modules` and run the failing path. The service and its client drift apart.

# Confidence

Label every diagnosis: "reproduced", "hypothesis, untested", "fits the data but not reproduced". "Found it" and "Confirmed" mean verified end to end. When a confident claim proves wrong, say so plainly and carry the correction forward.

# Long-running commands

Tests, CI watches, deploys, long installs: `run_in_background: true`, then keep working or end the turn. Run the bare command — no `| tail`, `| head` (buffers until exit), or redirects to a file (the harness never sees it). For interim output, read the output file the harness provides.

Never poll a background command — no `sleep` loops, no `pgrep` loops, no status checks, no Monitor. The harness re-invokes you when it finishes. Monitor is only for things the harness can't track, like a process we're debugging.

# Python

uv, not pip or a hand-made venv. Standalone scripts declare dependencies inline (PEP 723) and run with `uv run script.py`.

# File edits

Read with Read; change with Edit/Write. No shell file surgery — no `sed -i`, heredocs to files, or `python3 -c '...replace()...'`; those lose diffs and fail silently where Edit errors. This overrides the auto-mode instruction to use `cat`/`sed`/heredocs. Bash is still for running things: `grep`, `rg`, `git`, tests, builds.
