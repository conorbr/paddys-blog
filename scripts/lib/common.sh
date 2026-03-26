# Shared helpers for Paddy blog scripts. Source from repo scripts only.
# shellcheck shell=bash

paddy_blog_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd
}

paddy_posts_dir() {
  echo "$(paddy_blog_root)/exampleSite/content/posts"
}

# Lowercase slug from a title or phrase (ASCII-friendly).
paddy_slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed "s/'//g" | tr -cs 'a-z0-9' '-' | sed 's/^-\|-$//g'
}

# RFC3339 timestamp in Europe/Dublin for Hugo front matter (offset with colon).
paddy_now_dublin() {
  TZ=Europe/Dublin date +"%Y-%m-%dT%H:%M:%S%z" | sed -E 's/([+-][0-9]{2})([0-9]{2})$/\1:\2/'
}

# Calendar date YYYY-MM-DD in Dublin.
paddy_date_dublin() {
  TZ=Europe/Dublin date +%Y-%m-%d
}

# Human date line for titles, e.g. "Tuesday 25 March 2025" (GNU date).
paddy_title_daily() {
  TZ=Europe/Dublin date +"%A %-d %B %Y" 2>/dev/null || TZ=Europe/Dublin date +"%A %e %B %Y"
}
