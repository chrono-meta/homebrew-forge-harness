# homebrew-forge-harness

Homebrew tap for [`forge-harness`](https://github.com/chrono-meta/forge-harness) — installs the
same content as the [`@chrono-meta/fh-gate`](https://www.npmjs.com/package/@chrono-meta/fh-gate)
npm package (skills, agents, harness-core doctrine, and the 4-axis gate machinery), just through
`brew` instead of `npx`/`npm`. No separate release pipeline — this Formula tracks the npm tarball
directly, so `brew upgrade` follows npm releases.

## Install

```
brew tap chrono-meta/forge-harness
brew install forge-harness
```

## Use

```
fh-gate                    # auto-detect from git diff
fh-gate "src/foo.ts" full  # explicit files + level
fh-run --skill <name>
fh-goal "<goal text>"
fh-codex-doctor --strict
```

See [`forge-harness` CHEATSHEET.md](https://github.com/chrono-meta/forge-harness/blob/main/CHEATSHEET.md#zero-install-cli-npmnpx)
for the full CLI reference (backends, `FH_BACKEND`, exit codes).

## Who this is for

This tap is for **using** FH's gates/skills in your own project — 100% of what the npm package
ships, no coverage loss versus `npx`. If you want to **develop or contribute to FH itself**, clone
[`chrono-meta/forge-harness`](https://github.com/chrono-meta/forge-harness) directly — FH's
self-evolution loop (`tracks/`, session memory) only accrues in a real clone, not through either
package manager.
