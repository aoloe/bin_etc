function! Latex()
  exe ':w'
  exe ':!latex %'
endfunction 

function! LatexPdf()
  exe ':w'
  exe ':!pdflatex %'
endfunction 

function! MasterLatex()
" compile le fichier principal... si le fichier courant a ete'
	" appelé fichier.##.tex et le fichier principal s'appelle fichier.tex
  exe ':w'
  exe ':!latex %:r:r'
endfunction 

function! LatexMaster()
" compile le fichier de mon travail de master...
"  exe ':se fileencoding=latin1'
  exe ':w'
  exe ':!./latex.sh'
"  exe ':se fileencoding=utf-8'
  exe ':w'
endfunction 

function! Dvi()
 exe ':!xdvi %:r &'
endfunction

function! MasterDvi()
 exe ':!xdvi %:r:r &'
endfunction

function! Ps()
 exe ':w'
 "exe ':!latex %; dvi2ps -c %:r.ps %:r.dvi; gv %:r.ps &'
 exe ':!latex %; dvips -o %:r.ps %:r.dvi; gv %:r.ps &'
endfunction 

function! Section(...)
 let n = a:0
 let i = 0
 let b=a:1
 norm gg
 while i <= a:0
  if i == 1
   let cherche ="norm ".a:1."/^\\\\chapter{"
   exe cherche
  elseif i == 2
   let cherche ="norm ".a:2."/^\\\\section{"
   exe cherche
  elseif i==3
   let cherche ="norm ".a:3."/^\\\\subsection{"
   exe cherche
  elseif i==4
   let cherche ="norm ".a:4."/^\\\\subsubsection{"
   exe cherche
  endif
  let i = i+1
 endwhile
endfunction

function! Tableau()
 exe 'avec un replace transform une liste avec des tabs en tableau!'
endfunction

function! Format()
:let form=input("style [bit]")
:let cont=input("cont:")
:let avan=""
:let apre=""
:if form=="b"
:let form="bf"
:elseif form=="i"
:let form="em"
:elseif form=="t"
:let form="tt \\small"
:endif
:let cont="{\\".form." ".cont."}"
:let @@=cont
endfunction

:com! Latex call Latex()
:com! Ld call LatexPdf()
:com! MLatex call MasterLatex()
:com! LM call LatexMaster()
:com! Dvi call Dvi()
:com! MDvi call MasterDvi()
:com! Ps call Ps()
:com! -nargs=* GSection call Section(<f-args>)
:let @i="\n\\begin{itemize}\n\\item\n\\end{itemize}"
:let @e="\n\\begin{enumerate}\n\\item\n\\end{enumerate}"
:let @l="\n\\\selectlanguage{english}\n\n\\selectlanguage{francais}\n"
:let @f="\n\\begin{figure}[htb]\n\\includegraphics{fig/filename}\n\\caption{}\n\\end{figure}"
:let @t="\n\\begin{tabular}{l|p{1cm}}\na & b \\\\\n\\end{tabular}"
:let @b="\n\\begin{tabbing}\nabc\\=defg\\\\\n\\>a\n\\end{tabbing}"
:let @v="\n\\small\\begin{verbatim}\n\\end{verbatim}\\normalsize"
:let @d="\\documentclass[a4paper,12pt]{book}\n\\usepackage[latin1]{inputenc}\n\\usepackage[T1]{fontenc}\n\n\\usepackage{epsfig}\n\n\\title{}\n\\author{a.l.e}\n\\usepackage[francais]{babel}\n\n\\newcommand{\\image}[2]{\\vspace{#1 cm}\\epsfig{file=#2}\\vspace{#1 cm}}\n\n\\begin{document}\n\\maketitle\n\n\\end{document}"

:iab ... \ldots{}
:iab [...] [\ldots{}]
:iab [.] [\ldots{}]
:iab -> $\rightarrow$
:iab => $\Rightarrow$
:iab <- $\leftarrow$
:iab <= $\Leftarrow$
:iab xx $\times$
:iab abc \chapter{}<Left>
:iab abs \section{}<Left>
:iab abss \subsection{}<Left>
:iab absss \subsubsection{}<Left>
:iab abp \paragraph{}<Left>
:iab abi \item
:iab abem \emph{}<Left>
:iab abb {\bf }<Left>
:iab abtt {\tt }<Left>
:iab << «
:iab >> <BS>»

:set expandtab

:set linebreak "breaks lines at word bounderies
