function! Ask_trimmed(txt) abort
    return trim(input(a:txt . ' '))
endfunction

function! Has_empty_chars(str) abort
    return match(a:str, '\s') > -1
endfunction

function! vim_plugin_templater#utils#warn(txt) abort
    " force error to display on a new line
    echo ' '
    echohl WarningMsg | echo a:txt | echohl None
endfunction

function! vim_plugin_templater#utils#github_name() abort
    let prompt = 'Enter github name:'
    let github_name = Ask_trimmed(prompt)

    if github_name == ''
        call vim_plugin_templater#utils#warn('Github name cannot be empty')
        let github_name = vim_plugin_templater#utils#github_name()
    endif

    if Has_empty_chars(github_name)
        call vim_plugin_templater#utils#warn('Github name cannot have empty spaces')
        let github_name = vim_plugin_templater#utils#github_name()
    endif

    " TODO more validation for special characters

    return github_name
endfunction

function! vim_plugin_templater#utils#plugin_name() abort
    let prompt = 'Enter plugin name:'
    let plugin_name = Ask_trimmed(prompt)

    if plugin_name == ''
        call vim_plugin_templater#utils#warn('Plugin name cannot be empty')
        let plugin_name = vim_plugin_templater#utils#plugin_name()
    endif

    if Has_empty_chars(plugin_name)
        call vim_plugin_templater#utils#warn('Plugin name cannot have empty spaces')
        let plugin_name = vim_plugin_templater#utils#plugin_name()
    endif

    " TODO more validation for special characters
    return plugin_name
endfunction

function! vim_plugin_templater#utils#is_git() abort
    return glob('.git') == '.git'
endfunction

function! vim_plugin_templater#utils#sanitize_name(name) abort
    let temp_name = a:name
    let scetchy_chars = ['-', '\.', ',', '!', '?', '#', '(', ')', '/', '|', '\', '@', '\^', '\$']
    for char in scetchy_chars
        let temp_name = substitute(temp_name, char, '_', 'g')
    endfor

    return substitute(temp_name, '__', '_', 'g')
endfunction
