#!/usr/bin/env bash

# remove files that wechat downloads automatically
# some are good to keep to inspect: *.epub
# others, starting with names from delete_list can be deleted

set -e

old_wd=$(pwd)

cd '/home/perubu/Documents/WeChat Files/wxid_6761767617821/FileStorage/File' || exit

rm -fv free_space.txt
df -h / | tee -a free_space.txt

# for i in {0..9}; do
#     find . -name "*($i)*" -exec rm {} \;
# done

delete_list=(
    BBC
    Bloomberg
    'Business Traveller'
    Challenges
    Closer
    Cuisine
    Femina
    FigTV
    Ici_Paris
    Journal
    lefigaro
    Le_Figaro
    lemonde
    LeMonde
    'Le Monde'
    'LE MONDE'
    'Le nouvel'
    "L'Equipe"
    lequipe
    lhumanite
    "L'Opinion"
    lesechos
    'Les Echos'
    libe
    Madame
    Maison
    Marie_Claire
    "Mens Health"
    "Midi Olympique"
    Paris_Match
    TV
)

for name in "${delete_list[@]}"; do
    # find . -name "$name*.pdf" -exec ls {} \;
    find . -name "$name*.pdf" -exec rm {} \;
done

df -h / | tee -a free_space.txt

cat free_space.txt

cd "$old_wd" || exit
