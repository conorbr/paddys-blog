#!/usr/bin/env bash
# Create a Hugo post bundle under exampleSite/content/posts/<slug>/index.md
# Usage: new-post.sh [options] "Post title"
# Options:
#   -s, --slug SLUG          Folder name (default: slugified title)
#   -c, --category CAT       Category (repeatable; default first post: Racing)
#   -t, --tag TAG            Tag (repeatable; default: uk-racing, watch-along)
#   --minimal-tags           No tags in front matter (empty list)
#   -d, --draft              Mark as draft
#   --description TEXT       meta description (default: short line from title)
#   -n, --no-edit            Do not open \$EDITOR after create
#   -h, --help               Show help

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/lib/common.sh"

ROOT="$(paddy_blog_root)"
POSTS="$(paddy_posts_dir)"

SLUG=""
DESCRIPTION=""
DRAFT="false"
NO_EDIT=false
CATEGORIES=()
CAT_CUSTOM=false
TAGS=()
TAG_CUSTOM=false
MINIMAL_TAGS=false

usage() {
  cat <<'EOF'
Create a LoveIt/Hugo post bundle for Paddy’s blog.

Usage:
  new-post.sh [options] "Post title"

Options:
  -s, --slug SLUG       Directory under content/posts/ (default: slugified title)
  -c, --category CAT    Category — repeat for several (default: Racing if none given)
  -t, --tag TAG         Tag — repeat for several (default: uk-racing, watch-along)
  --minimal-tags        Write tags: [] (no default tags)
  -d, --draft           draft: true
  --description TEXT    Front matter description
  -n, --no-edit         Skip opening EDITOR (nano/vi) after file is written
  -h, --help            This help

Examples:
  new-post.sh "Galway Tuesday"
  new-post.sh -c Festivals -t cheltenham -t antepost "Cheltenham ante-post"
  new-post.sh -s sandown-notes -d "Notebook: Sandown card"
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--slug)
      SLUG="$2"
      shift 2
      ;;
    --description)
      DESCRIPTION="$2"
      shift 2
      ;;
    -c|--category)
      if ! $CAT_CUSTOM; then CATEGORIES=(); CAT_CUSTOM=true; fi
      CATEGORIES+=("$2")
      shift 2
      ;;
    -t|--tag)
      if ! $TAG_CUSTOM; then TAGS=(); TAG_CUSTOM=true; fi
      TAGS+=("$2")
      shift 2
      ;;
    --minimal-tags)
      MINIMAL_TAGS=true
      TAG_CUSTOM=true
      TAGS=()
      shift
      ;;
    -d|--draft)
      DRAFT="true"
      shift
      ;;
    -n|--no-edit)
      NO_EDIT=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
    *)
      break
      ;;
  esac
done

TITLE=$(printf '%s ' "$@")
TITLE=${TITLE%% }

if [[ -z "${TITLE// }" ]]; then
  echo 'Error: give a post title (in quotes).' >&2
  usage >&2
  exit 1
fi

if ! $CAT_CUSTOM; then
  CATEGORIES=("Racing")
fi

if $MINIMAL_TAGS; then
  :
elif ! $TAG_CUSTOM; then
  TAGS=("uk-racing" "watch-along")
fi

if [[ -z "$SLUG" ]]; then
  SLUG="$(paddy_slugify "$TITLE")"
fi

if [[ -z "$SLUG" ]]; then
  echo "Error: empty slug — use --slug with a safe ASCII name." >&2
  exit 1
fi

NOW="$(paddy_now_dublin)"
if [[ -z "$DESCRIPTION" ]]; then
  DESCRIPTION="${TITLE}. Entertainment only — not tipping advice."
fi

DEST="$POSTS/$SLUG"
FILE="$DEST/index.md"

if [[ -e "$DEST" ]]; then
  echo "Error: already exists: $DEST" >&2
  echo "Edit that file, or pick another --slug." >&2
  exit 1
fi

mkdir -p "$DEST"

yaml_list() {
  if [[ $# -eq 0 ]]; then
    echo "[]"
    return
  fi
  local out="["
  local first=1
  local x
  for x in "$@"; do
    [[ $first -eq 1 ]] || out+=", "
    out+="\"${x//\"/\\\"}\""
    first=0
  done
  out+="]"
  echo "$out"
}

CAT_YAML="$(yaml_list "${CATEGORIES[@]}")"
TAG_YAML="$(yaml_list "${TAGS[@]}")"

cat >"$FILE" <<EOF
---
title: "$(echo "$TITLE" | sed 's/\\/\\\\/g; s/"/\\"/g')"
date: ${NOW}
lastmod: ${NOW}
draft: ${DRAFT}
description: "$(echo "$DESCRIPTION" | sed 's/\\/\\\\/g; s/"/\\"/g')"
tags: ${TAG_YAML}
categories: ${CAT_YAML}
---

## The card

(Meetings, going, what’s on the **telly**.)

## Notes

## Entertainment only

Not tipping — just the armchair.
EOF

echo "Created $FILE"

if ! $NO_EDIT; then
  ${EDITOR:-nano} "$FILE"
fi
