#!/usr/bin/env bash
# shellcheck disable=

# 03_reset_all_links.sh
# set links so that apps are seen in $PATH or ,shorcuts; also link repos from partition with data partition

# run with arg u  to undo

# launch after install
[[ -n ${LAUNCH_APP+foo} ]] || LAUNCH_APP=true

# info verbose debug trace
[[ ${MY_TRACE+foo} ]] || MY_TRACE=true

# -e to exit on error
# -u to exit on unset variables
# -x to echo commands for degub purposes
[[ -n ${MY_ENV+foo} ]] || MY_ENV=eux
set -"$MY_ENV"

# util function to force to recreate possibly existing link and check that it is not broken
make_a_link() {
   if ! ln -fs "$my_orig" "$my_link" || [ ! -e "${my_link}" ]; then
      exit 1
   fi
}

# exiting if not sudo
if [ "$(id -u)" != "0" ]; then
   echo 'this script requires root privileges'
   exit 1
fi

# link vim to Github vimrc
my_orig='/home/perubu/Documents/Github/3.c-install-n-utils/02_vim/vimrc'
my_link=/home/perubu/.vim/"$(basename $my_orig)"
make_a_link

# link nvim to Github vimrc
my_orig='/home/perubu/Documents/Github/3.c-install-n-utils/02_vim/vimrc'
my_link=/home/perubu/.config/nvim/init.vim
make_a_link

# link to Github .zshrc
my_orig='/home/perubu/Documents/Github/3.c-install-n-utils/02_zsh/.zshrc'
my_link=/home/perubu/"$(basename "$my_orig")"
make_a_link

# link to all Github bash scripts whose filename starts with ,
if ! find /home/perubu/Documents/Github/3.c-install-n-utils/ \
   -type f -name ',*.sh' \
   -exec sudo ln \
   -fs {} /usr/local/sbin/ \;; then
   exit 1
fi
# where the literal {} gets substituted by the filename and
# the literal \; is needed for find to know that the custom command ends there.

# link to VSCode snippets
if ! find /home/perubu/Documents/Github/3.c-install-n-utils/02_code/User/snippets/ \
   -type f \
   -name '*.json' \
   -exec sudo ln \
   -fs {} /home/perubu/.config/Code/User/snippets/ \;; then
   exit 1
fi

# link to VSCode tasks.json
my_orig='/home/perubu/Documents/Github/3.c-install-n-utils/02_code/User/tasks.json'
my_link=/home/perubu/.config/Code/User/"$(basename "$my_orig")"
make_a_link

# put shellSpec in path
my_orig='/home/perubu/.local/lib/shellspec/shellspec'
my_link=/usr/local/sbin/"$(basename "$my_orig")"
make_a_link

echo -e "$(basename -- "$0") exited with code=\033[0;32m$?\033[0;31m"