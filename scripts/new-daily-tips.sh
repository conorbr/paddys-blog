#!/usr/bin/env bash
# Start (or reopen) today’s tips post: slug tips-YYYY-MM-DD in Europe/Dublin.
# Forwards flags to new-post.sh (e.g. -d draft, -n no editor).
# Usage: new-daily-tips.sh [new-post options...]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/lib/common.sh"

DAY="$(paddy_date_dublin)"
SLUG="tips-${DAY}"
TITLE="Racing notes — $(paddy_title_daily)"
DESC="Armchair tips and notes for $(paddy_title_daily). Entertainment only."

FILE="$(paddy_posts_dir)/$SLUG/index.md"

if [[ -f "$FILE" ]]; then
  echo "Today’s file already exists — opening: $FILE" >&2
  ${EDITOR:-nano} "$FILE"
  exit 0
fi

exec "$SCRIPT_DIR/new-post.sh" --slug "$SLUG" --description "$DESC" "$@" "$TITLE"
