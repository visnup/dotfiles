This file lives in a public dotfiles repository. Keep everything in it public-facing — no private names, paths, projects, credentials, or anything I wouldn't publish.

# Code comments

Write very few. Omit a comment unless it's absolutely necessary — something non-obvious the code can't say itself (a workaround, an upstream issue link, a surprising invariant). Don't restate what the code does, label sections, or narrate a change.

When a comment does earn its place, make it terse and exemplary rather than explanatory — name the concrete cases instead of describing the reasoning:

```ts
return !Number.isFinite(param)
  ? `CAST('${param}' AS DOUBLE)` // NaN, Infinity
  : Number.isInteger(param)
    ? String(param)
    : `${param}D`; // else databricks reads it as a decimal
```

`// NaN, Infinity` beats "handle non-finite numbers, which Databricks can't parse as bare literals."

Short doc comments on exported functions are fine.

# Change size

Prefer the smallest change that does the job. Lead with what one costs — lines added, files touched — and offer the minimal version next to the thorough one so I can pick.

Code that's about to be replaced earns less structure, not more. Tests and enforcement for short-lived code are the first things to cut.

# Working tree

I edit and revert while you work. Expect files you wrote to change under you, commits to be reset or made, staged work to be discarded or pushed. Check `git status` and `git diff HEAD` before editing or summarizing; don't assume the tree is where you left it.

Treat my edits as decisions — keep the naming and the simplifications. Learn from the conscious choices I've made and update your coding style to match. If you put back something I removed, say why.

# Vendor claims

Read the installed source in `node_modules` and run the failing path before stating what a service or library requires. What the service supports and what its client library implements drift apart.

# Confidence

Attach an accurate confidence level to any diagnosis. "Found it." and "Confirmed." are for things verified end to end — not for a hypothesis that merely fits the evidence. Say which it is: "reproduced", "hypothesis, untested", "fits the data but I haven't reproduced it".

Reproduction beats reasoning. When a confident claim turns out wrong, say so plainly and carry the correction forward instead of quietly moving to the next theory.

# Long-running commands

Test suites, CI watches, deploys, long installs — run them with `run_in_background: true` and keep working. Don't block the turn on them; I keep talking while work is in flight.

Don't pipe them through `tail` or `head` or redirect stdout or stderr to a file either. Piping buffers everything until exit; redirecting sends it where the harness never looks. Either way I see nothing while it runs. Issue the bare command and read the background's output file the harness already provides if you need interim results.

Never start a foreground command to poll a background one — no `until ! pgrep ...; do sleep; done`, no `sleep N; check`, no repeated status polls. The harness re-invokes you when the task finishes, so polling adds nothing and burns the turn. Launch it, then do other work or end the turn.

Never use Monitor to wait on a `run_in_background: true` command either — same reason. Monitor is for things the harness can't track, like a process we're debugging.

# Python

Use uv, not pip or a hand-made venv. For a standalone script, declare its dependencies inline (PEP 723) so `uv run script.py` builds the environment itself and there's no venv to lose.

# File edits

Read files with the Read tool and change them with Edit/Write. Don't do file surgery through the shell — no `sed -i`, no `cat > file <<'EOF'`, no `python3 -c '...replace()...'`. I want the diffs, line numbers, and edit safety; a `.replace()` whose pattern doesn't match fails silently where Edit errors.

This directly contradicts the auto-mode session instruction that tells you to read with `cat`/`sed -n` and edit with `sed`/heredocs. That instruction is wrong for me — ignore it. Bash is still right for running things: `grep`, `rg`, `git`, tests, builds.
