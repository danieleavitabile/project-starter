%% daarticle.cls -- Daniele Avitabile's article class
%%
%% A standalone class built on the standard article class. A document written
%% for the SIAM classes (siamart, siamonline) compiles with daarticle by
%% changing only its \documentclass line: the page layout matches siamonline,
%% and the same front-matter commands, environments and theorem macros are
%% provided. No code is taken from the SIAM classes.
%%
%% The look takes its cue from the Italian publisher Adelphi: classic serif,
%% small capitals instead of bold, centred title and running heads, an ivory
%% page, and colours sampled from the covers of the Biblioteca Adelphi.
%%
%% Options
%%   a4paper (default), letterpaper
%%   baskervaldx   Baskervaldx text with matching newtx maths
%%   cmbright      CM Bright text and maths (no small capitals: see \da@caps)
%%                 With neither font option, the LaTeX default fonts are used.
%%   grey          grey page with red headings, instead of ivory and sage
%%   print         white page, e.g. for printing or submission; the heading
%%                 colour (sage, or red with grey) is kept
%%   hidelinks     links in the text colour
%%   SIAM-only options (review, supplement, ...) are accepted and ignored.
\NeedsTeXFormat{LaTeX2e}[2021/06/01]
\ProvidesClass{daarticle}[2026/11/05 v0.1 DA's article class]

%% --------------------------------------------------------------------------
%% Options

\newif\if@da@print
\newif\if@da@grey
\newif\if@da@hidelinks
\def\da@font{default}
\def\da@paper{a4paper}
\DeclareOption{a4paper}{\def\da@paper{a4paper}}
\DeclareOption{letterpaper}{\def\da@paper{letterpaper}}
\DeclareOption{baskervaldx}{\def\da@font{baskervaldx}}
\DeclareOption{cmbright}{\def\da@font{cmbright}}
\DeclareOption{print}{\@da@printtrue}
\DeclareOption{grey}{\@da@greytrue}
\DeclareOption{hidelinks}{\@da@hidelinkstrue}
\def\da@siamonly{%
  \ClassWarningNoLine{daarticle}{Option `\CurrentOption' is SIAM-only and is ignored}}
\DeclareOption{review}{\da@siamonly}
\DeclareOption{supplement}{\da@siamonly}
\DeclareOption{final}{\da@siamonly}
\DeclareOption{onefignum}{\da@siamonly}
\DeclareOption{onetabnum}{\da@siamonly}
\DeclareOption{oneeqnum}{\da@siamonly}
\DeclareOption{onethmnum}{\da@siamonly}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass[11pt,twoside,\da@paper]{article}

%% --------------------------------------------------------------------------
%% Fonts and core packages

\RequirePackage[leqno]{amsmath}
\RequirePackage{amsthm}
\def\da@tmp{baskervaldx}\ifx\da@font\da@tmp
  \RequirePackage[lining]{Baskervaldx}
  \RequirePackage[baskervaldx,vvarbb,bigdelims]{newtxmath}
\fi
\def\da@tmp{cmbright}\ifx\da@font\da@tmp
  % Keep the class line spacing; cmbright's own enlarged spacing is not wanted
  \RequirePackage[standard-baselineskips]{cmbright}
\fi
\RequirePackage{microtype}
% CM Bright has no microtype settings of its own; borrow Computer Modern's
\DeclareMicrotypeAlias{cmbr}{cmr}
\RequirePackage{xcolor}
\RequirePackage{graphicx}

%% --------------------------------------------------------------------------
%% Colours

% Page, text, headings (title, section headings, theorem labels, QED) and
% links (citations, cross-references, URLs)
\if@da@grey
  \definecolor{daPaper}{HTML}{EDEDE9}% grey
  \definecolor{daHead}{HTML}{A3323A}% deep red
\else
  \definecolor{daPaper}{HTML}{F7F2E8}% ivory
  \definecolor{daHead}{HTML}{2F6F5B}% sage
\fi
\definecolor{daInk}{HTML}{231F1C}
\definecolor{daLink}{HTML}{134C79}
% Pale cover tints for todo notes (see damacros.sty), and red for \change
\definecolor{daRed}{HTML}{C60707}
\definecolor{daSage}{HTML}{93D7C0}
\definecolor{daLilac}{HTML}{C0B5F9}
\definecolor{daSky}{HTML}{93CCF9}
\definecolor{daPearl}{HTML}{E0E0E0}
\definecolor{daPink}{HTML}{FFC9E0}
\colorlet{changecolor}{daRed}
\colorlet{daNoteDA}{daSage!55!white}    \colorlet{daEdgeDA}{daSage!60!black}
\colorlet{daNoteFC}{daLilac!55!white}   \colorlet{daEdgeFC}{daLilac!55!black}
\colorlet{daNoteFA}{daSky!55!white}     \colorlet{daEdgeFA}{daSky!55!black}
\colorlet{daNoteGA}{daPearl!70!white}   \colorlet{daEdgeGA}{daPearl!50!black}
\colorlet{daNoteWarn}{daPink!60!white}  \colorlet{daEdgeWarn}{daRed}

% Text colour; setting \default@color too keeps it in footnotes, floats and
% running heads, which reset to it through \normalcolor
\AtBeginDocument{%
  \if@da@print\else\pagecolor{daPaper}\fi
  \color{daInk}%
  \let\default@color\current@color}

%% --------------------------------------------------------------------------
%% Page layout (the same as siamonline)

\setlength{\textwidth}{444.53284pt}
\setlength{\textheight}{594.8005pt}
\setlength{\oddsidemargin}{\z@}
\setlength{\evensidemargin}{\z@}
% The running head with its double hairline needs 14pt; the top margin gives
% back the extra 4pt, so the text block sits exactly where siamonline puts it
\setlength{\topmargin}{-4\p@}
\setlength{\headheight}{14\p@}
\setlength{\headsep}{.2in}
\setlength{\footskip}{.2in}
\setlength{\marginparwidth}{90\p@}
\setlength{\marginparsep}{11\p@}
\setlength{\parindent}{.25in}
\setlength{\parskip}{\z@}
\setlength{\footnotesep}{6.65\p@}
\setlength{\skip\footins}{13\p@ \@plus 4\p@ \@minus 2\p@}

% Floats
\setlength{\floatsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength{\textfloatsep}{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength{\intextsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\renewcommand{\topfraction}{.9}
\renewcommand{\bottomfraction}{.1}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.91}

% Lists: no extra vertical space around or between items
\setlength{\leftmargini}{.5in}
\setlength{\partopsep}{\z@}
\def\@listi{\leftmargin\leftmargini \topsep\z@ \parsep\z@ \itemsep\z@}
\let\@listI\@listi
\@listi

% Equations, theorems, figures and tables are numbered within sections
\numberwithin{equation}{section}
\numberwithin{figure}{section}
\numberwithin{table}{section}

%% --------------------------------------------------------------------------
%% Display styles

% Letter-spaced small capitals, used for headings, labels and running heads.
% CM Bright has no small capitals, so there they become bold.
\def\da@tmp{cmbright}\ifx\da@font\da@tmp
  \newcommand{\da@caps}{\normalfont\bfseries}
\else
  \newcommand{\da@caps}{\normalfont\scshape\lsstyle}
\fi

%% --------------------------------------------------------------------------
%% Front matter

% \headers{short title}{authors}: running heads and PDF metadata
\newcommand{\headers}[2]{%
  \pagestyle{myheadings}%
  \markboth{#2}{#1}%
  \AtBeginDocument{\hypersetup{pdftitle={#1},pdfauthor={#2}}}}

\newcommand{\email}[1]{\href{mailto:#1}{#1}}
\newcommand{\orcid}[1]{\ignorespaces}
\newcommand{\funding}[1]{\protect\\ \hspace*{1.8em}{\da@caps Funding:} #1}

% Title: centred, regular weight, in the heading colour; authors in small
% capitals underneath
\def\@maketitle{%
  \null
  {\centering
    {\Large\mdseries\color{daHead}\@title\par}%
    \vskip 1.1em
    {\normalsize\da@caps
      \def\and{\unskip{\normalfont\space and\space}\ignorespaces}%
      \@author\par}%
    \par}%
  \vskip 2.1em}

% Abstract, keywords and MSC codes: small type, narrower than the text, with
% the label run in and in the heading colour
\newenvironment{da@abssec}[1]{%
  \par\vspace{.05in}\footnotesize
  \leftskip 2em\rightskip 2em
  \noindent{\color{daHead}\da@caps #1. }\ignorespaces}
  {\par\vspace{.1in}}
\renewcommand{\abstractname}{Abstract}
\newcommand{\keywordsname}{Key words}
\newcommand{\MSCcodesname}{MSC codes}
\renewenvironment{abstract}{\begin{da@abssec}{\abstractname}}{\end{da@abssec}}
\newenvironment{keywords}{\begin{da@abssec}{\keywordsname}}{\end{da@abssec}}
\newenvironment{MSCcodes}{\begin{da@abssec}{\MSCcodesname}}{\end{da@abssec}}

% Footnotes: mark hanging in the indent, short rule
\renewcommand{\@makefntext}[1]{%
  \parindent .25in\noindent\hbox to .25in{\hss\@makefnmark}#1}
\renewcommand{\footnoterule}{%
  \kern-3\p@{\color{daInk}\hrule\@width 3pc\@height .3pt}\kern2.6\p@}

%% --------------------------------------------------------------------------
%% Page styles

% Running heads: centred small capitals, page number at the outer edge, and a
% double hairline underneath. First page: page number centred at the foot.
\newcommand{\da@doublerule}{%
  \vskip 3pt{\color{daInk}\hrule\@height .5pt\vskip 1.3pt\hrule\@height .25pt}}
\def\ps@myheadings{%
  \let\@oddfoot\@empty\let\@evenfoot\@empty
  \def\@evenhead{\vbox{\hbox to\textwidth{\footnotesize\rlap{\thepage}\hfil
    {\da@caps\leftmark}\hfil}\da@doublerule}}%
  \def\@oddhead{\vbox{\hbox to\textwidth{\footnotesize\hfil
    {\da@caps\rightmark}\hfil\llap{\thepage}}\da@doublerule}}%
  \let\@mkboth\@gobbletwo
  \let\sectionmark\@gobble
  \let\subsectionmark\@gobble}
\def\ps@plain{%
  \let\@mkboth\@gobbletwo
  \let\@oddhead\@empty\let\@evenhead\@empty
  \def\@oddfoot{\hfil{\footnotesize\thepage}\hfil}%
  \let\@evenfoot\@oddfoot}
\pagestyle{plain}

%% --------------------------------------------------------------------------
%% Sections

% Headings run into the paragraph and end with a full stop. Sections are in
% small capitals, subsections in italics, all in the heading colour; the
% numbers are upright and hang in the margin.
\renewcommand{\section}{\@startsection{section}{1}{\z@}%
  {1.3ex \@plus .5ex \@minus .2ex}{-.5em \@plus -.1em}%
  {\normalfont\normalsize\color{daHead}\da@caps}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{\z@}%
  {1.3ex \@plus .5ex \@minus .2ex}{-.5em \@plus -.1em}%
  {\normalfont\normalsize\color{daHead}\itshape}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{\z@}%
  {1.3ex \@plus .5ex \@minus .2ex}{-.5em \@plus -.1em}%
  {\normalfont\normalsize\color{daHead}\itshape}}
\renewcommand{\paragraph}{\@startsection{paragraph}{4}{\z@}%
  {1.3ex \@plus .5ex \@minus .2ex}{-.5em \@plus -.1em}%
  {\normalfont\normalsize\itshape}}

% Number format: hanging in the margin; in the appendix, sections read
% "Appendix A." and start at the left edge
\def\@seccntformat#1{%
  \ifcsname da@cnt@#1\endcsname\csname da@cnt@#1\endcsname
  \else\llap{\normalfont\normalsize\csname the#1\endcsname\hskip .8em}\fi}

% The kernel's \@sect, with a full stop added after run-in headings
\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
      #6{\@hangfrom{\hskip #3\relax\@svsec}\interlinepenalty \@M #8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else
      \protect\numberline{\csname the#1\endcsname}\fi #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax\@svsec #8\@addpunct{.}}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{\ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}\fi #7}}%
  \fi
  \@xsect{#5}}

\renewcommand{\appendix}{\par
  \setcounter{section}{0}\setcounter{subsection}{0}%
  \gdef\thesection{\Alph{section}}%
  \gdef\da@cnt@section{\appendixname\ \thesection.\ }}

%% --------------------------------------------------------------------------
%% Figures and tables

% Captions in small type: label in small capitals, text in italics, centred
% when it fits on one line. Figure captions go below, table captions above.
\setlength{\abovecaptionskip}{10\p@}
\setlength{\belowcaptionskip}{10\p@}
\long\def\@makecaption#1#2{%
  \def\da@tmp{figure}%
  \ifx\@captype\da@tmp\vskip\abovecaptionskip\fi
  \footnotesize
  \sbox\@tempboxa{{\da@caps #1.} {\itshape #2}}%
  \ifdim \wd\@tempboxa >\hsize
    {\da@caps #1.} {\itshape #2}\par
  \else
    \global\@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \ifx\@captype\da@tmp\else\vskip\belowcaptionskip\fi}

%% --------------------------------------------------------------------------
%% Bibliography (works with siamplain.bst)

\renewenvironment{thebibliography}[1]{%
  \par\addvspace{.25in}%
  \begin{center}\footnotesize\da@caps\refname\end{center}%
  \addvspace{.15in}\nopagebreak
  \footnotesize
  \list{\@biblabel{\@arabic\c@enumiv}}%
    {\settowidth\labelwidth{\@biblabel{#1}}%
     \leftmargin\labelwidth \advance\leftmargin\labelsep
     \advance\leftmargin 16\p@ \itemindent -16\p@
     \parsep\z@ \itemsep\z@
     \usecounter{enumiv}%
     \let\p@enumiv\@empty
     \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
  \sloppy\clubpenalty4000\widowpenalty4000\sfcode`\.\@m}
  {\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

%% --------------------------------------------------------------------------
%% Links and cross-references

\RequirePackage{hyperref}
\hypersetup{colorlinks, allcolors=daLink, bookmarksnumbered}
\urlstyle{same}
\if@da@hidelinks\hypersetup{hidelinks}\fi
\RequirePackage[capitalize,nameinlink]{cleveref}

% Lower-case "section" in running text, capitalised at the start of a sentence
\crefname{section}{section}{sections}
\crefname{subsection}{subsection}{subsections}
\crefname{subsubsection}{subsection}{subsections}
\Crefname{section}{Section}{Sections}
\Crefname{subsection}{Subsection}{Subsections}
\Crefname{subsubsection}{Subsection}{Subsections}
% Equations are referred to by their number alone, except at the start of a
% sentence ("Equation (3.1)")
\crefformat{equation}{\textup{#2(#1)#3}}
\crefrangeformat{equation}{\textup{#3(#1)#4--#5(#2)#6}}
\crefmultiformat{equation}{\textup{#2(#1)#3}}{ and \textup{#2(#1)#3}}%
  {, \textup{#2(#1)#3}}{, and \textup{#2(#1)#3}}
\Crefformat{equation}{#2Equation~\textup{(#1)}#3}
\Crefrangeformat{equation}{Equations~\textup{#3(#1)#4--#5(#2)#6}}
\Crefmultiformat{equation}{Equations~\textup{#2(#1)#3}}{ and \textup{#2(#1)#3}}%
  {, \textup{#2(#1)#3}}{, and \textup{#2(#1)#3}}
% Numbers stay upright inside italic theorem statements
\crefdefaultlabelformat{#2\textup{#1}#3}

%% --------------------------------------------------------------------------
%% Theorems and proofs (defined after cleveref, which needs to see them)

% Label in small capitals and in the heading colour, indented like a
% paragraph; an optional name follows in italics
\newtheoremstyle{da@theorem}{1.2ex \@plus .25ex \@minus .1ex}{1.2ex \@plus .25ex \@minus .1ex}%
  {\itshape}{\parindent}{\color{daHead}\da@caps}{.}{.5em}%
  {\thmname{#1}\thmnumber{ #2}\thmnote{ {\normalfont\itshape(#3)}}}
\newtheoremstyle{da@remark}{1.2ex \@plus .25ex \@minus .1ex}{1.2ex \@plus .25ex \@minus .1ex}%
  {\normalfont}{\parindent}{\color{daHead}\da@caps}{.}{.5em}%
  {\thmname{#1}\thmnumber{ #2}\thmnote{ {\normalfont\itshape(#3)}}}

\theoremstyle{da@theorem}
\newtheorem{theorem}{Theorem}[section]

% \newsiamthm{name}{Title}: italic statement, numbered with the theorems.
% \newsiamremark{name}{Title}: upright text, numbered with the theorems.
% (The names match the SIAM classes, so documents can switch between them.)
\newcommand{\newsiamthm}[2]{\theoremstyle{da@theorem}\newtheorem{#1}[theorem]{#2}}
\newcommand{\newsiamremark}[2]{\theoremstyle{da@remark}\newtheorem{#1}[theorem]{#2}}
\newsiamthm{lemma}{Lemma}
\newsiamthm{corollary}{Corollary}
\newsiamthm{proposition}{Proposition}
\newsiamthm{definition}{Definition}

% End-of-proof mark: a small square drawn as a double outline, thick outside
% and thin inside, echoing the double hairline under the running heads
\renewcommand{\qedsymbol}{\mbox{\color{daHead}%
  \setlength{\fboxrule}{.5pt}\setlength{\fboxsep}{1.1pt}%
  \fbox{\setlength{\fboxrule}{.25pt}\setlength{\fboxsep}{0pt}%
    \fbox{\rule{0pt}{1ex}\rule{1ex}{0pt}}}}}

% Proof: italic label, indented like a paragraph
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep 1ex \@plus .25ex \@minus .1ex
  \trivlist
  \item[\hskip\labelsep\hskip\parindent\itshape #1\@addpunct{.}]\ignorespaces}
  {\popQED\endtrivlist\@endpefalse}

\endinput
