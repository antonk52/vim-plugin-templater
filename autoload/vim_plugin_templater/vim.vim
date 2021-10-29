function PopulateTemplate(filename, destination_filepath, options) abort

    let template_path = g:vim_plugin_templater_templates_path . '/' . a:filename . '.template'

    if (filereadable(template_path))
        let content = []
        for raw_line in readfile(template_path)
            let line = raw_line

            for item in items(a:options)
                let line = substitute(line, '{{'.item[0].'}}', item[1], 'g')
            endfor

            call add(content, line)
        endfor

        call writefile(content, a:destination_filepath)
    else
        call vim_plugin_templater#utils#warn('template file is not readable ' . template_path)
    endif

endfunction

function vim_plugin_templater#vim#create() abort
    " TODO detect if in already existing plugin
    let overall_todos = []

    let github_name = vim_plugin_templater#utils#github_name()
    let plugin_name = vim_plugin_templater#utils#plugin_name()
    let sanitized_plugin_name = vim_plugin_templater#utils#sanitize_name(plugin_name)

    let options = {"github_name": github_name, "plugin_name": plugin_name, "sanitized_plugin_name": sanitized_plugin_name}

    let needs_syntax = input('Do you need to define new syntax? N/y ') == 'y'
    let needs_ftdetect = input('Do you need to define new filetypes? N/y ') == 'y'
    let needs_ftplugin = input('Do you need to define buffer local options? N/y ') == 'y'
    let needs_autoload = input('Do you need to lazy load functionality? Y/n ') != 'n'

    " readme
    call PopulateTemplate('README.md', getcwd().'/README.md', options)

    let cwd = getcwd()

    " plugin
    call mkdir(cwd.'/plugin')
    call PopulateTemplate('plugin.vim', cwd.'/plugin/'.sanitized_plugin_name.'.vim', options)

    " docs
    call mkdir(cwd.'/doc')
    call PopulateTemplate('doc-docs', cwd.'/doc/'.sanitized_plugin_name.'.txt', options)
    call PopulateTemplate('doc-tags', cwd.'/doc/tags', options)

    if (needs_syntax)
        call mkdir(cwd.'/syntax')
        call PopulateTemplate('syntax.vim', cwd.'/syntax/sample.vim', options)
    endif
    if (needs_ftdetect)
        call mkdir(cwd.'/ftdetect')
        call PopulateTemplate('ftdetect.vim', cwd.'/ftdetect/'.sanitized_plugin_name.'.vim', options)
    endif
    if (needs_ftplugin)
        call mkdir(cwd.'/ftplugin')
        call PopulateTemplate('ftplugin.vim', cwd.'/ftplugin/sample.vim', options)
    endif
    if (needs_autoload)
        call mkdir(cwd.'/autoload')
        call PopulateTemplate('autoload.vim', cwd.'/autoload/'.sanitized_plugin_name.'.vim', options)
    endif
endfunction
