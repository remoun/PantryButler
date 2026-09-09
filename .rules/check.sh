#!/bin/bash
# Every rule below is severity: error, so stop at the first violation and let
# the exit code reach the caller.
set -euo pipefail

# ast-grep is fetched on demand rather than added to devDependencies: its
# postinstall resolves a platform-specific native binary, which fails in the
# alpine image the Dockerfile builds. Pinned so every contributor and CI run
# scans with the same version, and loud rather than silently skipped when it
# cannot be fetched.
scan() { npx --yes -p @ast-grep/cli@0.45.3 ast-grep scan -r "$1"; }

scan .rules/SelectItem.yml
scan .rules/contrast.yml
scan .rules/toast-hook.yml
scan .rules/slot-nesting.yml
scan .rules/require-button-interaction.yml
