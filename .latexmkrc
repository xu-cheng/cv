# vim: set filetype=perl:

$pdflatex = 'lualatex --shell-escape --synctex=1 %O %S';
$pdf_mode = 1;
$max_repeat = 5;
$clean_ext = 'bbl blg run.xml synctex.gz';
$clean_full_ext = '*.xmpi';

no warnings 'redefine';

# Overwrite `cleanup1` functions to support more general pattern in $clean_ext.
# Ref: https://github.com/e-dschungel/latexmk-config/blob/master/latexmkrc
sub cleanup1 {
    my $dir = fix_pattern( shift );
    my $root_fixed = fix_pattern( $root_filename );
    foreach (@_) {
        (my $name = (/%R/ || /[\*\?]/) ? $_ : "%R.$_") =~ s/%R/$dir$root_fixed/;
        unlink_or_move( glob( "$name" ) );
    }
}
