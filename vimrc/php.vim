:set expandtab
:se sw=4
:se ts=4
:se ai
:se si
:se listchars=eol:$,tab:>-

:let @v="\necho(\"<pre>\");\nprint_r($var);\necho(\"</pre>\");"

" ctrl+x ctrl+o to aucomplete from the php API
# " :set omnifunc=phpcomplete#CompletePHP # it seems to pollute too much ctrl-p and ctrl-n
