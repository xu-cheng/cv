% Copyright (C) 2019 by Cheng XU <copyright@xuc.me>
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%    http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Cheng XU.

\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{mycv}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions%
\LoadClass{article}

% Check for obsoleted LaTeX packages
\RequirePackage[l2tabu,orthodox]{nag}

% Fonts
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{kpfonts}
\RequirePackage[fixed]{fontawesome5}

% Color
\RequirePackage{color}
\RequirePackage[table,dvipsnames]{xcolor}

% hyperref setting
\RequirePackage[a-1b]{pdfx}
\RequirePackage{hyperref}
\hypersetup{
  unicode,
  hidelinks,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  pdfstartview={XYZ null null 1},
  pdfpagemode={UseOutlines},
  pdfpagelayout={OneColumn},
}

% Page layout
\RequirePackage{geometry}
\RequirePackage[strict]{changepage}
\geometry{
  a4paper,
  top=2cm,
  bottom=2cm,
  left=4.5cm,
  right=1.5cm,
  includefoot,
  heightrounded,
}

% List setting
\RequirePackage[inline]{enumitem}
\setlist{noitemsep,partopsep=0pt,leftmargin=1.2em}
% Ref: https://tex.stackexchange.com/q/476883/16996
\setlist[1]{before={\leavevmode\vspace*{-\baselineskip}\vspace*{-\parskip}}}

% Packages
\RequirePackage{array}
\RequirePackage{etoolbox}
\RequirePackage{graphicx}
\RequirePackage{linegoal}
\RequirePackage{microtype}
\RequirePackage{parskip}
\RequirePackage{tabu}
\RequirePackage{xifthen}
\RequirePackage{xparse}

% Personal info
\newcommand*{\name}[1]{\gdef\@name{#1}}
\newcommand*{\address}[1]{\gdef\@address{#1}}
\newcommand*{\phone}[1]{\gdef\@phone{#1}}
\newcommand*{\email}[1]{\gdef\@email{#1}}
\newcommand*{\homepage}[1]{\gdef\@homepage{#1}}
\newcommand*{\github}[1]{\gdef\@github{#1}}
\newcommand*{\linkedin}[1]{\gdef\@linkedin{#1}}
\renewcommand*{\date}[1]{\gdef\@date{#1}}
\date{\today}

% Custom styles
\RequirePackage{titlesec}
\titleformat{\section}[leftmargin]{\large\scshape\sffamily}{}{0cm}{}
\titlespacing{\section}{\dimexpr\Gm@lmargin-\Gm@rmargin-0.5cm\relax}{2\parskip}{0.5cm}

% \subsection{title}
% \subsection{title}[location]
\RenewDocumentCommand{\subsection}{m o}{%
  \begingroup%
  \vspace{\parskip}
  \normalsize%
  \phantomsection%
  \addcontentsline{toc}{subsection}{#1}%
  \noindent\textbf{#1}\IfValueT{#2}{\hspace*{\fill}#2}%
  \par%
  \endgroup%
}

% \printdate{date}
\newcommand*{\printdate}[1]{\hspace*{\fill}{\itshape#1}}%

% \begin{positions}
%   \entry{<title>}{<date>}
% \end{positions}
\newenvironment{positions}{%
  \vspace{-\parskip}%
  % \entry{<title>}{<date>}
  \newcommand*{\entry}[2]{\item \textbf{##1}\printdate{##2}}%
  \begin{itemize}[leftmargin=0pt,label={}]%
    }{%
\end{itemize}%
}

% Header
\renewcommand{\maketitle}{%
  \clearpage%
  \begin{adjustwidth}{\dimexpr\Gm@rmargin-\Gm@lmargin\relax}{}
    \begin{minipage}[c]{.3\linewidth}
      \scalebox{1.2}{\Huge\@name}%
    \end{minipage}%
    \begin{minipage}[c]{.7\linewidth}
      \begin{flushright}
        \ifthenelse{\isundefined{\@address}}{}{%
          \@address \\%
        }%
        \newbool{isstart}%
        \setbool{isstart}{true}%
        \ifthenelse{\isundefined{\@phone}}{}{%
          \ifbool{isstart}{\setbool{isstart}{false}}{~~$\cdot$~~}%
          \faIcon{phone}~\@phone%
        }%
        \ifthenelse{\isundefined{\@email}}{}{%
          \ifbool{isstart}{\setbool{isstart}{false}}{~~$\cdot$~~}%
          \href{mailto:\@email}{\faIcon{envelope}~\@email}%
        }%
        \ifthenelse{\isundefined{\@mobile} \AND \isundefined{\@email}}{}{\\}%
        \setbool{isstart}{true}%
        \ifthenelse{\isundefined{\@homepage}}{}{%
          \ifbool{isstart}{\setbool{isstart}{false}}{~~$\cdot$~~}%
          \href{\@homepage}{\faIcon{home}~\@homepage}%
        }%
        \ifthenelse{\isundefined{\@github}}{}{%
          \ifbool{isstart}{\setbool{isstart}{false}}{~~$\cdot$~~}%
          \href{https://github.com/\@github}{\faIcon{github}~\@github}%
        }%
        \ifthenelse{\isundefined{\@linkedin}}{}{%
          \ifbool{isstart}{\setbool{isstart}{false}}{~~$\cdot$~~}%
          \href{https://www.linkedin.com/in/\@linkedin}{\faIcon{linkedin}~\@linkedin}%
        }%
      \end{flushright}
    \end{minipage}
    \vspace{1ex}%
    \par\vspace{-.5\ht\strutbox}\noindent\hrulefill\par%
  \end{adjustwidth}
}

% Footer
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhfoffset[l]{\dimexpr\Gm@lmargin-\Gm@rmargin\relax}
\fancyfoot[L]{\textcolor{Gray}{\@date}}
\fancyfoot[C]{\textcolor{Gray}{\@name~~~$\cdot$~~~Curriculum Vitae}}
\fancyfoot[R]{\textcolor{Gray}{\thepage}}

% Publication
\RequirePackage[
  style=ieee,
  dashed=false,
  doi=false,
  isbn=false,
  url=false,
  giveninits=true,
  maxbibnames=10,
  sorting=ddatent,
]{biblatex}

% declare custom field `usera` as the starting page
% Ref: https://tex.stackexchange.com/a/485880/16996
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map{
      \step[fieldsource=pages, final]
      \step[fieldset=usera, origfieldval]
      \step[fieldsource=usera,
        match=\regexp{\A\s*(\p{Nd}+)\s*(\p{Pd}+)\s*(\p{Nd}+)\s*\z},
        replace=\regexp{$1}
      ]
    }
  }
}

\DeclareSortingTemplate{ddatent}{
  \sort{
    \field{presort}
  }
  \sort[final]{
    \field{sortkey}
  }
  \sort[direction=descending]{
    \field[strside=left,strwidth=4]{sortyear}
    \field[strside=left,strwidth=4]{year}
    \literal{9999}
  }
  \sort[direction=descending]{
    \field[padside=left,padwidth=2,padchar=0]{month}
    \literal{00}
  }
  \sort[direction=descending]{
    \field[padside=left,padwidth=2,padchar=0]{day}
    \literal{00}
  }
  \sort{
    \field{booktitle}
    \field{journaltitle}
  }
  \sort[direction=descending]{
    \field[padside=left,padwidth=4,padchar=0]{volume}
    \literal{9999}
  }
  \sort[direction=descending]{
    \field[padside=left,padwidth=4,padchar=0]{number}
    \literal{9999}
  }
  \sort{
    \field[padside=left,padwidth=4,padchar=0]{usera}
    \literal{0000}
  }
  \sort{
    \field{sortname}
    \field{author}
    \field{editor}
    \field{translator}
    \field{sorttitle}
    \field{title}
  }
  \sort{
    \field{sorttitle}
    \field{title}
  }
}

\renewcommand*{\mkbibnamegiven}[1]{\ifitemannotation{highlight}{\mkbibbold{#1}}{#1}}
\renewcommand*{\mkbibnamefamily}[1]{\ifitemannotation{highlight}{\mkbibbold{#1}}{#1}}
\renewcommand*{\mkbibnameprefix}[1]{\ifitemannotation{highlight}{\mkbibbold{#1}}{#1}}
\renewcommand*{\mkbibnamesuffix}[1]{\ifitemannotation{highlight}{\mkbibbold{#1}}{#1}}
\DeclareFieldFormat{addendum}{\textcolor{Gray}{#1}}
\defbibenvironment{bibliography}{\begin{enumerate}}{\end{enumerate}}{\item}

\newcommand*{\publications}[2][]{%
  \begin{refsection}[#2]
    \nocite{*}
    \ifthenelse{\equal{#1}{}}{%
      \printbibliography[heading=none]%
    }{%
      \printbibliography[heading=none,#1]%
    }
  \end{refsection}
}
