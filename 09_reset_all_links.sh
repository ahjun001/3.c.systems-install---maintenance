#!/usr/bin/env bash

set -x

# exiting if not sudo
if [ "$(id -u)" != "0" ]; then
   echo 'this script requires root privileges'
   exit 1
fi

# link to Github vimrc
my_orig='/home/perubu/Documents/Github/3.c.install-n-utils/02_vim/vimrc'
my_link=/home/perubu/.vim/"$(basename $my_orig)"
# force to recreate possibly existing link and check that it is not broken
if ! ln -fs "$my_orig" "$my_link"; then
   if [ ! -e "${my_link}" ]; then
      exit 1
   fi
   exit 1
fi

# link to Github .zshrc
my_orig='/home/perubu/Documents/Github/3.c.install-n-utils/02_zsh/.zshrc'
my_link=/home/perubu/"$(basename "$my_orig")"
if ! ln -fs "$my_orig" "$my_link"; then
   if [ ! -e "${my_link}" ]; then
      exit 1
   fi
   exit 1
fi

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
if ! ln -fs "$my_orig" "$my_link" || [ ! -e "${my_link}" ]; then
   exit 1
fi

# put shellSpec in path
my_orig='/home/perubu/.local/lib/shellspec/shellspec'
my_link=/usr/local/sbin/"$(basename "$my_orig")"
if ! ln -fs "$my_orig" "$my_link" || [ ! -e "${my_link}" ]; then
   exit 1
fi

set +x
echo -e "\nExiting $0\n"
