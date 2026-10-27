#!/bin/sh

#for i in `xinput |  awk '/TouchPad|Touchpad|Touchscreen/' | sed -e 's/.*id=//' | sed -e 's/\s.*//'`; do
for i in `xinput |  awk '/Touchscreen/' | sed -e 's/.*id=//' | sed -e 's/\s.*//'`; do
  xinput disable $i
done
