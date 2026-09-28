#!/bin/bash
# Runs at the start of each Claude Code session. In cloud sessions it installs
# the ARM toolchain so the ROM can be built with `make`.
set -e
if [ "$CLAUDE_CODE_REMOTE" != "true" ]; then
    exit 0
fi
bash "$CLAUDE_PROJECT_DIR/hack/setup_env.sh"
