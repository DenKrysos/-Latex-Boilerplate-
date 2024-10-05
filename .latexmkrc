# This file sets up to compile a LaTeX Project with/for the following Structure
# It uses LuaLaTeX (or pdfLaTeX - change the value for the Compiler, i.e. $pdf_mode).
#   (Individual directory levels or files can certainly be renamed)
#   (But the basic idea is to have that nested structure; separate of input/src and output/aux; the latexmkrc (this file here) paralle and separate; the resulting .pdf file separate in the Root-Dir.
# /ProjectRootDir/
#       |-- .0build/     (or 'tmp/')
#              |-- <Will move the temporary/aux Files here>
#              |-- [...]
#       |-- src/
#              |-- <Source-Files to be compiled (.tex, .bib)>
#              |-- main.tex
#              |-- [...]
#       |-- latexmkrc  <This file here>
#       |-- <Created Output-File>
#       |-- result.pdf
#       |-- result.synctex
#
# Miscellaneous:
# - Just saying, the Programming-Language used for this file is 'Perl'

#todo:
# - clean



######################################
# Preferences  #######################
#=====================================
#=== In case the entire Project's Source-Files are wrapped into a Sub-Directory. (If not, declare empty: '')
$SubSrcDir='src';
#=== The main-File to be passed to the Compiler
$MainSrcFile='1main';
#=== How the resulting Doc shall be named (After succesfull compilation, the Post-File copies to root and names like this)
$resultName='1compiled';
# $resultName=$MainSrcFile;



######################################
# Output/Result  #####################
#=====================================
#=== Name of the resulting Output File (and aux files)  -  Adding %A appends the source file-name
##===   E.g. $jobname = '%A-result-lualatex';
# $jobname=$resultName;
$jobname=$MainSrcFile;



######################################
# Modules  ###########################
#=====================================
use File::Spec;
use File::Find;



######################################
# Some Set-Up  #######################
#=====================================
my $MainFile_Concat=catfile($SubSrcDir,$MainSrcFile);
### print "DenKr: Concatenated Main-Src-File and Sub-Dir: $MainFile_Concat\n";
my $SourceFile_toBuild=$MainSrcFile;
# $SourceFile_toBuild=$MainFile_Concat;




######################################
# Cmd-Line Args  #####################
#=====================================
#=== Create something that mimics the specification of an input-file.
##===   This also create something that behaves like Cmd-Line Arguments for the File to compile
$CmdLineArgs= '\newcommand{\DenKrCmdLineArgs}{outputType=paper,srcSubDir="'.catfile($SubSrcDir,'\"').'}';
$InputMimicActualInputFile= '\input{'.$SourceFile_toBuild.'.tex}';
$InputMimic= '"'.$CmdLineArgs.$InputMimicActualInputFile.'"';



######################################
# Compiler-Version  ##################
#=====================================
#=== Specify the Tex-Version to use, by prepending its bin-dir to PATH
# $texlive_version_toUse='C:\texlive\2022\bin\win32';
# $texlive_version_toUse='C:\texlive\2023\bin\windows';
# $texlive_version_toUse='C:\texlive\2024\bin\windows';
# $ENV{PATH}="$texlive_version_toUse;".$ENV{PATH};
# print "DenKr: Env-Path: $ENV{PATH}\n";



######################################
# Creating Source to Build  ##########
#=====================================
# $Source_toBuild=%S;
# $Source_toBuild=$InputMimic;
$Source_toBuild="\"$SourceFile_toBuild.tex\"";
print "DenKr: Building Source: ->$Source_toBuild<-\n";



######################################
# Compiler-Call  #####################
#=====================================
#=== Preparing some Commands for the Compiler Call
##===  -halt-on-error
$pdflatex='pdflatex --synctex=-1 --interaction=nonstopmode --shell-escape --src-specials %O '.$Source_toBuild;
$lualatex='lualatex --synctex=-1 --interaction=nonstopmode --shell-escape %O '
	.$Source_toBuild
;
#=== NOTE:
#===   - Synctex: 0: No-Synctex | <Otherwise>: Synctex || <PositiveNumber>: gzipped | <NegativeNumber>: uncompressed
#===      - The default behavior is that the .synctex file is compressed (gzip). That saves a lot of space relatively (~Factor 4.5). But still, roughly for a 500 page book, the uncompressed file is about 15 MB.
#===      -> synctex=1 makes it default (gzip compressed), giving a file .synctex.gz
#===      -> syncted=-1 omits compression, giving a file .synctex
#===      - Compressed can be problematic when building a rather complex environment, like with external Viewer, Code-Editor, compiling over latexmk or makefile.
#===      - Uncompressed can be somewhat quicker for forward- & inverse-search.
#===      - Some Synctex-compatible viewers would uncompress the synctex file again anyway...
#===   - pdf_mode: 0: Generate-No-Pdf | 1: $pdflatex | 2: $ps2pdf | 3: $dvipdf | 4: $lualatex | 5:$xelatex & $xdvipdfmx
# - - - - - - - - - - - - - - - - - -
#=== Assigning the Compiler Command to be called. (I think, these are redundant
#$latex=$lualatex;
$pdf_mode=4;
$postscript_mode=$dvi_mode=0;



######################################
# File(s)  ###########################
#=====================================
#=== The File(s) to compile
##===   Don't need to have the extension ".tex" specified, only when other then ".tex"
##===     E.g. @default_files = ("main", "1main", "otherProject");
@default_files=("$MainSrcFile");



######################################
# Path-Definitions  ##################
#=====================================
#=== Use some Perl Stuff to acquire the Path to the currently processed latexmkrc File.
#=== Define the relative path from the latexmkrc file
my $script_relP=File::Spec->catdir();# $SubSrcDir
#=== Convert the relative path to an absolute path
my $script_absP=File::Spec->rel2abs($script_relP);
print "DenKr: Path to latexmkrc File: $script_absP\n";
#=== The 'Base-Directory'. The common Folder, where generated Files are put
#my $dir_baseGen=dirname($script_absP);
my $dir_baseGen=$script_absP;



######################################
# Directories  #######################
#=====================================
#=== Additional Directories to also search for Files
##===    $ENV{'TEXINPUTS'} = "./src//:";
# ensure_path('TEXINPUTS', './src/');
# ensure_path('TEXINPUTS', './'.$SubSrcDir.'/');
# ensure_path('BIBINPUTS', './src/');
# ensure_path('BIBINPUTS', './'.$SubSrcDir.'/');
# ensure_path('BSTINPUTS', './src/');
# ensure_path('BSTINPUTS', './'.$SubSrcDir.'/');
pushd("$SubSrcDir");
# $do_cd=1;



######################################
# Created-File's Directories  ########
#=====================================
#=== During Compilation several Files will be created. And this Latexmkrc sets things up, so that such are put to dedicated directories.
##=== 'Aux' Files: Temporary stuff; required during compilation; afterwards to be considered garbage.
##=== Then we the 'actual Result': Mainly the .pdf, we want to create (or dvi, ps, etc.), plus a .synctex File (for this forward-reverse-search between pdf and editor)
##===   Such Result-Files however, come in '2 Forms':
###===     - Intermediate: One 'whole round' of compilation may actually involve multiple consecutive compiler runs. One single run may not result in a really final document, but it still creates a .pdf.
###===     - Truly Final: After a couple runs, we have the actual final Result Files.
#=== Here are the Sub-Directories specified for these 3 Types of Files.
##===   aux_dir for Tmp-Files. out_dir for Intermediate Results. our2_dir for Final Results.
$aux_dir_base='.0build';
$out_dir_base='.1out_pre';
$out2_dir_base='.2out_final';



######################################
# *Final* Out-Directory, Result  #####
#=====================================
#=== After a 'Whole Round of Compilations', the actual finally resulting Files are copied here.
$out2_dir=catfile($dir_baseGen,$out2_dir_base);
#=== Intermediate Results go here.
$out_dir=catfile($dir_baseGen,$out_dir_base);



######################################
# Clean-Up, Tmp, Aux  ################
#=====================================
#=== Keeping the Project clean and in order. I.e. , 
##===   Determine where to store temp/aux Files; where to put the resulting Document
##=== Then, explicitly create the aux_dir, so that it is available, e.g. for the Custom-File-Generation below.
##===    The $aux_dir will be accessible here as %Y, the $out_dir as %Z. (Suitable values $aux_dir: 'tmp', '../tmp', '.0build' | $out_dir: '.', '../')
$aux_dir=catfile($dir_baseGen,$aux_dir_base);
$emulate_aux=1;#Needed with texlive, because it doesn't support the '-aux-directory' option
print "DenKr(latexmkrc): Create Directory: $aux_dir\n";
eval{
    mkdir($aux_dir, 0777);
    1;# Ensure the block returns true
}or do{
    if($! =~ /File exists/){
        # Ignore the "File exists" error
        warn "Directory already exists: $directory\n";
    }else{
        # Handle other errors
        die "Failed to create directory: $!\n";
    }
};
##===  How and What to clean. What is to be considered temp/aux
##===    Default is: @generated_exts[( ’aux’, ’bcf’, ’fls’, ’idx’, ’ind’, ’lof’, ’lot’, ’out’, ’toc’, ’blg’, ’ilg’, ’log’, ’xdv’ )]
@generated_exts=(@generated_exts, 'thm', 'snm', 'nav', 'vrb', 'bbl', 'ist', 'xdy', 'run.xml', 'fdb_latexmk');
push @generated_exts, 'lol', 'loa';
#=== Generated Files for glossaries.sty
push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'sym', 'sbl';
# - - - - - - - - - - - - - - - - - -
$clean_ext .= ' %R.ist %R.xdy';
push @clean_ext, 'synctex', 'synctex(busy)', 'synctex.gz', 'synctex.gz(busy)', 'synctex.gz.sum.synctex';
push @clean_ext, 'pdf';



######################################
# Additional Aux-Directories  ########
#    (Standalone compatibility)  #####
#=====================================
#=== Create additional Sub-Folders inside the aux_dir
#=== E.g. For creating Standalone(TikZ) Files' build-tmp-files also in the aux_dir
my $source_dir=catfile($script_absP,$SubSrcDir);
my $target_dir=$aux_dir;
print "DenKr(latexmkrc): Create Sub-Directories inside: $aux_dir\n";
print "   -- Src: \'$source_dir\'\n";
print "   --> Dst: \'$target_dir\'\n";
sub mkSubTgtDir{
    # Retrieve the arguments
    my ($subDir,$tgt) = @_;
    $newDir=catfile($tgt,$subDir);
    #print "DenKr(latexmkrc): Create Sub-Directory: $newDir\n";
    eval{
        mkdir($newDir, 0777);
        1;# Ensure the block returns true
    }or do{
        if($! =~ /File exists/){
            # Ignore the "File exists" error
            warn "Directory already exists: $newDir\n";
        }else{
            # Handle other errors
            die "Failed to create directory: $!\n";
        }
    };
}
sub get_dir_hier{
    my ($src)=@_;
    my @dirs;
    find({
        wanted => sub{
            my $src_path=$File::Find::name;
            return if -f $src_path;# Skip if File
            # Convert to relative path
            my $rel_path = File::Spec->abs2rel($src_path, $src);
            push @dirs, $rel_path;
        },
        no_chdir => 1,
    },$src);
    #print join("\n", @dirs);
    return \@dirs;
}
sub copy_dir_hier{
    my ($dirs, $tgt, $verbose) = @_;
    for my $dir (@$dirs){
        next if not $dir;
        #print "mkdir $tgt/$dir\n" if $verbose;
        mkSubTgtDir($dir,$tgt);
    }   
}
# Read the Hierarchy from the Src-Dir
my $cpy_dirs=get_dir_hier($source_dir);
# Create Sub-Folders inside Target-Dir (aux)
copy_dir_hier($cpy_dirs,$target_dir,1);
# To have a proper name for the Cleaning below
my $clean_dirs=$target_dir;



######################################
# Bibliography  ######################
#=====================================
#=== Set-Up for Biblatex/Biber (is actually just the default)
$biber='biber %O %S';



######################################
# Glossaries  ########################
#=====================================
#=== For creating a Glossary (glossaries.sty, makeglossaries)
$makeindex='makeindex "%O" -s "%S" -o "%D" "%T"';
#$makeindex_fudge=1;
# - - - - - - - - - - - - - - - - - -
#=== Define some functions to fulfill the task of running makeglossaries/makeindex
sub makeglossaries{
    # $prev_workDir = $ENV{'PWD'} || '.';
    # print "DenKr: Current Work-Dir: $prev_workDir\n";
    my ($base_name, $path) = fileparse( $_[0] );
    # chdir($path) or die "Cannot chdir to $path: $!";
    my @args=( "-q", "-d", "$path", "$base_name" );
    if ($silent) { unshift @args, "-q"; }
    print "DenKr: Path-Var: $path\n";
    #=== A space after "$path " is required. Perhaps to avoid mistakenly escaping the " through a trailing \. I don't know... Whatever...
    $retVal=system "makeglossaries", "-d", "$path ", "$base_name";
    # $retVal= system "makeglossaries", "-C", "utf8", "-d", "\"$path\"", "$base_name";
    return $retVal;
}
sub makeglo2gls{
    system("makeindex -s '$_[0]'.ist -t '$_[0]'.glg -o '$_[0]'.gls '$_[0]'.glo");
}
sub run_makeglossaries{
    my ($base_name, $path) = fileparse( $_[0] ); #handle -outdir param by splitting path and file, ...
    pushd $path; # ... cd-ing into folder first, then running makeglossaries ...
    if ( $silent ) {
        system "makeglossaries -q '$base_name'"; #unix
        # system "makeglossaries", "-q", "$base_name"; #windows
    }
    else {
        system "makeglossaries '$base_name'"; #unix
        # system "makeglossaries", "$base_name"; #windows
    };
    popd; # ... and cd-ing back again
}
# - - - - - - - - - - - - - - - - - -
#=== Assign dependencies to one of the functions above, so that the routine is run
add_cus_dep('acn', 'acr', 0, 'makeglossaries');
add_cus_dep('glo', 'gls', 0, 'makeglossaries');
#add_cus_dep('sym', 'sbl', 0, 'makeglossaries');#Apparently not required



######################################
# Custom-Generated File  #############
#=====================================
#=== Generates a File during Compilation, that can be used by .tex Files in the Project (\IfFileExists{}{}{})
##===  This File will contain the Src-Files' Sub-Directory.
sub generate_tex_file__nestedSrcDir{
    my $source=shift;
    my $filebase="$aux_dir";
    my $filename='DenKrNestedSrcDir';
    my $tex_content="$SubSrcDir/";
    open(my $tex_fh, '>', "$filebase/$filename.tex") or die "Could not open file $filebase/$filename.tex: $!";
    print "DenKr: $tex_fh $tex_content\n";
    close $tex_fh;
}
# Currently not needed
# generate_tex_file__nestedSrcDir();



######################################
# Pre-Build Steps  ##################
#=====================================
my $pre_script=".latexmk_pre";
my $pre_script_abs=catfile($script_absP,$pre_script);
my $pre_cmd="perl \"$pre_script_abs\" \"$script_absP\"";
#=== Start of Compilation
# $compiling_cmd=$pre_cmd;



######################################
# Post-Build Steps  ##################
#=====================================
my $post_script=".latexmk_post";
my $post_script_abs=catfile($script_absP,$post_script);
my $post_cmd="perl \"$post_script_abs\" \"$clean_dirs\" \"$script_absP\" \"$out2_dir_base\" \"$MainSrcFile.pdf\" \"$resultName.pdf\"";
#=== After of Compilation (depending on sucess, warning, error)
$success_cmd=$post_cmd;
$warning_cmd=$post_cmd;
# $failure_cmd="";



######################################
# PDF Previewer  #####################
#=====================================
#=== PDF preview, synctex, forward & reverse/inverse Search
# $SumatraPDF_path='"../!_0_Settings/SumatraPDF/SumatraPDF.exe"';
# $TexEditorVSCode_path='\"C:/Program Files/Microsoft VS Code/Code.exe\"';
# $TexEditorVSCode_InverseArg='-r -g \"%f:%l\"';
# $SumatraPDF_inverseCmdArg='-inverse-search "'.$TexEditor_path.' '.$TexEditor_InverseArg.'"';
# - - - - - - - - - - - - - - - - - -
# $pdf_previewer = $SumatraPDF_path.' -reuse-instance '.$SumatraPDF_inverseCmdArg.' %O %S';
# $preview_mode=1;
# $pdf_update_method=4;
# $pdf_update_command = $SumatraPDF_path.' -reuse-instance %O %S';







######################################
# Attachment  ########################
#=====================================
# Sources
## [1] Valuable example rc-Files from the latexmk's Author: https://www.ctan.org/tex-archive/support/latexmk/example_rcfiles