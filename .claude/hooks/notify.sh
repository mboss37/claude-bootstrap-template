#!/bin/bash
# macOS notification + sound when Claude needs attention
osascript -e 'display notification "Claude Code needs your attention" with title "Claude Code"' 2>/dev/null
afplay /System/Library/Sounds/Ping.aiff 2>/dev/null &
exit 0
