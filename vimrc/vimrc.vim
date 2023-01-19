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
:autocmd FileType php source ~/src/bin_etc/vimrc/php.vim
" autoload the settings in latex.vim for all latex files
:autocmd FileType tex source ~/src/bin_etc/vimrc/latex.vim

" autoload for cpp, with special rules for scribus
:autocmd FileType cpp source ~/src/bin_etc/vimrc/cpp.vim
:autocmd BufRead,BufNewFile */scribus*.cpp source ~/src/bin_etc/vimrc/scribus.vim
:autocmd BufRead,BufNewFile */scribus*.h source ~/src/bin_etc/vimrc/scribus.vim

" autoload for sylpheed
:autocmd VimEnter */.sylpheed/tmp/* source ~/src/bin_etc/vimrc/sylpheed.vim
" load the syntax highlighting for qml files
au BufRead,BufNewFile *.qml		 source ~/src/bin_etc/vimrc/qml.vim
" load the syntax highlighting for web files
au BufRead,BufNewFile *.html		 source ~/src/bin_etc/vimrc/html.vim
au BufRead,BufNewFile *.css		 source ~/src/bin_etc/vimrc/html.vim
au BufRead,BufNewFile *.js		 source ~/src/bin_etc/vimrc/html.vim
au BufRead,BufNewFile *.dart		 source ~/src/bin_etc/vimrc/dart.vim

" do not highlight the matching parenthesis
let loaded_matchparen = 1


set background=dark " dark | light "
colorscheme solarized

"only lint on save
:let g:ale_lint_on_text_changed = 'never'
:let g:ale_lint_on_enter = 0

"nerw is a moder file browser in vim
"Vexplore opens it in a new vertical buffer
" https://shapeshed.com/vim-netrw/
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
\   'cpp': [],
\}

" fix the colors for the ctrl-p popup
:highlight Pmenu ctermbg=gray guibg=gray

setglobal complete-=i " do not use included file for autocomplete
" ":se cbt" shows the current sources to be scanned
