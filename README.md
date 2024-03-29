# vuwthesis
A latex class and associated packages for styling and creating a vuw masters and PhD thesis. Requires LuaTex or XeTex.

This includes a vuwthesis class, a luanamedtheorem package, and a latex template.

## vuwthesis class
This is the class the styles the document. Uses `unicode-math`, so please take a look at the [package documentation](https://ctan.org/pkg/unicode-math).

A template demonstating this classes use can be found in the src folder.

If you get a font error ensure you have all the nessary fonts installed. You will need `firamath` and `fira` for sans-serif and mono fonts. `stix2-otf`, `libertinus-otf`, or  `NewComputerModern` for serif fonts (depends on package options).

Package options are:
* font size
  * `10pt`
  * `11pt`

* page type
  * `oneside`
  * `twoside`

* font
  * `stix`
  * `libertinus`
  * `newcomputermodern` (the default)

* specify degree
  * `phd`
  * `mscwithhonours`
  * `mscthesisonly`
  * `mscbothparts`
  * `otherdegree=<Value>`
  
 Use `\title{}` to specify title,
     `\author{}` to specify author,
     `\subject{}` to specify subject.

 Use `\begin{vuwabstract}` to insert a unnumbered chapter styled as an abstract

 use `\maketitle` AFTER everything has been specified.
 
 ## luanamedtheorem
 This adds a special theorem enviroment called namedtheorem. This package requires luatex. This supports the `cleveref` package, and must be load before this package.

### Usage
`\begin{namedtheorem}{<Display Name>}{<Reference Name>}[<Optional extra info>]`
 
 For example, `\begin{namedtheorem}{aaa}{Aaa}[bb] \label{aaa}
 Contents.
 \end{namedtheorem}` will be typeset as a theorem with the name aaa. The second mandatory option is the reference name. Displayed as: 
 
 **aaa** (bbb). Contents.
 
 And referenced with `\ref{aaa}` gives Aaa.
 
 Alternativly `\cref{aaa}` from the `cleveref` package gives Aaa and supports most `cleveref` features.
