#!/usr/bin/env bash
for icon in lab shell; do
  for size in 16 32 48 128 256 512; do
    inkscape -z $icon.svg -e $icon-$size.png -w $size
  done

  convert $icon-512.png -define icon:auto-resize=256,128,64,48,32,16 $icon.ico
  png2icns $icon.icns $icon-16.png $icon-32.png $icon-48.png $icon-128.png $icon-256.png $icon-512.png
done
