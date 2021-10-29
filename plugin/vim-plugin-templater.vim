if exists('g:loaded_vim_plugin_templater')
    finish
endif
let g:loaded_vim_plugin_templater = 1

" funky behavior when executing it in autoload dir
let g:vim_plugin_templater_templates_path = expand('<sfile>:p:h:h') . '/templates'

command! CreateVimPlugin :call vim_plugin_templater#vim#create()<cr>
