\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{presentation}

\LoadClass{beamer}

\usepackage{amsmath,amsthm}

\usepackage{fontspec}

\ifdefined\mainfontname
  \setsansfont{\mainfontname}
  \setmainfont{\mainfontname}
\fi

\usepackage{unicode-math}
% Δοκίμασε μία από τις παρακάτω μαθηματικές γραμματοσειρές:
\setmathfont{STIX Two Math}

\usepackage{xgreek}
\usetheme{CambridgeUS}
\usecolortheme{seagull}
\usepackage[normalem]{ulem}
\usepackage{tikz}
\usepackage{multicol}
\usepackage{appendixnumberbeamer}

\setbeamercovered{highly dynamic}
\setbeamertemplate{navigation symbols}{}