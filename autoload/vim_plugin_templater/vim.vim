function vim_plugin_templater#vim#create() abort
    " TODO detect if in already existing plugin
    let overall_todos = []

    let github_name = vim_plugin_templater#utils#github_name()
    echom 'github_name: ' . github_name . '^@'
    let plugin_name = vim_plugin_templater#utils#plugin_name()
    let sanitized_plugin_name = vim_plugin_templater#utils#sanitize_name(plugin_name)

    let needs_syntax = input('Do you need to define new syntax? N/y ') == 'y'
    let needs_ftdetect = input('Do you need to define new filetypes? N/y ') == 'y'
    let needs_ftplugin = input('Do you need to define buffer local options? N/y ') == 'y'
    let needs_autoload = input('Do you need to lazy load functionality? Y/n ') != 'n'

    echo '^@'
    echom 'sanitized_plugin_name: '. sanitized_plugin_name
    echom 'syntax ' . needs_syntax . ' | ftdetect ' . needs_ftdetect . ' | ftplugin ' . needs_ftplugin . ' | autoload ' . needs_autoload
    echom 'gh_name ' . github_name . ' | plugin_name ' . plugin_name

    " if needs_syntax
        " TODO create './syntax'
    " endif
endfunction
