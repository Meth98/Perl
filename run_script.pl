#!/usr/bin/perl -w

# Run an external Perl script or Shell script

use strict;
use Term::ANSIColor;
use Cwd qw(getcwd);

my ($script, @args) = ();
$script = $ARGV[0];
shift;
@args = "@ARGV";

if (defined($script)) {
        if ($script =~ /\.sh$/i) {
                &search;

                if (-f $script) {
                        system("sh $script @args");                                             # run a Shell script
                } else {
                        print "\nThis script has not been found in the current directory: '" . getcwd . "'!!\n\n";
                }
        } elsif ($script =~ /\.pl$/i) {
                &search;
                
                if (-f $script) {
                        system("/usr/bin/perl $script @args");                                  # run a Perl script
                } else {
                        print "\nThis script has not been found in the current directory: '" . getcwd . "'!!\n\n";
                }
        } else {
                print color "bold red";
                print "\nWarning!! You should put a Shell script or a Perl script!\n";
                print color "reset";
                sleep 1;
                &print_usage;
        }
} else {
        &print_usage;
}


sub search {
        print "\nSearch this script in the current directory...\n";
        system("ls -l");                                                                # run the command in the parenthesis
        sleep 2;
        print "\n---------------------------------------\n";
}


sub print_usage {
        print color "green";
        print "\nUsage:\n\n";
        print color "reset";
        print " $0 [<script>] [<params>]\n\n";
        print "  Script = Shell script or Perl script\n\n";
        exit 1;
}