" vim: ft=vim

if filereadable(getcwd() . '/vendor/bin/phpcs')
    let g:ale_linters = {
                \ 'php': ['phpcs']
                \ }
    let g:ale_fixers  = {
                \ 'php': ['phpcbf']
                \ }

    let g:ale_php_phpcs_executable  = getcwd() . '/vendor/bin/phpcs'
    let g:ale_php_phpcs_standard    = getcwd() . '/phpcs.xml'
    let g:ale_php_phpcbf_executable = getcwd() . '/vendor/bin/phpcbf'
    let g:ale_php_phpcbf_standard   = g:ale_php_phpcs_standard
endif


if filereadable(getcwd() . '/composer.json')
    nnoremap <Space>Pc :<C-u>Dispatch composer 
endif
