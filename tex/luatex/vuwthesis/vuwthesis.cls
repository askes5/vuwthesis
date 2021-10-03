%% vuwthesis.cls
%% Copyright 2021 Matthew Askes
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is Matthew Askes
%
%========================================================================
%
% THESIS STYLE FOR MSC and PHD THESES.
% Is an extension of the book class. Tested with LuaLaTex, should work with XeLaTex
% INSTRUCTIONS
%
% Use 10pt or 11pt options and either oneside or twoside.
% The class will set book to openright with a4paper
%
% Use \title{} to specify title,
%     \author{} to specify author,
%     \subject{} to specify subject.
%
% Use \begin{vuwabstract} to insert a unnumbered chapter styled as an abstract
%
% Use the following package options to specify degree:
%     phd,
%     mscwithhonours,
%     mscthesisonly,
%     mscbothparts,
%     otherdegree=<Value>
%
% use \maketitle AFTER everything has been specified.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{vuwthesis}
[2021/05/31 (Matthew Askes) Support for styling a VUW math thesis]


\RequirePackage{kvoptions}
\RequirePackage{xparse}
%\RequirePackage{etoolbox}

\SetupKeyvalOptions{
    family=vuw,
    prefix=vuw@
}

\newif\ifvuw@stix
\newif\ifvuw@newcomputermodern
\newif\ifvuw@libertinus
\newif\ifvuw@noto


%--------------Package Options-------------------
\newcommand{\vuw@mutOptError}{%
    \PackageError{vuwthesis}{Options 'stix', 'newcomputermodern', and 'libertinus' are mutually exclusive.}{}%
    \endinput
}

\DeclareVoidOption{stix}{%
    \ifvuw@newcomputermodern\vuw@mutOptError\fi
    \ifvuw@libertinus\vuw@mutOptError\fi
    \ifvuw@noto\vuw@mutOptError\fi
    \vuw@stixtrue\vuw@newcomputermodernfalse\vuw@libertinusfalse\vuw@notofalse
}
\DeclareVoidOption{newcomputermodern}{%
    \ifvuw@stix\vuw@mutOptError\fi
    \ifvuw@libertinus\vuw@mutOptError\fi
    \ifvuw@noto\vuw@mutOptError\fi
    \vuw@stixfalse\vuw@newcomputermoderntrue\vuw@libertinusfalse\vuw@notofalse
}
\DeclareVoidOption{libertinus}{%
    \ifvuw@newcomputermodern\vuw@mutOptError\fi
    \ifvuw@stix\vuw@mutOptError\fi
    \ifvuw@noto\vuw@mutOptError\fi
    \vuw@stixfalse\vuw@newcomputermodernfalse\vuw@libertinustrue\vuw@notofalse
}
%\DeclareVoidOption{noto}{
%    \ifvuw@newcomputermodern\vuw@mutOptError\fi
%    \ifvuw@libertinus\vuw@mutOptError\fi
%    \ifvuw@stix\vuw@mutOptError\fi
%    \vuw@stixfalse\vuw@newcomputermodernfalse\vuw@libertinusfalse\vuw@nototrue
%}

\DeclareVoidOption{10pt}{%
    \PassOptionsToClass{\CurrentOption}{book}
}
\DeclareVoidOption{11pt}{%
    \PassOptionsToClass{\CurrentOption}{book}
}
\DeclareVoidOption{twoside}{%
    \PassOptionsToClass{\CurrentOption}{book}
}
\DeclareVoidOption{oneside}{%
    \PassOptionsToClass{\CurrentOption}{book}
}

% to declare the degree
\DeclareVoidOption{phd}{%
    \providecommand {\vuw@degree}{Doctor of Philosophy}
}
\DeclareVoidOption{mscthesisonly}{%
    \providecommand {\vuw@degree}{Master of Science}
}
\DeclareVoidOption{mscwithhonours}{%
    \providecommand {\vuw@degree}{Master of Science with Honours} 
    \providecommand {\vuw@ffil}{partial fulfilment}
}
\DeclareVoidOption{mscbothparts}{%
    \providecommand {\vuw@degree}{Master of Science} 
    \providecommand {\vuw@ffil}{partial fulfilment}
}
\DeclareStringOption[DEGREE NOT STATED]{otherdegree}[DEGREE NOT STATED]

% Defult options
%\ExecuteOptions{11pt,twoside,phd}

\ProcessKeyvalOptions*

%setup string options
\providecommand{\vuw@degree}{\vuw@otherdegree}

\providecommand{\vuw@ffil}{fulfilment}

% Load base class
\PassOptionsToClass{a4paper, openright}{book}
\LoadClass{book}

% to declare the subject
%! suppress = DuplicateDefinition
\newcommand {\vuw@subject} {SUBJECT NOT STATED}
\newcommand {\subject}[1]{\renewcommand{\vuw@subject}{#1}}

\RequirePackage{iftex}
%throw error if not using LuaTex of XeTex
\ifluatex
\else
    \ifxetex
    \else
        \PackageError{vuwthesis}{Requires LuaTex or XeTex}{Please use one of these compilers, pdflatex is not supported}
        \endinput
    \fi
\fi

\ifvuw@stix
\else
   \ifvuw@libertinus
    \else
        \ifvuw@newcomputermodern
        \else
            \vuw@newcomputermoderntrue %set newcomputermodern as deafult
        \fi
    \fi
\fi
%
%\newcommand{\vuw@temp}[1]{\includeonly{#1}}
%\renewcommand{\includeonly}[1]{ \vuw@includeonlytrue%
%                                \vuw@temp{#1}}

%====================Document Setup=====================================

\RequirePackage{amsmath}
\RequirePackage{mathtools}
\RequirePackage[pdfborder={0 0 .5}, % Changes thickness of the link borders
                pdfpagelayout=OneColumn%
                ]{hyperref}%

%--------------------page geometry--------------------------------
\newlength{\alphabet}
\settowidth{\alphabet}{abcdefghijklmnopqrstuvwxyz}
\RequirePackage{geometry}
\geometry{textwidth=2.8\alphabet, %this gives a nice textwidth that is dependent on the font (about 70 characters across)
    top = 35mm,
    bottom = 35mm }
\if@twoside
    \geometry{hmarginratio={4:5}}
\else
    \geometry{hmarginratio={1:1}}
\fi

\RequirePackage{parskip} %make paragraphs be seperated by whitespace, not tabs

%---------------------headers and footers-----------------------------
\RequirePackage {fancyhdr} % fancy headers (special pagestyle, allows editing page style)
\RequirePackage {emptypage} % Make empty pages really empty

% setup fancy style
\fancypagestyle{fancy}{%
    \fancyhf{}
    \fancyhead[RO]{\nouppercase\rightmark}
    \fancyhead[LE]{\nouppercase\leftmark}
    %\fancyfoot[CE,CO]{\leftmark}
    %\fancyfoot[LE,RO]{\thepage}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{1pt}
    \renewcommand{\footrulewidth}{1pt}
}

\fancypagestyle{front}[fancy]{ %a style for chapters without sections
    \fancyhead[RO]{\nouppercase \leftmark}
    \fancyhead[LE]{\nouppercase \leftmark}
}

\fancypagestyle{plain}{%
    \fancyhf{}% clear all header and footer fields
    \fancyfoot[C]{\thepage} %place page number in the footer at center
    \renewcommand{\headrulewidth}{0pt}%
    \renewcommand{\footrulewidth}{1pt}%
}

\setlength{\headheight}{14pt}

%-----------------------fonts-------------------------------
\RequirePackage[no-math]{fontspec}
\RequirePackage{microtype}
\RequirePackage{unicode-math}
\ifluatex
    \RequirePackage[no-inner]{innerscript} %requires luaTex
\fi

\ifvuw@stix
    \setmainfont{STIX Two Text}[%
        Scale=1.0,
        Script=Default,% make small caps work for both latn and grek
    %    Extension = {.otf},
    %    SmallCapsFeatures={Numbers=OldStyle},%
        BoldSlantedFont=STIXTwoText-Bold.otf,
        SlantedFont=STIXTwoText-Regular.otf,
    %    BoldItalicFont=STIXTwoText-BoldItalic.otf,%
    %    BoldFont=STIXTwoText-Bold.otf,%
    %    ItalicFont=STIXTwoText-Italic.otf,%
        SlantedFeatures={FakeSlant=0.25},
        BoldSlantedFeatures={FakeSlant=0.25},
        SmallCapsFeatures={Numbers=OldStyle}]
    \RequirePackage[scale=MatchLowercase, nomap]{FiraMono}
    \RequirePackage[scale=MatchLowercase]{FiraSans}
    \setmathfont[CharacterVariant=3]{STIXTwoMath-Regular.otf} % cv03 changes the empty set style to oblate rather then circle
    %\setmathfont[range={\in,\ni},StylisticSet=6]{STIXTwoMath-Regular.otf} %smaller \in \ni characters
    \setmathfont[range={scr,bfscr},StylisticSet=1]{STIXTwoMath-Regular.otf}
    \setmathfont[range= {tt, sfup, sfit, bfsfup, bfsfit}]{Fira Math}[Scale=MatchLowercase] %change the tt and sf styles to match fira for sans and mono
\fi

\ifvuw@libertinus
    \RequirePackage[mono=false]{libertinus-otf}
    \RequirePackage[scale=MatchLowercase, nomap]{FiraMono}
    \setmathfont[range= {tt}]{Fira Math}[Scale=MatchLowercase] %change the tt style to match fira mono
    \setmathfont[range={bb}]{NewCMMath-Book.otf}
    \setmathfont[range={cal, bfcal, scr,bfscr},StylisticSet=1]{STIXTwoMath-Regular.otf}
\fi

\ifvuw@newcomputermodern
%    \RequirePackage{newcomputermodern}
    \setmainfont[%
        SizeFeatures={%
            {Size=-8, Font=NewCM08-Book.otf,
                ItalicFont=NewCM08-BookItalic.otf,%
                BoldFont=NewCM10-Bold.otf,%
                BoldItalicFont=NewCM10-BoldItalic.otf,%
                SlantedFont=NewCM08-Book.otf,%
                BoldSlantedFont=NewCM10-Bold.otf,%
                SmallCapsFeatures={Numbers=OldStyle}},
            {Size=8, Font=NewCM08-Book.otf,
                ItalicFont=NewCM08-BookItalic.otf,%
                BoldFont=NewCM10-Bold.otf,%
                BoldItalicFont=NewCM10-BoldItalic.otf,%
                SlantedFont=NewCM08-Book.otf,%
                BoldSlantedFont=NewCM10-Bold.otf,%
                SmallCapsFeatures={Numbers=OldStyle}},
            {Size= 9-, Font = NewCM10-Book.otf,
                ItalicFont=NewCM10-BookItalic.otf,%
                BoldFont=NewCM10-Bold.otf,%
                BoldItalicFont=NewCM10-BoldItalic.otf,%
                SlantedFont=NewCM10-Book.otf,%
                BoldSlantedFont=NewCM10-Bold.otf,%
                SmallCapsFeatures={Numbers=OldStyle}}%
        },%
        SmallCapsFeatures={Numbers=OldStyle},%
        BoldSlantedFont=NewCM10-Bold.otf,%
        SlantedFont=NewCM10-Book.otf,%
        BoldItalicFont=NewCM10-BoldItalic.otf,%
        BoldFont=NewCM10-Bold.otf,%
        ItalicFont=NewCM10-BookItalic.otf,%
        SlantedFeatures={FakeSlant=0.25},%
        BoldSlantedFeatures={FakeSlant=0.25},%
        ]{NewCM10-Book.otf}
    \RequirePackage[scale=MatchLowercase, nomap]{FiraMono}
%    \defaultfontfeatures[FiraSans]{StylisticSet=5}
    \RequirePackage[scale=MatchLowercase]{FiraSans}

    \setmathfont[Scale=MatchLowercase]{NewCMMath-Book.otf}
    \setmathfont[range= {tt, sfup, sfit, bfsfup, bfsfit}]{Fira Math}[Scale=MatchLowercase] %change the tt and sf styles to match fira for sans and mono
    \setmathfont[range={scr,bfscr,
        \underbracket,
        \overbracket,
        \underbrace,
        \overbrace},StylisticSet=1]{STIXTwoMath-Regular.otf}
\fi

\defaultfontfeatures{Scale=MatchLowercase,Ligatures=TeX,Numbers=Uppercase}

%---------------------headers and footers--------------------------
%matters that change the pagestyle (headers and footers)
\NewDocumentCommand\vuwfrontmatter {} {\frontmatter \pagestyle{front}}
\NewDocumentCommand\vuwmainmatter {} {\mainmatter \pagestyle{fancy}}
\NewDocumentCommand\vuwbackmatter {} {\backmatter \pagestyle{fancy}}

%---------------------------Abstract-----------------------------
% define the abstract chapter
\NewDocumentEnvironment {vuwabstract} { O{Abstract} } {%
    \chapter*{\centering \begin{normalsize}\textbf{#1}\end{normalsize}} \markboth{#1}{}%
    \begin{quotation}%
}
{
    \end{quotation}%
    \clearpage%
}

%-----------------------Titlepage--------------------------------

\renewcommand{\maketitle}{
    \hypersetup{% set pdf info
        pdftitle={\@title},%
        pdfauthor={\@author},%
        pdfsubject={\vuw@subject}%
    }
    \begin{titlepage}
                                \thispagestyle{empty}

    \if@twoside
        \setcounter{page}{-1}
    \else
        \setcounter{page}{0}
    \fi
    \null

    \begin{center}
        \parbox{100mm}{\center\LARGE\textbf\@title}\par
        \vspace*{\stretch{.5}}
        \parbox{100mm}{\center by}\par
        \vspace*{\stretch{.5}}
        \parbox{100mm}{\center\large\@author}\par
        \vspace*{\stretch{1}}
        \parbox{100mm}{
            \center
            A thesis\\
            submitted to Victoria University of Wellington\\
            in \vuw@ffil\ of the
            requirements for the degree of\\
            \vuw@degree \\
            in \vuw@subject.
        }

        \vspace*{\stretch{1}}
        \parbox{100mm}{\center Victoria University of Wellington\\ \number\year}
    \end{center}

\end{titlepage}
    \gdef\@author{}
    \gdef\@title{}
    \gdef\vuw@degree{}
    \gdef\vuw@ffil{}
    \gdef\vuw@subject{}
    \gdef\@abstract{}
    \let\maketitle\relax
}

\endinput
