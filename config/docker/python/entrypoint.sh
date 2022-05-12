#!/usr/bin/env sh

FILE_TYPES='*.png *.jpg *.jpeg'

for i in $FILE_TYPES
do
  find app/Data -type f -iname "$i" -not -path '*/modules/*' -not -path '*/systems/*' -exec fvttoptimizer --verbose-info {} \;
done
