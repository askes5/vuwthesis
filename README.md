# vuwthesis
A latex class for styling a vuw masters and phd thesis

This includes a vuwthesis class, a luanamedtheorem package, and a latex template.

## vuwthesis class
This is the class the styles the document. 
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
