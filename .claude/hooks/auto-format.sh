#!/bin/bash
# Auto-format files after Claude edits them
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [[ -z "$FILE" || ! -f "$FILE" ]]; then exit 0; fi

case "$FILE" in
  *.rs)       rustfmt "$FILE" 2>/dev/null ;;
  *.ts|*.tsx) npx prettier --write "$FILE" 2>/dev/null ;;
  *.js|*.jsx) npx prettier --write "$FILE" 2>/dev/null ;;
  *.json)     npx prettier --write "$FILE" 2>/dev/null ;;
  *.sql)      pg_format -i "$FILE" 2>/dev/null ;;
esac
exit 0
