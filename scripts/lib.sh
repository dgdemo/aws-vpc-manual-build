#!/bin/bash
set -euo pipefail

ENV_FILE="session.env"
touch "$ENV_FILE"

save_var() {
  local name="$1"
  local value="$2"

  export "$name=$value"

  grep -v "^export ${name}=" "$ENV_FILE" > "${ENV_FILE}.tmp" 2>/dev/null || true
  mv "${ENV_FILE}.tmp" "$ENV_FILE" 2>/dev/null || true

  echo "export ${name}=${value}" >> "$ENV_FILE"
} 