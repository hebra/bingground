#!/bin/bash

#
# This script retrieves the Microsoft Bing! picture of the day and sets it as background image.
#
# (C) 2016 Hendrik Brandt
#
# Released under term of Simplified BSD License
#

imgFolder=~/.local/share/bingground
mkdir -p $imgFolder

imgJSON=$(curl -s "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-AU")

imgPath=$(echo "$imgJSON" | jq -r  '.["images"][0].url')

imgFile=$(basename $imgPath)

imgURL="http://www.bing.com$imgPath"

curl -o $imgFolder/$imgFile -s $imgURL

command -v gsettings>/dev/null 2>&1 && gsettings set org.gnome.desktop.background picture-uri "file://$imgFolder/$imgFile"
