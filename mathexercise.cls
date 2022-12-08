% author: SiyuWu
% date: 2021/09/24
% project: mathexercise.cls
% usage: Class file to write exercise solutions

%%% Identification
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mathexercise}[2022/10/02 class file to write mathematical exercise solutions]

\newif\if@chinesesupport
\newif\if@tikzcover       % whether use tikz to reproduce cover
\@chinesesupportfalse
\@tikzcoverfalse

%%% 选项设置

% Settle withinchap and withinsec options
\DeclareOption{withinchap}{\def\exercounter@within{chapter}}
\DeclareOption{withinsec}{\def\exercounter@within{section}}
\DeclareOption{tikzcover}{\@tikzcovertrue}

% 是否提供中文支持
\DeclareOption{chinese}{\@chinesesupporttrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ExecuteOptions{withinchap}
\ProcessOptions\relax
\LoadClass{report} % should go after processing options

%%% 加载所需宏包
\RequirePackage{indentfirst}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{extarrows}
\RequirePackage{xcolor}
\RequirePackage{tcolorbox}
\RequirePackage[width=14cm]{geometry}
\RequirePackage{tikz}
\usetikzlibrary{intersections,decorations.text}
% \RequirePackage{tcolorbox}
% \tcolorboxenvironment{exercise}{arc is angular,colback=white,colframe=blue!50!black}
\definecolor{c1}{RGB}{62, 97, 127}
\definecolor{c2}{RGB}{104, 182, 182}
\definecolor{c3}{RGB}{107, 190, 190}
\definecolor{c4}{RGB}{100, 172, 174}
\definecolor{c5}{RGB}{95, 162, 162}

%%% amsthm
\newtheoremstyle{mytheorem}{3pt}{3pt}{\rmfamily}{\parindent}{\bfseries}{}%
  {.5em}{\thmname{#1}\thmnumber{ #2}\thmnote{ (#3)}}

\if@chinesesupport
  \RequirePackage[heading=true]{ctex}
  \ctexset {
    chapter = {
      beforeskip = 0pt,
      fixskip = true,
      format = \Huge\bfseries,
      nameformat = \rule{\linewidth}{1bp}\par\bigskip\hfill\chapternamebox,
      number = \arabic{chapter},
      aftername = \par\medskip,
      aftertitle = \par\bigskip\nointerlineskip\rule{\linewidth}{2bp}\par}
  }
  \newcommand\chapternamebox[1]{%
  \parbox{\ccwd}{\linespread{1}\selectfont\centering #1}}
  \newcommand{\solutionname}{解}
  %theorem environment
  \theoremstyle{mytheorem}\newtheorem{theorem}{定理}
  \theoremstyle{mytheorem}\newtheorem{lemma}{引理}
  \theoremstyle{mytheorem}\newtheorem{example}{例}
  \theoremstyle{mytheorem}\newtheorem*{remark}{注}
  \theoremstyle{mytheorem}\newtheorem*{corollary}{推论}
  \theoremstyle{mytheorem}\newtheorem{proposition}{命题}
  \theoremstyle{mytheorem}\newtheorem{note}{笔记}
  \newcommand{\authorname}{作者}
  \newcommand{\textbookname}{教材}
  \newcommand{\proofnamestyle}{\bfseries}
  \newcommand{\proofpunct}{:}
\else
  \newcommand{\solutionname}{Solution}
  \theoremstyle{mytheorem}\newtheorem{theorem}{Theorem}
  \theoremstyle{mytheorem}\newtheorem{lemma}{Lemma}
  \theoremstyle{mytheorem}\newtheorem{example}{Example}
  \theoremstyle{mytheorem}\newtheorem*{remark}{Remark}
  \theoremstyle{mytheorem}\newtheorem*{corollary}{Corollary}
  \theoremstyle{mytheorem}\newtheorem{proposition}{Proposition}
  \theoremstyle{definition}\newtheorem{note}{Note}[chapter]
  \newcommand{\authorname}{Author}
  \newcommand{\textbookname}{Textbook}
  \newcommand{\proofnamestyle}{\itshape}
  \newcommand{\proofpunct}{.}
\fi

%%% 定义常用数学命令

% Roman Font
\newcommand{\e}{\mathrm{e}}
\newcommand{\T}{\mathrm{T}}
\newcommand{\upi}{\mathrm{i}}
\newcommand{\id}{\mathrm{id}}
\newcommand{\weakconverge}{\rightharpoonup}
% Differential Operator(在多种实现方法之中，个人认为此方法最佳)
\newcommand{\diff}{\mathop{}\!\mathrm{d}}
% Declare Math Operator
\DeclareMathOperator{\codim}{codim}
\DeclareMathOperator{\conv}{conv}
\DeclareMathOperator{\diag}{diag}
\DeclareMathOperator{\diam}{diam} % diameter
\DeclareMathOperator{\dist}{dist}
\DeclareMathOperator{\Int}{Int}
\DeclareMathOperator{\rank}{rank}
\DeclareMathOperator{\sgn}{sgn}
\DeclareMathOperator{\spt}{spt} % support set
\DeclareMathOperator{\supp}{supp} % another support set
\DeclareMathOperator{\lcm}{lcm} % least common multiple
\DeclareMathOperator{\Span}{span}
% Real and Imaginary part of complex numbers
\renewcommand{\Re}{\operatorname{Re}}
\renewcommand{\Im}{\operatorname{Im}}

\newcommand{\closure}[1]{\overline{#1}} % the closure of a set
\newcommand{\conjugate}[1]{\overline{#1}}
% tricks from mathtools
\DeclarePairedDelimiterX{\lrangle}[1]{\langle}{\rangle}{#1}
\DeclarePairedDelimiterX{\innerp}[2]{\langle}{\rangle}{#1,#2}
\DeclarePairedDelimiterX{\norm}[1]{\lVert}{\rVert}{#1}

% textbook name
\newcommand{\textbook}[1]{\gdef\@textbook{#1}}
\newcommand{\textbookauthor}[1]{\gdef\@textbookauthor{#1}}
\newcommand{\textbookversion}[1]{\gdef\@textbookversion{#1}}

%%% proof environment and solution environment
\renewenvironment{proof}[1][\proofname]{\par
	\pushQED{\qed}%
	\normalfont\topsep1\p@\@plus6\p@\relax
	\trivlist
	\item\relax
	{\hspace*{\parindent}{\proofnamestyle #1}\@addpunct{\proofpunct}}\hspace\labelsep\ignorespaces
}{%
	\popQED\endtrivlist\@endpefalse
}

\newenvironment{solution}[1][\solutionname]{\par
	\pushQED{\qed}%
	\normalfont\topsep1\p@\@plus6\p@\relax
	\trivlist
	\item\relax
	{\hspace*{\parindent}{\proofnamestyle #1}\@addpunct{\proofpunct}}\hspace\labelsep\ignorespaces
}{%
	\popQED\endtrivlist\@endpefalse
}

% 定制列表
\setlist{nosep,left=\parindent}

% exercise environment
\newcounter{exercounter}
\counterwithin*{exercounter}{\exercounter@within}
\NewDocumentEnvironment{exercise}{o d<> +b}
  {%
    \IfNoValueTF{#1}
      {\stepcounter{exercounter}}
      {\setcounter{exercounter}{#1}}
    \par\textbf{\theexercounter.}\hspace{.333em}%
	\IfNoValueTF{#2}
	  {#3}
	  {\textbf{(#2)}\hspace{.333em}#3}
  }
  {\ignorespacesafterend}


%---------tasks--------
\RequirePackage{tasks}
\settasks{after-item-skip=0.5ex plus 0.5ex minus 1ex}

% hyperref
\RequirePackage{hyperref}
\hypersetup{
    colorlinks,%
    linkcolor=red
}

% titlepage

\if@tikzcover
  \renewcommand{\maketitle}{%
    \thispagestyle{empty}
    \begin{tikzpicture}[overlay,remember picture,font=\sffamily\bfseries]
      \draw[ultra thick,c4,name path=big arc] ([xshift=-2mm]current page.north) arc(150:285:11)
      coordinate[pos=0.225] (x0);
      \begin{scope}
      \clip ([xshift=-2mm]current page.north) arc(150:285:11) --(current page.north
      east);
      \fill[c4!50,opacity=0.25] ([xshift=4.55cm]x0) circle (4.55);
      \fill[c4!50,opacity=0.25] ([xshift=3.4cm]x0) circle (3.4);
      \fill[c4!50,opacity=0.25] ([xshift=2.25cm]x0) circle (2.25);
      \draw[ultra thick,c4!50] (x0) arc(-90:30:6.5);
      \draw[ultra thick,c4] (x0) arc(90:-30:8.75);
      \draw[ultra thick,c4!50,name path=arc1] (x0) arc(90:-90:4.675);
      \draw[ultra thick,c4!50] (x0) arc(90:-90:2.875);
      \path[name intersections={of=big arc and arc1,by=x1}];
      \draw[ultra thick,c4,name path=arc2] (x1) arc(135:-20:4.75);
      \draw[ultra thick,c4!50] (x1) arc(135:-20:8.75);
      \path[name intersections={of=big arc and arc2,by={aux,x2}}];
      \draw[ultra thick,c4!50] (x2) arc(180:50:2.25);
      \end{scope}
      \path[decoration={text along path,text color=c4,
              raise = -2.8ex,
              text  along path,
              text = {|\sffamily\bfseries|\@date},
              text align = center,
            },
            decorate
          ] ([xshift=-2mm]current page.north) arc(150:245:11);
      %
      \begin{scope}
      \path[clip,postaction={fill=c3}]
      ([xshift=2cm,yshift=-8cm]current page.center) rectangle ++ (4.2,7.7);
      \draw[c5,ultra thick,fill=c2] ([xshift=0.5cm,yshift=-8cm]current page.center)
        ([xshift=0.5cm,yshift=-8cm]current page.center)  arc(180:60:2)
        |- ++ (-3,6) --cycle;
      \draw[ultra thick,c5] ([xshift=-1.5cm,yshift=-8cm]current page.center)
      arc(180:0:2);
      \draw[ultra thick,c5] ([xshift=0.5cm,yshift=-8cm]current page.center)
      arc(180:0:2);
      \draw[ultra thick,c5] ([xshift=2.5cm,yshift=-8cm]current page.center)
      arc(180:0:2);
      \draw[ultra thick,c5] ([xshift=4.5cm,yshift=-8cm]current page.center)
      arc(180:0:2);
      \fill[red] ([xshift=2.5cm,yshift=-8cm]current page.center) +(60:2) circle(1.5mm)
      node[above
      right=2mm,text=c5!80!black]{$\rho:=\dfrac{1+\sqrt{-3}}{2}$};
      \end{scope}
      %
      \fill[c1] ([xshift=2cm,yshift=-8cm]current page.center) rectangle ++ (-12.7,7.7);
      \node[text=white,anchor=west,scale=3,inner sep=0pt] at
      ([xshift=-9.5cm,yshift=-3.25cm]current page.center) {\@title};
      \node[text=white,anchor=west,scale=1.5,inner sep=0pt] at
      ([xshift=-9.5cm,yshift=-6cm]current page.center) {\authorname:\ \@author};
      \node[text=white,anchor=west,scale=1.5,inner sep=0pt] at
      ([xshift=-9.5cm,yshift=-6.75cm]current page.center)%
      {\textbookname:\ \@textbook\ (\@textbookauthor\ \@textbookversion)};
      %
      % \draw[gray,line width=5mm]
      % ([xshift=2mm,yshift=-1mm]current page.south west) rectangle ([xshift=-2mm,yshift=1mm]current
      % page.north east);
    \end{tikzpicture}
    \clearpage\thispagestyle{empty}\mbox{}\clearpage
  }
\else\fi