#!/bin/sh
echo -ne '\033c\033]0;OCC\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/OCC.x86_64" "$@"
