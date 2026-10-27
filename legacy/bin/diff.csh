#!/bin/csh

set REPO="~/projects/hobo"

foreach i (`cd $REPO/files && find . -type f`)
  diff $REPO/files/$i ~/$i > /dev/null
  if ( $status == 1 ) then 
    echo "files differ ($i)"
  endif
end
