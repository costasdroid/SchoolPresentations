\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentation}

\LoadClass{beamer}

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

\newcounter{askisi} % enviroment for exercises
\newenvironment{askisi}
{
    \refstepcounter{askisi}\par
    \subsection{Άσκηση \theaskisi}
    \begin{frame}[label=Άσκηση\theaskisi,t]{Εξάσκηση \theaskisi}
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
