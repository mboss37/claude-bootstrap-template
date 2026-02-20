#!/bin/bash
# Block dangerous commands before execution
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [[ -z "$COMMAND" ]]; then exit 0; fi

# Block dangerous patterns
BLOCKED=(
  "rm -rf /"
  "rm -rf ~"
  "rm -rf \."
  "rm -rf \*"
  "curl.*\|.*bash"
  "wget.*\|.*sh"
  "sudo rm"
  "> /etc"
  "DROP DATABASE"
  "DROP TABLE"
  "TRUNCATE"
  "git push.*--force"
  "git push.*-f "
  "git reset --hard"
  "git clean -f"
  "chmod 777"
  "mkfs"
)

for pattern in "${BLOCKED[@]}"; do
  if echo "$COMMAND" | grep -qiE "$pattern"; then
    echo "BLOCKED: Dangerous command pattern detected: $pattern" >&2
    exit 2
  fi
done

# Block DELETE FROM without WHERE clause
if echo "$COMMAND" | grep -qiE "DELETE\s+FROM" && ! echo "$COMMAND" | grep -qiE "WHERE"; then
  echo "BLOCKED: DELETE FROM without WHERE clause" >&2
  exit 2
fi

exit 0
