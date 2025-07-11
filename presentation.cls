\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentation}

\LoadClass[greek]{beamer}

\usepackage{amsmath,amsthm} % needed for mathematics
\usepackage{fontspec}
\usepackage{unicode-math}
\usepackage{xltxtra}
\usepackage{graphicx}
\usetheme{CambridgeUS}
\usecolortheme{seagull}
\usepackage{hyperref}
\usepackage{ulem} % underline words package
\usepackage{xgreek}

\usepackage{pgfpages}

\usepackage{tikz} % package for shapes and more
%\setbeameroption{show notes on second screen}
%\setbeameroption{show only notes}

\usepackage{ifthen} % package for if then else macros

\setsansfont{Calibri} % it is said that Calibri is the proper font for reading difficulties

\usepackage{multicol} % package for two or more columns

\usepackage{appendixnumberbeamer} % remove page numbering in appendix

\usepackage{polynom} % polynomial divisions package

\usepackage{pgffor} % macros

\usepackage{cancel} % cancel terms in equations

\setbeamercovered{highly dynamic}
\setbeamertemplate{navigation symbols}{}

\usetikzlibrary{mindmap,trees}\usetikzlibrary{shapes.geometric, arrows}

  \tikzstyle{startstop} = [rectangle, rounded corners,
  minimum width=3cm,
  minimum height=1cm,
  text centered,
  draw=black,
  fill=red!30]
  \tikzstyle{decision} = [diamond,
  minimum width=3cm,
  minimum height=1cm,
  text centered,
  draw=black,
  fill=green!30]
  \tikzstyle{arrow} = [thick,->,>=stealth]
  \tikzstyle{process} = [rectangle,
  minimum width=3cm,
  minimum height=1cm,
  text centered,
  text width=3cm,
  draw=black,
  fill=orange!30]
\usepackage{tkz-tab}

\newcommand{\exercises}{
  \begin{frame}[noframenumbering,c]
    \begin{beamercolorbox}[sep=8pt,center,shadow=true,rounded=true]{title}
      \usebeamerfont{title}Ασκήσεις
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
    \begin{frame}[label=Απόδειξη\theapodiksi,t]{Απόδειξη #1}
        }{
    \end{frame}
}

% Presentation version
\def\presentationversion{2.7}

% Patch \insertdate to always append version info on title slide
\let\beamer@originsertdate\insertdate
\renewcommand{\insertdate}{\beamer@originsertdate~---~\textbf{Έκδοση:}~\presentationversion}

% Changelog
% 2.7 - 2024-07-10: Removed numbering from askisi's description.
% 2.6 - 2024-06-10: Added changelog section, patched \insertdate for version info
% 2.5 - 2024-05-20: Added environments for askisi, lisi, apodiksi
% 2.4 - 2024-04-15: Added tikz styles for flowcharts
% 2.3 - 2024-03-01: Switched to Calibri font, added xgreek
% 2.2 - 2024-02-10: Added appendixnumberbeamer, polynom, cancel
% 2.1 - 2024-01-05: Initial beamer customization, theme and color
% 2.0 - 2023-12-01: Initial version