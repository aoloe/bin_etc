" remove autocommands... i don't want to load all file specific formatting
:au!
" accept the three usual encoding
set fileencodings=ucs-bom,utf-8,latin1
" set the autoindenting width
:se sw=4
" set the tabulator indenting
:se ts=4
" behavior at the end of line
:se textwidth=0
" use spaces instead of tabs
:se expandtab
" r automatically continues the comments on the next line
:se formatoptions=tcqlro
" syntax highlighting
:sy on
" do not highlight words when searching for them. it's distracting.
:se nohls
" show the matching paranthesis
:se showmatch
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.lof
" turn on the "visual bell" - which is much quieter than the "audio blink"
set vb
" change buffer without saving
set hidden
" create the file if it does not exist
:map gf :e <cfile><CR>
" for me .md is for markdown files
au BufRead,BufNewFile *.md set filetype=markdown
"close the buffer but keep the split layout
com! Spbd :bn |bw#
" autoload the settings in php.vim for all php files
:autocmd FileType php source ~/docs/src/bin_etc/vimrc/php.vim
" autoload the settings in latex.vim for all latex files
:autocmd FileType tex source ~/docs/src/bin_etc/vimrc/latex.vim
" autoload the settings in latex.vim for all latex files
:autocmd FileType cpp source ~/docs/src/bin_etc/vimrc/cpp.vim
" autoload for sylpheed
:autocmd VimEnter */.sylpheed/tmp/* source ~/docs/src/bin_etc/vimrc/sylpheed.vim
" load the syntax highlighting for qml files
au BufRead,BufNewFile *.qml		 source ~/docs/src/bin_etc/vimrc/qml.vim
" do not highlight the matching parenthesis
let loaded_matchparen = 1
