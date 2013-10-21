:%s/ class='vspace'//ge
:%s/ title=''//ge
:%s/ rel='nofollow'//ge
:%s/ class='urllink'//ge
:%s/div class='sourceblock '/pre class='prettyprint lang-'/e
:%s/ id='sourceblock.*'//ge
:%s/ class='pagetitle'//e
:%s/<div id='wikitext'>//e
:%s/<div class='blogit-post' >//e
:%s/<div class='blogit-meta-data-head' >//e
:%s/<h5>/<p><strong>/e
:%s/<span class='blogit-date'>//e
:%s/<\/span>//ge
:%s/<\/h5>/<\/strong><\/p>/ge
:%s/<\/div>//ge
:%s/<div class='blogit-post-body' >//ge
:%s/<\/li><li>/<\/li><li>/ge
:%s/<\/li><\/ul>/<\/li><\/ul>/ge
:%s/<\/p><ul>/<\/p><ul>/ge
:%s/<ul><li>/<ul><li>/ge
:%s/<\/ul><p>/<\/ul><p>/ge

