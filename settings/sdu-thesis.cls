%% sdu-theis.cls
%% Copyright 2025 Guodong Li
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Guodong Li.
%
% This work consists of the files sdu-thesis.cls main.tex

% ===== 导言部分 =====
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{sdu-thesis}

% ==== 基本文档类 ====
\AddToHook{package/xeCJK/after}{\defaultCJKfontfeatures{}}
\LoadClass[a4paper, 12pt, scheme=plain, UTF8]{ctexbook}
\RequirePackage{amsmath, amsfonts, amsthm, amssymb, amsbsy, bm, mathrsfs}
\RequirePackage{graphicx, booktabs}
\RequirePackage{emptypage, fancyhdr}

% ==== 选项 ====
\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=SST, prefix=SST@opt@, setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{SST}{#1}}

% ==== 声明布尔选项 (单双面 黑白 封面方正字体) ====
% ---- 双面打印/单面打印 ----
\DeclareBoolOption[false]{double}
\DeclareComplementaryOption{single}{double}

% ---- 是否将链接颜色改为黑色 ----
\DeclareBoolOption[false]{print}
\DeclareComplementaryOption{noprint}{print}

% ---- 是否有所需的方正字体 ----
\DeclareBoolOption[false]{fzfont}
\DeclareComplementaryOption{nofzfont}{fzfont}

% ---- 处理其它选项 ----
\ProcessKeyvalOptions*\relax

% ==== 页面布局 ====
\ifSST@opt@double
	\newcommand{\GeoOptions}{inner=3cm, outer=2cm, top=2.8cm, bottom=2.5cm}
\else
	\newcommand{\GeoOptions}{left=2.5cm, right=2.5cm, top=2.8cm, bottom=2.5cm}
	\PassOptionsToClass{openany}{ctexbook}
\fi
\RequirePackage[\GeoOptions]{geometry}

% ==== 根据 double 选项处理章节分页 ====
\newcommand{\cleartochapter}{%
	\ifSST@opt@double
		\cleardoublepage % 双面打印时使用，确保章节从奇数页开始
	\else
		\clearpage % 单面打印时使用，章节从下一页开始
	\fi
}

% ==== 交叉引用 ====
\RequirePackage{hyperref}
\hypersetup{
	unicode=true,
	colorlinks=true,
	linkcolor=blue,
	citecolor=red,
	urlcolor=red,
	anchorcolor=blue
}
\makeatletter
\ifSST@opt@print
	\hypersetup{allcolors=black}
\fi
\makeatother

% ==== 引入特殊字体 ====
\RequirePackage{ifpdf, ifxetex}
\makeatletter
\ifxetex
	\ifSST@opt@fzfont
		\newCJKfontfamily[fzbighei]{\fzbHei}{方正粗黑宋简体}
		%\newCJKfontfamily[fzckjw]{\fzckjw}{方正粗楷简体}
	\else
		\newcommand{\fzbHei}{\heiti}
	\fi
\else
	\newcommand{\fzbHei}{\heiti}
\fi
\makeatother

% ==== 行距和段落间距 ====
\linespread{1.3}
\addtolength{\parskip}{.3ex}

% ==== 页眉页脚 ====
% ---- 页眉高度 ----
\setlength{\headheight}{14.87228pt}

\pagestyle{fancyplain}
\fancyhf{}  % 清除默认设置
\newcommand{\makeheadrule}{%
	\makebox[0pt][l]{\rule[.7\baselineskip]{\headwidth}{0.8pt}}%
	\rule[0.85\baselineskip]{\headwidth}{1.5pt}\vskip-.8\baselineskip
}

\makeatletter
\renewcommand{\headrule}{%
	\if@fancyplain
		\let\headrulewidth\plainheadrulewidth
	\fi
	\makeheadrule
}
\chead{\zihao{5}\the\ThesisHeader}
\ifSST@opt@double
	\fancyfoot[LE,RO]{--{~\thepage~}--}
\else
	\fancyfoot[R]{--{~\thepage~}--}
\fi
\makeatother

% ==== 标题风格 ====
\makeatletter
\renewcommand{\chapter}{%
	\cleartochapter
	\thispagestyle{plain}% 章节页的页面样式
	\global\@topnum\z@   % Prevents figures from going at top of page.
	\@afterindentfalse
	\secdef\@chapter\@schapter
}
\makeatother

\newcommand{\spaces}{\texorpdfstring{\quad{}}{}}
\usepackage{indentfirst} % 使得章节后的第一段缩进
\setlength{\parindent}{2em} \ctexset{ figurename={图}, tablename={表}, bibname={参考文献},
	contentsname={目\spaces{}录}, chapter = {% 设置缩进为2个汉字
	  %name = {第, 章},
	  name = {},
	  %number = \chinese{chapter},
	  format = \centering, nameformat = {\bfseries\zihao{-3}}, titleformat =
		  {\bfseries\zihao{-3}}, aftername = \quad, beforeskip = 10pt, afterskip = 10pt,
	  afterindent = true }, section = { format = {\bfseries\flushleft\zihao{4}} },
	subsection = { format = {\bfseries\flushleft\zihao{-4}} }, subsubsection = {
			format = {\flushleft\zihao{-4}} }, appendix = {
			%name = {附录~},
			name = {}, number = \Alph{chapter} }, today = small }

% ---- 英文标题 ----
\newcommand\echapter[1]{\addengcontents{chapter}{#1}}
\newcommand\esection[1]{\addengcontents{section}{#1}}
\newcommand\esubsection[1]{\addengcontents{subsection}{#1}}
\newcommand\esubsubsection[1]{\addengcontents{subsubsection}{#1}}

% ==== 数学环境 ====
\newtheorem{theorem}{定理}[chapter]
\newtheorem{lemma}[theorem]{引理}
\newtheorem{corollary}[theorem]{推论}
\newtheorem{claim}[theorem]{断言}
\newtheorem{proposition}[theorem]{命题}
\newtheorem{example}[theorem]{例}
\newtheorem{definition}{定义}
\newtheorem{conjecture}{猜想}
\newtheorem{remark}{注}
\newtheorem{openproblem}{公开问题}
\newtheorem{observation}{观察}

\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}

% ==== 封 面 页 ====
\input{settings/cover.def}

% ==== 声 明 页 ====
\input{settings/declare.def}

\newcommand{\maketitlepagestatement}{%
	\maketitlepage
	\cleartochapter
	\makestatement
	\cleartochapter
	\setcounter{page}{1}
}

% ==== 目 录 ====
\newcommand{\content}{
	\maketableofcontents
	% English TOC
	\tableofengcontents
	\cleartochapter
}
% ---- 中文目录 ----
\makeatletter
\def\@bfdottedtocline#1#2#3#4#5{%
	\ifnum #1>\c@tocdepth \else
		\vskip \z@ \@plus.2\p@
		{\leftskip #2\relax \rightskip \@tocrmarg \parfillskip -\rightskip
			\parindent #2\relax\@afterindenttrue \interlinepenalty\@M \leavevmode \bfseries
			\@tempdima #3\relax \advance\leftskip \@tempdima \null\nobreak\hskip -\leftskip
			{#4}\normalfont\nobreak \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern
					\@dotsep mu$}\hfill \nobreak \hb@xt@\@pnumwidth{\hfil\normalfont \normalcolor
				#5}%
			\par}%
	\fi}
\renewcommand*\l@chapter{\@bfdottedtocline{0}{0em}{1.5em}}
\makeatother

\makeatletter
\newcommand{\maketableofcontents}{%
	\pagenumbering{roman}
	\tableofcontents
}
\makeatother
% ---- 英文目录 ----
\makeatletter
\newcommand\engcontentsname{Contents}
\newcommand\tableofengcontents{%
	%\if@twocolumn
	\@restonecoltrue\onecolumn
	%\else
	\@restonecolfalse
	%\fi
	\chapter*{\engcontentsname
	  \@mkboth{\MakeUppercase\engcontentsname}{\MakeUppercase\engcontentsname}}%
	\@starttoc{toe}  % 自定义英文目录内容
	\if@restonecol\twocolumn\fi
}
\newcommand\addengcontents[2]{%
	\addcontentsline{toe}{#1}{\protect\numberline{\csname the#1\endcsname}#2}}
\makeatother

% ==== 摘要环境 ====
% ---- 中文摘要 ----
\newcommand\cnabstractname{摘\spaces{}要}
\newcommand\cnkeywordsname{关键词}
\newcommand\cnkeywords[1]{\vspace{1cm}\noindent{\bfseries\zihao{-4}\cnkeywordsname： }#1}
\newenvironment{cnabstract}{%
	\cleartochapter
	\phantomsection
	\centerline{\vspace{.3cm}\zihao{-3}\bfseries\cnabstractname}\vspace{.3cm}
	\addcontentsline{toc}{chapter}{摘\spaces{}要}
	\addcontentsline{toe}{chapter}{Chinese Abstract}
	\setlength{\parindent}{2em} \zihao{-4} }{
	%
}
% ---- 英文摘要 ----
\newcommand\enabstractname{ABSTRACT}
\newcommand\enkeywordsname{Key words}
\newcommand\enkeywords[1]{\vspace{1cm}\noindent{\bfseries\zihao{-4}\enkeywordsname: }#1}
\newenvironment{enabstract}{%
	\cleartochapter
	\phantomsection
	\centerline{\vspace{.3cm}\zihao{-3}\bfseries\enabstractname}\vspace{.3cm}
	\addcontentsline{toc}{chapter}{ABSTRACT}
	\addcontentsline{toe}{chapter}{Abstract}
	\setlength{\parindent}{1.2em} }{
	%
}

% ==== 插图目录 表格目录 ====
\newcommand{\ftcontent}{%
	\renewcommand\listfigurename{插~图~目~录}
	\newcommand{\loflabel}{图}
	\renewcommand{\numberline}[1]{\loflabel~##1\hspace*{1em}}
	\listoffigures
	\phantomsection
	\addcontentsline{toc}{chapter}{插~图~目~录}
	\addcontentsline{toe}{chapter}{List of Figures}

	\renewcommand\listtablename{表~格~目~录}
	\newcommand{\lotlabel}{表}
	\renewcommand{\numberline}[1]{\lotlabel~##1\hspace*{1em}}
	\listoftables
	\phantomsection
	\addcontentsline{toc}{chapter}{表~格~目~录}
	\addcontentsline{toe}{chapter}{List of Tables}

	% 阿拉伯数字页码
	\cleartochapter
	\pagenumbering{arabic}\setcounter{page}{1}
}

% ==== 参考文献 ====
% \newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}
\newcommand{\references}{%
	\cleartochapter
	\phantomsection
	\addcontentsline{toc}{chapter}{参考文献}
	\addcontentsline{toe}{chapter}{References}
}

% ==== 致   谢 ====
\newcommand{\acknowledgment}{%
	\cleartochapter
	\phantomsection
	\chapter*{致\spaces{}谢}
	\addcontentsline{toc}{chapter}{致\spaces{}谢}
	\addcontentsline{toe}{chapter}{Acknowledgement}
}

% ==== 发表论文 ====
\newcommand{\publications}{%
	\cleartochapter
	\phantomsection
	\chapter*{攻读博士学位期间发表的学术论文}
	\addcontentsline{toc}{chapter}{攻读博士学位期间发表的学术论文}
	\addcontentsline{toe}{chapter}{Papers Published During Ph.D}
}

% ==== 所获奖项 ====
\newcommand{\awards}{%
	\cleartochapter
	\phantomsection
	\chapter*{攻读博士学位期间所获奖项}
	\addcontentsline{toc}{chapter}{攻读博士学位期间所获奖项}
	\addcontentsline{toe}{chapter}{Awards Achieved During Ph.D}
}

\newcommand{\comments}{%
	\cleartochapter
	\phantomsection
	\chapter*{学 位 论 文 评 阅 及 答 辩 情 况 表}
	\addcontentsline{toc}{chapter}{学位论文评阅及答辩情况表}
	\addcontentsline{toe}{chapter}{Review and Defense of Dissertation}
}

\endinput
