# -Latex-Boilerplate-

A sophisticated Boilerplate/Template together with some Macros and ready-to-use Set-up-Surroundings for LaTeX.<br />

This Boilerplate supports documents differing in two axes:
- The structuring Level: Whether it allows Chapter (like Books) or has Section as highest level (like Articles).
- The degree of freedom, you have regarding look and feel. I.e. whether the final document is targeted towards a publishing target, which usually prescribes the layout, or you can do as you please.

Consequently, does this Boilerplate support in a wide variety of Document Types: Research Articles, Scientific Papers, Academic Thesis, Books, Posters, etc.

Because of similarity in features, code and functioning, I classified certain Layouts into *Document-Genres*. (This is just an optional nice-to-know Info. You actually do only select the 'Layout', without caring too much about the DocGenre.)
- 'elaborate' -- Documents that are under your control and design. The Code supplied for this is very sophisticated and allows a lot of things and brings functions and typesetting to the table. Can deal with both "Chapter-level" & "Article-level" documents (scrbook, scrartcl).
- 'dedicated' -- For Documents (usually shorter ones, and only including up to Section) that go to a specific Publishing-Target (like a scientific conference, a journal, magazine, etc). Through this 'dedication' to a publisher, usually a specific layout, probably even document-class is prescribed (All articles bundled to proceedings or in a journal are supposed to look the same).<br />
One especially cool thing here is that the Boilerplate provides a 'uniform' interface to several different layouts. E.g. you specify the list of authors once and then you can freely change the Layout, one of which is dedicated for compiling a "preprint". Everything is automatically adjusted and you just have to specify information once.
- 'slides' -- For Slide-Sets, probably mainly used for giving Presentations. Using "Beamer" and my Template, it has several custamization options. For example, changing the color palette, different Header, Footer, Frametitles. (Look into "./0organization/slides/2layout/beamer/themes/". The central file to easily change options is in "theme/", only changing colors is in "color/". The other files require you to know LaTeX and TikZ rather well to make sophisticated changes.)
- (There are also '1all' & '2internal', which shouldn't bother you. This contains some essential Code that is common to all or at least many different Layouts. E.g. it defines additional Functionalities, Macros; stuff that commonly aids every project equally and won't be adjusted as it supplies general tools.)



## Document-Genre
The existence of the *Document-Genre* (aka Document-Type) ("influencing the Structure and Design, Not *directly* the Style of Writing or Content) is just an additional Information for you (which you may use to optimize utilized storage space of the Project...)
- The Boilerplate is organized the way, the Files relating to a 'DenKrLayout' are put in an according directory.
- And such Layout-Dirs are put into a common DocGenre-Directory.
- So we have things that are
  - required by all kinds of projects: In the '1all' Dir.
  - common to to the Layouts of the same DocGenre: In the respective DocGenre-Dir.
  - required only by a certain Layout: Inside this Layout's Directory.
  - (Special Classes). Stuff in the '2internal' Dir may be utilized internally, depending on what you do (e.g. use standalone TikZ pictures).
- You can just ignore all this information and files, do your thing, create your document and leave everything alone and stuff works just fine.
- But if you desire so, after you decided for a DenKrLayout, you may look up its DocGenre and safely just delete every other Sub-Directory of other DocGenres (except '1all' and probably '2internal' of course).
  - (It may not be exactly a crucial life decision, but especially the 'elaborate' DocGenre is rather huge, as it contains Fonts. Not too severe, but I'm mentioning it.)


# Setting up new Project

- Copy this Project
- Probably change the Compiler to use 
  - Look into accompanying File ".latexmkrc"
  - Also adjust the according Value in the File '2ProjectSetup.tex".
- The Directory ".vscode" is of course optional and only useful, if you work/compile with VSCode (+ LaTeX Workshop, LaTeX Utilities | ++ LTeX, Bookmarks)



## Compilation
* This here is meant to be compiled with '**LuaLaTeX**'
  - The Layouts of 'dedicated'-DocGenre can also be compiled with 'pdfLaTeX'
  - While most of 'dedicated' work well with 'Lua', '**IEEEtran**' is better compiled using 'pdfLaTeX'
* Remember to add "--shell-escape" to your compiler's arguments in order to make all that Standalone & TikZ stuff working
* Examplary proper compiler argument setup
  * TeX Live / VS-Code + LaTeX Workshop, Utilities / Texlipse
    * -synctex=1 -interaction=nonstopmode --shell-escape %input
  * Overleaf 'latexmkrc'
    * $lualatex = 'lualatex %O %S --synctex=1 --interaction=nonstopmode --shell-escape';


### More INFO
* Inside the directory "./.vscode/" are some Files located, giving more information on how to set up your toolbox well.


## Project's Storage Size (-> Font Files)
You may be wondering (rightfully so) why the Boilerplate takes up so comparably much storage space, while it is mainly nothing but plain text.
* This is because I included some Font files directly into the project. This are for CJK (Chinese, Japanese, Korean; mainly Japanese) characters.
* I did this, because this is not as easy to set up and these fonts aren't that easily found and combined to a full set of typographic features. This way, the fonts are always ready for use with the project.
* ==> *If you do not intend to use such characters however, you can safely **delete** these **Font files** in your project copy.*
  - Located in: "./0organization/1all/1main/4aids/fonts/JP/"


## HowTo
* There is another file "./9chapter/0segmentation/9001_HowTo.tex", which verbosely explains how to set up a project, compile and use the Boilerplate
  - It is however in German and heavily typeset with LaTeX Code.
  - So, it might be difficult to read the source-code and you first must compile it, to read it nicely...



# Fonts
I am using as primary Fonts for the Textbody, "Linux Libertine & Biolinum".
* These cannot be assumed just available. They are not included in operating systems, nor are they shipped with Tex distributions.
* They are however, free and easy to acquire. They come both in one package (Libertine is a Serif-font, Biolinum a Sans-serif).
* Download at:
  * https://www.linuxlibertine.org/ or
  * https://sourceforge.net/projects/linuxlibertine/
* And simply install to your compiling system (as you would with any ordinary Font).
* (I recommend these Fonts anyway. Very aesthetic, many features, a highly expanded character set; just great Fonts.)

---

* Other Fonts, I am utilizing (like differing for Math mode) should be simply made available by any Tex installation.



# The Boilerplate

## Description

* Layout and Skeleton Setup is well separated from the content 
  * Layout can be easily swapped by changing only a configuration-value inside the file "2ProjectSetup.tex"
  * Various different Layouts are already prepared ready-to-use. (Each in an own folder inside "./0organization/2layout/")
  * The same way, additional layouts can be used: Create a new directory there, mimic the file-tree of one existing layout and then use the name of your layout-folder as value for "\\DenKrLayout"
* Paper or Poster 
  * Provides required layout Set-up for Papers (Multiple different layouts for manuscripts)
  * But also for a Poster (One dedicated framework for typesetting a Poster)
* Set up for Biblatex
* Set up for glossaries (requires external builder, pretty easy to configure)
* The File "2ProjectSetup.tex" is interesting in general. Has various Values for configuration.
* All the layout-regarding stuff is inside "0organization" 
  * There, mostly only one thing has to be touched: Choose your preferred Author-Format (different Files for different Formats) and also write the correct Authors themselves there
* "2ProjectSetup.tex" has some Makros set-up to unify directory-references. For easy use, just leave it as is and use the Macros when e.g. including files out of the set folders.
* The structuring of your Project Skeleton starts from "3Disposition.tex". The rest happens inside the directory "4chapter". 
  * I suggest to just leave "3Disposition.tex" as is and work inside "9chapter". But if you prefer, changing "3Disposition.tex" is fine as well.


## Some Features:

* DenKr_Comments: I've created an own Feature for colorful Comments during Working-State, e.g. for communicating with co-authors on collaborative work or to just leave notes, remarks, ToDo-Marks.
  * Adjustment of the Comments (Adapting to participating People; changing the displayed Name-Abbreviation or the color; changing the Macro-Name; or just adding more Comment-Macros) is performed in the File "./1supply/DenKr_commetnts.tex". Adjust to your needs, the existing entrys may well serve as template for how to do this.
  * Showing these comments in the compiled document can be turned on and off. For that the Value "\\DenKrCommentsUsage" inside the "./2ProjectSetup.tex" is responsible.
  * After finishing writing, set this to 0 and you can be sure that none are left over in the final document.
* Macro to automatically include a "standalone tikz picture" with the best options.
  * Ensures, that the picture does not exceed the page/environment size on any side
  * Allows several options, like rotate, crop, insert as plain-text (render together with main file) or as pre-rendered pdf-picture.
  * If desired the pictures can be included as "buildnew". Means: They are only rendered new, if they changed. Saves a lot of compilation time.
  * Allows explicit scaling and positioning
* tikz:
  * Some 3-Dimensional Graphic Generation done in tikz
  * Flow Graph Toolset
* For sure some more features I can't quite recall. That thing is huge...


### Templates, Examples

Several Files with Templates are contained.
- Most inside "0organization/1all/1main/8templates/"
  - Just some help for kicking off several LaTeX things.
- Some others -- per Document-Genre -- inside the respective Directory "./0rganization/[DocGenre]/1main/8templates/example_chapter/"
  - Chapter/Section Examples with showing how various things can be done.

1. One for a Article/Paper
   * Syntax e.g. for inputting Standalone-TikZ Pictures
2. One for a Poster
   * Syntax for placing the Boxes
3. One for a Book
   * General features

A File that provides Templates for proper Bibtex-Entry-Definition is
  > "./0organization/1main/8templates/literature_1Template.tex"


## Modus Operandi, Nodes, Tipps, Tricks

