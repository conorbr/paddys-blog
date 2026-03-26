#!/usr/bin/env bash
# Stage example site content + hugo config, commit, and push to origin.
# Usage: push-blog.sh ["commit message"]
# If no message, uses: Blog: update content

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/lib/common.sh"

ROOT="$(paddy_blog_root)"
cd "$ROOT"

if ! git rev-parse --git-dir >/dev/null 2>&1; then
  echo "Error: not a git repository: $ROOT" >&2
  exit 1
fi

BRANCH="$(git branch --show-current)"
REMOTE="${PADDY_BLOG_REMOTE:-origin}"

git add exampleSite/content/ exampleSite/hugo.toml 2>/dev/null || true

if git diff --cached --quiet; then
  echo "Nothing to commit (no staged changes under exampleSite/content or hugo.toml)." >&2
  exit 0
fi

if [[ $# -eq 0 ]]; then
  MSG="Blog: update content"
else
  MSG="$*"
fi
git commit -m "$MSG"
git push "$REMOTE" "$BRANCH"
echo "Pushed to $REMOTE ($BRANCH)."
