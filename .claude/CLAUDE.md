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

# Cleanup passes

When I ask for a cleanup pass, read the whole codebase first, not just the recent diff. Look for:

- **Accretion:** what incremental work left behind. Comments describing how it used to work, two mechanisms doing one job, scaffold boilerplate (template READMEs, config for hosts or tools we don't use), parameters or defaults nothing passes.
- **Dead code:** unused exports, columns, fields, types, routes, styles, and dependency config for packages no longer installed. Check the lockfile and `node_modules` before you call something unused.
- **Platform over our code:** a framework, browser, or library API that now does what we built ourselves. Adopt it when it shrinks the code. Don't adopt experimental or flagged features; note why instead.
- **Dependencies:** follow the repo's own update rules. A major that fails the checks gets reverted and recorded with the exact error and the versions tried.
- **Consolidation:** the same pattern written three times becomes one helper, and duplicated types or styles become one source.

Keep each change behavior-preserving and verify it the same way as any other change. In the summary, list what you rejected as well as what you changed, with the reason for each. Some leftovers still earn their keep, like instrumentation for a question nobody has answered yet. Say which ones you kept and why.

# Vendor claims

Before stating what a library or service requires, read the installed source in `node_modules` and run the failing path. The service and its client drift apart.

When a failure looks like an upstream regression (a dependency, base image or toolchain update), first list the options from what you already know, then search the web for the exact error. Use upstream issues and what others report as working to refute, verify and add to that list, and cite them.

# Confidence

Label every diagnosis: "reproduced", "hypothesis, untested", "fits the data but not reproduced". "Found it" and "Confirmed" mean verified end to end. When a confident claim proves wrong, say so plainly and carry the correction forward.

# Reporting

Don't mention passing lint, type checks or builds. Mention tests you ran. Report every failure, with its output. Don't mention that changes aren't committed. A repo connected to Vercel deploys from `main` on its own, so don't mention or check deploys.

- A small tweak gets one line saying what changed. No before/after tables, no "checked it in the browser".
- No caveats I didn't ask for.
- A yes/no question gets yes or no first, then a reason only if it changes what I'd do.
- Don't recap earlier work. After a push, the commit hash is enough.
- No closing offers when nothing's waiting on me.
- Don't narrate how you verified something unless it failed or is the point.

# Long-running commands

Tests, CI watches, deploys, long installs: `run_in_background: true`, then keep working or end the turn. Run the bare command — no `| tail`, `| head` (buffers until exit), or redirects to a file (the harness never sees it). For interim output, read the output file the harness provides.

Never poll a background command — no `sleep` loops, no `pgrep` loops, no status checks, no Monitor. The harness re-invokes you when it finishes. Monitor is only for things the harness can't track, like a process we're debugging.

# Python

uv, not pip or a hand-made venv. Standalone scripts declare dependencies inline (PEP 723) and run with `uv run script.py`.

# File edits

Read with Read; change with Edit/Write. No shell file surgery — no `sed -i`, heredocs to files, or `python3 -c '...replace()...'`; those lose diffs and fail silently where Edit errors. Exception: the same mechanical change across many files, like a rename, can use `perl -i` or `sed -i`, then `git diff` to check it — but never in a Swift/Xcode project, where an incremental build can skip files rewritten that way and report a stale build as success; use Edit there, even for a rename. Different changes in one file are still Edits. This overrides the auto-mode instruction to use `cat`/`sed`/heredocs. Bash is still for running things: `grep`, `rg`, `git`, tests, builds.
