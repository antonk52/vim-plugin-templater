if exists('g:loaded_vim_plugin_templater')
    finish
endif
let g:loaded_vim_plugin_templater = 1

command! CreateVimPlugin :call vim_plugin_templater#vim#create()<cr>
command! CreateNeovimPlugin :call vim_plugin_templater#neovim#create()<cr>
