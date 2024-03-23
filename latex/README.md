## 기타

```tex
% Define Environment:
\newtheorem{thm}{\bf Theorem}
\newtheorem{prop}{\bf Proposition}
\newtheorem{lem}{\bf Lemma}
\newtheorem{assmpt}{\bf Assumption}
\newtheorem{defn}{\bf Definition}
\newtheorem{exmp}{\bf Example}
\newtheorem{cor}{\bf Corollary}
\newtheorem{condi}{\bf Condition}
%=== Non-italic Theorem Environment by Vin
\newtheorem{rem1}{\bf Remark}
\newenvironment{rem}{\begin{rem1}\normalfont}{\end{rem1}}
%=== New Example Environment by Vin
\newcounter{Examp}
\newenvironment{exam}{\stepcounter{Examp} \medskip \noindent {\bf Example \arabic{Examp}.}}{ \medskip }

%=== New Example Environment by Vin
\newcounter{exer}
\newenvironment{exer}{\stepcounter{exer} \medskip \noindent {\bf Exercise \arabic{exer}.}}{ \medskip }


% Define Some Notation:

\newcommand{\nn}{{\mathfrak{n}}}

\newcommand{\R}{\ensuremath{{\mathbb R}}}
\newcommand{\Z}{\ensuremath{{\mathbb Z}}}
\newcommand{\N}{\ensuremath{{\mathbb N}}}

\newcommand{\AAA}{{\mathcal A}}
\newcommand{\CC}{{\mathcal C}}
\newcommand{\DD}{{\mathcal D}}
\newcommand{\EE}{{\mathcal E}}
\newcommand{\FF}{{\mathcal F}}
\newcommand{\KK}{{\mathcal K}}
\newcommand{\LL}{{\mathcal L}}
\newcommand{\MM}{{\mathcal M}}
\newcommand{\NN}{{\mathcal N}}
\newcommand{\OO}{{\mathcal O}}
\newcommand{\PP}{{\mathcal P}}
\newcommand{\QQ}{{\mathcal Q}}
\newcommand{\RR}{{\mathcal R}}
\newcommand{\SSS}{{\mathcal S}}
\newcommand{\TT}{{\mathcal T}}
\newcommand{\UU}{{\mathcal U}}
\newcommand{\VV}{{\mathcal V}}
\newcommand{\WW}{{\mathcal W}}
\newcommand{\XX}{{\mathcal X}}
\newcommand{\YY}{{\mathcal Y}}
\newcommand{\cN}{\ensuremath{\mathcal{N}}}

\newcommand{\KL}{{\mathcal{KL}}}
\newcommand{\sat}{\ensuremath{{\rm sat}}}

\newcommand{\triend}{\hfill \ensuremath{\lhd}}
\DeclareMathOperator{\rank}{rank}

\newcommand{\cvector}[1]{\left(\!\!\!\begin{array}{c} #1 \end{array}\!\!\!\right)}
\newcommand{\setdef}[2]{\left\{\ #1\ \left|\ #2\ \right.\right\}}
```