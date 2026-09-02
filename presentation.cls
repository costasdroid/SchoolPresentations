\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentation}

\newif\if@shownotes\@shownotesfalse
\DeclareOption{notes}{\@shownotestrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}
\ProcessOptions\relax

\LoadClass{beamer}

\usepackage{amsmath, amsthm}

% Αντί για το fontsetup, χρησιμοποιούμε fontspec
\usepackage{fontspec}
\setmainfont{DejaVu Sans} % Ή "Arial", "Calibri", "Liberation Sans"
\setsansfont{DejaVu Sans}
\usepackage{unicode-math}
\usepackage{polyglossia}
\setmainlanguage{greek}
\setotherlanguage{english}


\usetheme{CambridgeUS}
\usecolortheme{seagull}
\usepackage[normalem]{ulem} % underline words package

\usepackage{pgfpages}
\if@shownotes
  \setbeameroption{show notes on second screen}
\fi

\usepackage{tikz} % package for shapes and more

\usepackage{ifthen} % package for if then else macros

\usepackage{multicol} % package for two or more columns

\usepackage{appendixnumberbeamer} % remove page numbering in appendix

\usepackage{polynom} % polynomial divisions package

\usepackage{cancel} % cancel terms in equations

\setbeamercovered{highly dynamic}
\setbeamertemplate{navigation symbols}{}

\usetikzlibrary{mindmap,trees}\usetikzlibrary{shapes.geometric, arrows}

\tikzset{
  startstop/.style={rectangle, rounded corners,
    minimum width=3cm,
    minimum height=1cm,
    text centered,
    draw=black,
    fill=red!30},
  decision/.style={diamond,
    minimum width=3cm,
    minimum height=1cm,
    text centered,
    draw=black,
    fill=green!30},
  arrow/.style={thick,->,>=stealth},
  process/.style={rectangle,
    minimum width=3cm,
    minimum height=1cm,
    text centered,
    text width=3cm,
    draw=black,
    fill=orange!30},
}
\usepackage{tkz-tab}

\newcommand{\exercises}{
  \begin{frame}[noframenumbering,c]
    \begin{beamercolorbox}[sep=8pt,center,shadow=true,rounded=true]{title}
      \usebeamerfont{title}Ασκήσεις
    \end{beamercolorbox}
  \end{frame}
}

\newcommand{\theory}{
  \begin{frame}[noframenumbering,c]
    \begin{beamercolorbox}[sep=8pt,center,shadow=true,rounded=true]{title}
      \usebeamerfont{title}Θεωρία
    \end{beamercolorbox}
  \end{frame}
}

\newcommand{\moodle}{
  \begin{frame}[noframenumbering,c]
    Στο moodle θα βρείτε τις ασκήσεις που πρέπει να κάνετε, όπως και αυτή τη παρουσίαση
  \end{frame}
}

\newcounter{askisi} % enviroment for exercises
\newenvironment{askisi}
{
    \refstepcounter{askisi}\par
    \subsection{Άσκηση \theaskisi}
    \begin{frame}[label=Άσκηση\theaskisi,t]
}{
    \end{frame}
}

\newcounter{lisi} % enviroment for solutions
\newenvironment{lisi}
{
    \refstepcounter{lisi}\par
    \subsection{Λύση \thelisi}
    \begin{frame}[label=Λύση\thelisi,t]{Λύση \thelisi}
        }{
    \end{frame}
}

\newcounter{apodiksi} % enviroment for proofs
\newenvironment{apodiksi}[1][]
{
    \refstepcounter{apodiksi}\par
    \subsection{Απόδειξη \theapodiksi}
    \begin{frame}[label=Απόδειξη\theapodiksi,t]{Απόδειξη \theapodiksi\ifthenelse{\equal{#1}{}}{}{:~#1}}
        }{
    \end{frame}
}

% Presentation version
\def\presentationversion{3.1}

% Patch \insertdate to always append version info on title slide
\let\beamer@originsertdate\insertdate
\renewcommand{\insertdate}{\beamer@originsertdate~---~\textbf{Έκδοση:}~\presentationversion}

% Changelog
% 3.1 - 2026-05-27: Removed redundant graphicx (loaded by beamer)\n% 3.0 - 2026-05-27: tikzstyle→tikzset, [normalem]{ulem}, removed pgffor+hyperref, added \\theory, notes option, apodiksi title shows number
% 2.9 - 2026-05-27: Switched to polyglossia, NewCM10 fonts
% 2.8 - 2026-03-17: Removed redundant xltxtra and babel greek option (xgreek handles everything)
% 2.7 - 2024-07-10: Removed numbering from askisi's description.
% 2.6 - 2024-06-10: Added changelog section, patched \insertdate for version info
% 2.5 - 2024-05-20: Added environments for askisi, lisi, apodiksi
% 2.4 - 2024-04-15: Added tikz styles for flowcharts
% 2.3 - 2024-03-01: Switched to Calibri font, added xgreek
% 2.2 - 2024-02-10: Added appendixnumberbeamer, polynom, cancel
% 2.1 - 2024-01-05: Initial beamer customization, theme and color
% 2.0 - 2023-12-01: Initial version