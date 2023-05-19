#!/bin/bash

sourcedir=$(ls -td /home/rohith/Downloads/EMR/scripts/* | head -1)
state=/home/rohith/Downloads/EMR/scripts/.executed

if [ -f "$state" ]; then
	for script in $sourcedir/*/*; do
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

success=$(wc -l < /home/rohith/Downloads/EMR/scripts/.executed)

if [ $success -eq 4 ]; then
	> /home/rohith/Downloads/EMR/scripts/.executed
fi

