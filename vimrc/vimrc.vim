" remove autocommands... pour ne pas avoir des formattages adhoc!
" je veux toujours avoir les memes configs!
:au!
" accepte les trois encodages habituels
set fileencodings=ucs-bom,utf-8,latin1
" pour changer le nombre de caracteres dans l'auto indent
:se sw=4
" pour changer l'indentation du tabulateur
:se ts=4
" comment doit-il se comporter en fin de ligne?
:se textwidth=0
" pour ne pas avoir de tabs dans les autoindent
:se expandtab
" ajouté le r pour les marques de commentaire automatiques
:se formatoptions=tcqlro
" pour colorier la syntaxe
:sy on
"au debut les search ne sont pas highlighted!
:se nohls
"montre les parentèses correespondantes
:se showmatch
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.lof
" when buffer are switched, vim makes them hidden and not inactive
" ... there is no prompt to save the disappearing buffer!
" (pay attention: you could then have modified buffers in background)
set hidden
" autoload the settings in php.vim for all php files
:autocmd FileType php source ~/docs/src/bin_etc/vimrc/php.vim
" autoload the settings in latex.vim for all latex files
:autocmd FileType tex source ~/docs/src/bin_etc/vimrc/latex.vim
" autoload the settings in latex.vim for all latex files
:autocmd FileType cpp source ~/docs/src/bin_etc/vimrc/cpp.vim
":autocmd BufNewFile,BufRead */.sylpheed/tmp/* source ~/docs/.vimrc/abFrancais.vim
":autocmd VimEnter */docs/uni/master/* source ~/docs/.vimrc/abFrancais.vim
:autocmd VimEnter */.sylpheed/tmp/* source ~/docs/src/bin_etc/vimrc/sylpheed.vim
"close the buffer but keep the split layout
com! Spbd :bn |bw#
"com! Spbd enew|bw #
" create the file if it does not exist
:map gf :e <cfile><CR>
" for me .md is for markdown files
au BufRead,BufNewFile *.md		set filetype=markdown
" dont highliht the matching braces
:NoMatchParen
" load the syntax highlighting for qml files
au BufRead,BufNewFile *.qml		 source ~/docs/src/bin_etc/vimrc/qml.vim
