\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentation}[2024/01/01 Παρουσίαση στο σχολείο]

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

\setsansfont{Calibri} % it is said that Calibri is the proper font for reading difficulties

\usepackage{multicol} % package for two or more columns

\usepackage{appendixnumberbeamer} % remove page numbering in appendix

\usepackage{polynom} % polynomial divisions package

\usepackage{pgffor} % macros

\setbeamercovered{highly dynamic}
\setbeamertemplate{navigation symbols}{}

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
