#!/bin/bash
var=$1
replace='https://www.youtube.com/watch?v='
search='ytdl://'
string=$(echo $var | sed -e "s|$search|$replace|")
echo Downoading from: $string..
youtube-dl --extract-audio --audio-format mp3 -f bestaudio --ignore-errors -o "/run/media/efforia/Music/Music/%(title)s.%(ext)s" $string
