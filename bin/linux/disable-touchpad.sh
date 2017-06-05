#!/bin/sh

for i in `xinput |  awk '/TouchPad|Touchpad/' | sed -e 's/.*id=//' | sed -e 's/\s.*//'`; do
  xinput disable $i
done
