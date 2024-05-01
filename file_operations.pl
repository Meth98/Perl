#!/usr/bin/perl -w

# Operations on a file, populated by default

use strict;
use Getopt::Long;
Getopt::Long::config("bundling");
use Term::ANSIColor;
use File::Copy;

my ($create, $upper, $truncate, $remove, $read, $copy);
my $size;
my @new;
my $upper_case;
my $answer;

if (($#ARGV + 1) ne 2) {
        &print_usage;
} else {
        GetOptions(
                "c|cr" => \$create,
                "u|up" => \$upper,
                "t|tr" => \$truncate,
                "d|del" => \$remove,
                "r|re" => \$read,
                "C|cp" => \$copy,
        );

        &create(@ARGV) if defined $create;
        &upper_case(@ARGV) if defined $upper;
        &truncate(@ARGV) if defined $truncate;
        &remove(@ARGV) if defined $remove;
        &read(@ARGV) if defined $read;
        &copyItem(@ARGV) if defined $copy;

        if (! $create and ! $upper and ! $truncate and ! $remove and ! $read and ! $copy) {
                print color "bold red";
                print "Option not recognized by this program!";
                print color "reset";
                &print_usage;
        }
}


sub create {
        if (! -f $_[0]) {
                open(FH, ">", $_[0]) or die "Can't create the file!!\n";
                print FH "unix is great os. unix is opensource. unix is free os.\n";
                print FH "learn operating system.\n";
                print FH "unixlinux which one you choose.\n";
                close(FH);
                print "File created and populated it with text! You can open it and read it!\n";
        } else {
                print "This file already exist!!\n";
        }
}


sub upper_case {
        $size = -s $_[0];    # file size in byte

        if (! -f $_[0]) {
                &fileNotExist;
        } else {
                if ($size != 0) {
                        open(FH, "<", $_[0]);
                        while (<FH>) {
                                $upper_case = uc($_);
                                if ($_ ne $upper_case) {
                                        $_ =~ tr/a-z/A-Z/;
                                        push(@new, $_);
                                } else {
                                        next;
                                }
                        }
                        close(FH);

                        open(FH, ">", $_[0]);
                        print FH @new;
                        close(FH);

                        if ($#new == 0) {
                                print "The text of the file is already in upper-case!!\n";
                        } else {
                                print "The text of the file has been rewritten in upper-case!!\n";
                        }
                } else {
                        print "This file is empty! Remove it and recreate it!\n";
                }
        }
}


sub truncate {
        $size = -s $_[0];

        if (! -f $_[0]) {
                &fileNotExist;
        } else {
                if ($size != 0) {
                        open(FH, "+<", $_[0]);                        # open the file both in reading and in writing
                        seek(FH, 0, 0);                               # pointer in the beginning of the file
                        truncate(FH, tell(FH));                       # truncate the file to where the pointer is located ('tell' to know where it is)
                        close(FH);
                        print "File content truncated!!\n";
                } else {
                        print "This file is empty! Remove it and recreate it!\n";
                }
        }
}


sub remove {
        if (! -f $_[0]) {
                print "Impossible to remove this file, because it has not been found!!\n";
        } else {
                unlink($_[0]);
                print "File removed!!\n";
        }
}


sub read {
        $size = -s $_[0];

        if (! -f $_[0]) {
                &fileNotExist;
        } else {
                if ($size != 0) {
                        open(FH, "<", $_[0]);
                        while(<FH>) {
                                print $_;
                        }
                        close(FH);
                } else {
                        print "This file is empty! Remove it and recreate it!\n";
                }
        }
}


sub copyItem {
        if (! -f $_[0]) {
                &fileNotExist;
        } else {
                print "Type a filename where you want to copy the content of the file $_[0]: ";
                $answer = <STDIN>;

                if ($answer ne "") {
                        $answer =~ s/\n//g;
                        copy($_[0], $answer) or die "Copy failed: $!";
                        print "File content copied in $answer!!\n";
                } else {
                        print "The answer cannot be empty!";
                }
        }
}


sub fileNotExist {
        print color "bold red";
        print "\nWarning!! You should create before the file!\n";
        print color "reset";
        sleep 1;
        &print_usage;
}


sub print_usage {
  print color "green";
  print "\nUsage:\n\n";
  print color "reset";
  print "  $0 [<option>] [<file>]\n\n";
  print color "green";
  print "Options:\n\n";
  print color "reset";
  print<<EOF;
     '-c|--cr' = to create the file\n\n
     '-u|--up' = to transform the file content in upper-case\n\n
     '-t|--tr' = to truncate the file content\n\n
     '-d|--del' = to remove definitively the file\n\n
     '-r|--re' = to read the file\n\n
     '-C|--cp' = to copy the content of the first file into the second file\n\n
  To make all these operations, the file should be exist!!\n
EOF
  exit 1;
}