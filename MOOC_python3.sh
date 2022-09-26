#!/usr/bin/env bash
# shellcheck disable=SC1091

# cd ~/MOOC_Python3/semaine\ 1
# shellcheck source=/home/perubu/.venv3.9.5/bin/activate
source /home/perubu/.venv3.9.5/bin/activate
jupyter lab /home/perubu/Desktop/MOOC_Python3/ 

echo "$(basename -- "$0") exited with code=$?"