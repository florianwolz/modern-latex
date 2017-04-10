%  Copyright 2017 Florian Wolz
%
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%
%      http://www.apache.org/licenses/LICENSE-2.0
%
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.

\def\fileversion{1.0}
\def\filedate{2012/04/03}
\def\filename{cggbook}

\NeedsTeXFormat{LaTeX2e}  \ProvidesClass{\filename}[\filedate Buch-Klasse fuer CGG@IQG, (c) by Florian Wolz]
\typeout{Class: '\filename' Version \fileversion, Buchvorlage der CGG@IQG}

\ProcessOptions\relax
\LoadClass[a4paper,9pt]{book}

%= Core includes
\RequirePackage[usenames,dvipsnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{svg}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{mathtools}

\RequirePackage[T1]{fontenc}
\RequirePackage[no-sscript]{xltxtra}
\RequirePackage{microtype}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage[utf8]{inputenc}

\RequirePackage{hyperref}
\RequirePackage{varwidth}

%= Options
\newif\ifusecolor
\newif\ifsansfonts

\DeclareOption{color}{\usecolortrue}
\DeclareOption{sans}{\sansfontstrue}

%= Font
\RequirePackage{fontspec}
\RequirePackage[light]{sourcesanspro}
%\RequirePackage{ebgaramond}
%\usepackage{unicode-math}

%= Dimensionen
\setlength{\textheight}{220mm}
\setlength{\topmargin}{20mm}
\addtolength{\topmargin}{-1in}
\setlength{\headheight}{0mm}
\setlength{\headsep}{10mm}
\setlength{\topskip}{0mm}
\setlength{\footskip}{11mm}

\setlength{\textwidth}{150mm}
\setlength{\oddsidemargin}{30mm}
\addtolength{\oddsidemargin}{-1in}
\setlength{\evensidemargin}{30mm}
\addtolength{\evensidemargin}{-1in}

\newcommand{\@br}[1][1]{\par\vspace{#1\baselineskip}}

%= Colors
\definecolor{awesomegreen}{RGB}{126,211,33}
\definecolor{awesomeblue}{RGB}{33,187,230}
\definecolor{lightgreen}{RGB}{242,250,232}
\definecolor{lightblue}{RGB}{232,248,252}
\definecolor{awesomegray}{RGB}{136,142,145}

\ifusecolor
    \definecolor{primary}{named}{awesomeblue}
\else
    \definecolor{primary}{named}{black}
\fi

%= Table of Contents
\contentsmargin{0cm}

\newcommand\myparttitle[1]{%
	\noident\makebox[\linewidth][c]{%
		\colorbox{primary!10}{%
			\parbox{\paperwidth}{%
				\vspace{.3\baselineskip}
				\hspace*{\dimexpr\hoffset+\oddsidemargin+1in\relax}%
				\begin{minipage}{\textwidth}
				\centering
        		#1
      			\end{minipage}%
	      		\vspace{.3\baselineskip}
			}%
		}%
	}%
}%


\titlecontents{part}[0cm]
{\addvspace{20pt}\large\centering\bfseries\sourcesanspro}
{}
{\Large\bfseries\color{primary}\myparttitle}
{\hfill}

\titlecontents{chapter}[1.25cm]
{\addvspace{12pt}\large\sourcesanspro\bfseries}
{\color{primary!60}\contentslabel[\Large\thecontentslabel]{1.25cm}\color{primary}}
{\color{primary}}
{\color{primary!60}\normalsize\;\hfill\;\thecontentspage}

\titlecontents{section}[1.25cm]
{\addvspace{2pt}}
{\contentslabel[\color{awesomegray}\bfseries\sourcesanspro\thecontentslabel]{1.25cm}}
{}
{\sourcesanspro\bfseries\normalsize \titlerule*[.5pc]{.}\;\thecontentspage}
[]

\titlecontents{subsection}[2.5cm]
{\addvspace{2pt}}
{\contentslabel[\color{awesomegray!75}\bfseries\sourcesanspro\thecontentslabel]{1.25cm}}
{}
{\sourcesanspro\bfseries\normalsize \titlerule*[.5pc]{.}\;\thecontentspage}
[]

%= Part Page Style
\def\@part[#1]#2{%
	\ifnum \c@secnumdepth >-2\relax%
		\refstepcounter{part}%
		\addcontentsline{toc}{part}{\thepart \; #1}%
	\else
		\addcontentsline{toc}{part}{#1}%
	\fi%
	\startcontents%
	\markboth{}{}%
	{%
		\thispagestyle{empty}%	
		\begin{tikzpicture}[remember picture, overlay]%
		\node at (current page.north west){%
			\begin{tikzpicture}[remember picture, overlay]%
				\fill[primary!10](0cm, 0cm) rectangle (\paperwidth,-\paperheight);
				\node[anchor=north] at (4cm, -3.25cm){\color{primary!5}\fontsize{220}{100}\sourcesanspro\bfseries\@Roman\c@part};
				\node[anchor=south east] at (\paperwidth-1cm, -\paperheight+1cm){\parbox[t][][t]{12cm}{
					\printcontents{l}{0}{\setcounter{tocdepth}{1}}
				}};
				\node[anchor=north east] at (\paperwidth-1.5cm,-3.25cm){\parbox[t][][t]{15cm}{\strut\raggedleft\color{primary}\fontsize{50}{50}\kaffeesatz\bfseries#2}};
			\end{tikzpicture}
		}%
		\end{tikzpicture}
	}%
	\@endpart
}%

%= Boxes
\newsavebox{\definitionbox}
\newenvironment{definition}[1][Definition]{
    \begin{lrbox}{\definitionbox}
    \begin{minipage}[t]{0.973\textwidth}
    \textcolor{awesomeblue}{{\bfseries \sourcesanspro #1}}\\
}{
    \end{minipage}
    \end{lrbox}
    \fboxsep3mm
    \colorbox{lightblue}{\usebox{\definitionbox}}
}

\newsavebox{\theorembox}
\newenvironment{theorem}[1][Theorem]{
    \begin{lrbox}{\theorembox}
    \begin{minipage}[t]{0.973\textwidth}
    \textcolor{awesomegreen}{{\bfseries \sourcesanspro #1}}\\
}{
    \end{minipage}
    \end{lrbox}
    \fboxsep3mm
    \colorbox{lightgreen}{\usebox{\theorembox}}
}

%= Footer
\if@twoside
    \renewcommand{\ps@headings}{
        \let\@oddfoot\@empty\let\@evenfoot\@empty%
        \renewcommand*{\@oddhead}{\footnotesize\hfill{\color{awesomegray} \sourcesanspro \rightmark} \quad \\\qquad{\small\bfseries\sourcesanspro\thepage}}%
        \renewcommand*{\@evenhead}{\small {\bfseries\sourcesanspro\thepage}\qquad{\color{awesomegray}\sourcesanspro \footnotesize \leftmark}\hfill}%
        \def\chaptermark##1{%
            \markboth{%
                \ifnum \c@secnumdepth >\m@ne%
                    \if@mainmatter\@chapapp\ \thechapter\ \ \fi%
                \fi%
            ##1}{}%
        }%
        \def\sectionmark##1{\markright{\ifnum \c@secnumdepth >\z@\thesection\ \ \fi##1}}
    }
\else
    \renewcommand{\ps@headings}{
        \let\@oddfoot\@empty\let\@evenfoot\@empty%
        \renewcommand*{\@oddhead}{\footnotesize\hfill{\sourcesanspro\rightmark} \quad \\\quad{\small\sourcesanspro\thepage}}%
        \def\chaptermark##1{%
            \markboth{%
                \ifnum \c@secnumdepth >\m@ne%
                    \if@mainmatter\@chapapp\ \thechapter\ \ \fi%
                \fi%
            ##1}{}%
        }%
        \def\sectionmark##1{\markright{\ifnum \c@secnumdepth >\z@\thesection\ \ \fi##1}}
    }
\fi
\pagestyle{headings}

%= Chapter and section headings
\newif\ifusechapterimage
\usechapterimagefalse
\newcommand{\thechapterimage}{}%
\newcommand{\chapterimage}[1]{%
	\usechapterimagetrue
	\renewcommand{\thechapterimage}{#1}
}%
\newcommand{\nochapterimage}{%
	\usechapterimagefalse
}%

\def\@makechapterhead#1{%
	{%\parindent %\raggedright \normalfont
	\ifnum \c@secnumdepth > \m@ne 
		\begin{tikzpicture}[remember picture, overlay]
			\node at (current page.north west){%
				\begin{tikzpicture}[remember picture, overlay]
					\ifusechapterimage%
					\node[anchor=north west, inner sep=0pt] at (0,0) {%
							\includegraphics[width=\paperwidth]{\thechapterimage}
					};%
					\else 
						\fill[awesomegray!10, anchor=north west](0cm, 0cm) rectangle (\paperwidth,-9cm);

					\fi
					\draw[anchor=west] (1in + \hoffset + \oddsidemargin, -7cm) node {\fontsize{42}{12}\kaffeesatz\bfseries\color{primary!80}\thechapter};
					\draw[anchor=west] (1in + \hoffset + \oddsidemargin+1.5cm,-7cm) node [text width=\textwidth-1.5cm] {\fontsize{42}{12}\kaffeesatz\bfseries\color{primary}#1};
				\end{tikzpicture}
			};%
		\end{tikzpicture}
	\fi%
	\par\vspace*{190\p@}
	\thispagestyle{empty}
	
	\usechapterimagefalse % Reset the chapter image for the next chapter
	}
}%

\def\@makeschapterhead#1{%
	{%\parindent %\raggedright \normalfont
	\ifnum \c@secnumdepth > \m@ne 
		\begin{tikzpicture}[remember picture, overlay]
			\node at (current page.north west){%
				\begin{tikzpicture}[remember picture, overlay]
					\ifusechapterimage%
					\node[anchor=north west, inner sep=0pt] at (0,0) {%
							\includegraphics[width=\paperwidth]{\thechapterimage}
					};%
					\else 
						\fill[awesomegray!10, anchor=north west](0cm, 0cm) rectangle (\paperwidth,-9cm);
					\fi
					\draw[anchor=west] (1in + \hoffset + \oddsidemargin,-7cm) node [text width=\textwidth-1.5cm] {\fontsize{42}{12}\kaffeesatz\bfseries\color{primary}#1};
				\end{tikzpicture}
			};%
		\end{tikzpicture}
	\fi%
	\par\vspace*{190\p@}
	\thispagestyle{empty}
	
	\usechapterimagefalse % Reset the chapter image for the next chapter
	}	
}%

%\renewcommand{\@makechapterhead}[1]{
%	\colorbox{awesomegray!10}{
%    \vspace*{55mm}
%    {{\kaffeesatz \fontsize{42}{12}\bfseries\color{primary}
%    \ifnum \c@secnumdepth >\m@ne\if@mainmatter%
%            \begin{list}{}{\setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}\setlength{\parskip}{0pt}\setlength{\parsep}{0pt}%
%                           \settowidth{\labelwidth}{\thechapter}\setlength{\leftmargin}{1em}%
%                           \setlength{\labelsep}{1em}\addtolength{\labelsep}{-\labelwidth}}
%                \item[\thechapter]#1%
%            \end{list}%
%        \fi\fi
%    }}
%    \vskip 5ex
%    }
%  
%    \thispagestyle{headings}
%}

%\def\@makeschapterhead#1{
%	\colorbox{awesomegray!10}{
%    \vspace*{55mm}
%    {{\kaffeesatz \fontsize{42}{12} \bfseries\color{primary} \addfontfeature{LetterSpace=4.0}
    
%        #1
    
        %\begin{list}{}{\setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}\setlength{\parskip}{0pt}\setlength{\parsep}{0pt}}
		%			   \settowidth{\labelwidth}{\thechapter}\setlength{\leftmargin}{0pt}%
		%			   \setlength{\labelsep}{0pt}}
		%	\item \MakeUppercase{#1}
		%\end{list}%
%    }}
%    \vskip 5ex
%    }

%    \thispagestyle{headings}
%}

%\renewcommand{\@makeschapterhead}[1]{
%    \vspace*{55mm}
%    {\Huge\bfseries
%        \begin{list}{}{\setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}\setlength{\parskip}{0pt}\setlength{\parsep}{0pt}%
%					   \settowidth{\labelwidth}{\thechapter}\setlength{\leftmargin}{0pt}%
%					   \setlength{\labelsep}{0pt}}
%			\item[]\MakeUppercase{#1}
%		\end{list}%
%   }
%   \vskip 5ex
%   \thispagestyle{headings}
%}

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {1.8ex \@plus.2ex}%
                                   {\Large\sourcesanspro\bfseries}}

%= Title page
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\@subtitle}{}

\newcommand{\largetitle}[1]{\gdef\@largetitle{#1}}
\newcommand{\@largetitle}{}

\renewcommand*{\maketitle}{
    \begin{titlepage}
        %\hspace*{-0.2cm}\includegraphics[width=10cm]{template/logo.eps}
    
        \vspace*{4cm}
        
        \begin{centering}
            \kaffeesatz
            
            {\color{gray} \fontsize{34}{12} \selectfont \MakeUppercase{\@title}}
            \vspace{0.1cm}
    
            {\color{primary} \fontsize{76}{48} \bfseries \@largetitle}

            \vspace*{10cm}
            {\fontsize{48}{12} \selectfont \color{primary!50} \MakeUppercase{\@author}}
        
        \end{centering}
    \end{titlepage}
}

\setlength{\parskip}{1.8ex plus0.3ex minus0.2ex}%
\setlength{\parindent}{0pt}

\AtBeginDocument{

	\titleformat*{\section}{\Large\bfseries\sourcesanspro}
    \titleformat*{\subsection}{\large\bfseries\sourcesanspro}
    
    \usetikzlibrary{positioning}
    
    \newfontfamily\kaffeesatz[
        Path=template/fonts/,
        Mapping=tex-text,
        Extension=.ttf,
        UprightFont=*-Regular,
        BoldFont=*-Bold,
    ]{YanoneKaffeesatz}
    
    \setmainfont[
        Path=template/fonts/,
        Mapping=tex-text,
        Extension=.ttf,
        UprightFont=*-Regular,
        ItalicFont=*-Italic,
        BoldFont=*-Bold,
        BoldItalicFont=*-BoldItalic
    ]{MinionPro}
    
    %\setmainfont{Minion Pro}
	%\setmathsfont(Digits,Greek,Latin)[Numbers={Proportional}]{MinionPro}
	%\setmathrm{MinionPro}
    
    % Set spread
    \fontsize{11pt}{13pt}
    \linespread{1.2}
    \selectfont
    
}
