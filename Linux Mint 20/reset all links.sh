#!/usr/bin/env bash

set -x
# link to Github vimrc
ln -fs '/home/perubu/Documents/GitHub/1.4-learning-vim/vimrc' '/home/perubu/.vim/'

# link to Github .zshrc
ln -fs '/home/perubu/Documents/GitHub/3.a.1-linux/3. zsh/.zshrc' '/home/perubu/'

# link to all Github bash scripts whose filename starts with ,
find /home/perubu/Documents/GitHub/3.a.1-linux/Linux\ Mint\ 20/ -type f -name ',*.sh' -exec sudo ln -fs {} /usr/local/sbin/ \;
# where the literal {} gets substituted by the filename and the literal \; is needed for find to know that the custom command ends there.

# link to VSCode snippets
find /home/perubu/Documents/GitHub/3.a.2-vsCode/config/Code/User/snippets/ -type f -name '*.json' -exec sudo ln -fs {} /home/perubu/.config/Code/User/snippets/ \;

# link to VSCode tasks.json
ln -fs '/home/perubu/Documents/GitHub/3.a.2-vsCode/config/Code/User/tasks.json' '/home/perubu/.config/Code/User/'

# put shellSpec in path
ln -fs '/home/perubu/.local/lib/shellspec/shellspec' '/usr/local/sbin/'

set +x
