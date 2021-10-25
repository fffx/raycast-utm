#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title <%= action.capitalize %> VM
# @raycast.mode compact
# @raycast.refreshTime 2h

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName UTM
# @raycast.argument1 { "type": "text", "placeholder": "VM name", "percentEncoded": true, "optional": true }

# Documentation:
# @raycast.description Shotcut commands for UTM Virtual Machine
# @raycast.author Fangxing

## ls
# -t sort by last modified time
# -d directory only

vm_names=()
for dirname in ~/Library/Containers/com.utmapp.UTM/Data/Documents/*.utm; do
  _base_name=$(basename "$dirname")
  _vm_name=${_base_name%".utm"} # Fix space problem
  vm_names+=("${_vm_name}")
done
vm_name=$1

if [[ " ${vm_names[*]} " =~ " $1 " ]]; then
  # do nothing
  echo "Exact Matched ---"
elif [ -x "$(command -v fzf)" ]; then
  vm_name=$(printf '%s\n' "${vm_names[@]}" | fzf --filter $1 | head -n 1)
  printf '%s\n' "${vm_names[@]}"
  # echo "Matched ---fzf  ${vm_name}"
# elif # TODO support other command
fi

vm_name=$(echo $vm_name | sed -e 's/ /%20/g')
open "utm://<%= action %>?name=${vm_name}"