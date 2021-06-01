# vuwthesis
A latex class for styling a vuw masters and phd thesis. Requires LuaTex or XeTex.

This includes a vuwthesis class, a luanamedtheorem package, and a latex template.

## vuwthesis class
This is the class the styles the document. Uses `unicode-math`, so please take a look at the package documentation.

Package options are:

* font size
  * 10pt
  * 11pt

* page type
  * oneside
  * twoside

* font
  * stix
  * libertinus
  * newcomputermodern (the default)

* specify degree
  * phd
  * mscwithhonours
  * mscthesisonly
  * mscbothparts
  * otherdegree=[Value]
  
 Use `\title{}` to specify title,
     `\author{}` to specify author,
     `\subject{}` to specify subject.

 Use `\begin{vuwabstract}` to insert a unnumbered chapter styled as an abstract

 use `\maketitle` AFTER everything has been specified.
 
 ## luanamedtheorem
 This adds a special theorem enviroment called namedtheorem. This package requires luatex. 
 
 `\begin{namedtheorem}{aaa}{Aaa}[bb] \label{aaa}
 Contents.
 \end{namedtheorem}` will be set as 
 
 **aaa** (bb). Contents.
 
 And referenced with `\ref{aaa}` gives Aaa.
 
 Alternativly `\cref{aaa}` from the `cleveref` package gives Aaa and supports most `cleveref` features.
