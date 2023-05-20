#!/bin/bash

sourcedir=$(ls -td /path/to/directory/ | head -1)
state=/file/to/store/executed/files/

if [ -f "$state" ]; then
	for script in $sourcedir/*; do
    if grep -q $script $state; then
      echo "skipping $script"
    else
      echo "executing $script"
      $script
      if [ $? -eq 0 ]; then
        echo "$script" >> "$state"
      else
        echo "script execution unsuccessful"
	exit 
      fi
    fi
  done
fi

success=$(wc -l < $state)

if [ $success -eq 4 ]; then
	> $state
fi

