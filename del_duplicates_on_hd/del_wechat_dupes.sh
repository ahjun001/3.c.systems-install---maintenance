#!/usr/bin/env bash

old_wd=$(pwd)

df -h / | tee -a free_space.txt 
cd '/home/perubu/Documents/WeChat Files/wxid_6761767617821/FileStorage/File' || exit

for i in {0..9}; do
    find . -name "*($i)*" -exec rm {} \;
done

cd "$old_wd" || exit

df -h / | tee -a free_space.txt 

cat free_space.txt