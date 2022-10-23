:set expandtab
:se sw=4
:se ts=4
:se ai
:se si
:se listchars=eol:$,tab:>-

:let @v="echo(\"<pre>\ var:\".print_r($var,1).\"</pre>\");\n"

" ctrl+x ctrl+o to aucomplete from the php API
" :set omnifunc=phpcomplete#CompletePHP # it seems to pollute too much ctrl-p and ctrl-n
