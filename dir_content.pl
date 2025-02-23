#!/usr/bin/perl -w

# It shows the username and all objects in a directory

use strict;
use Term::ANSIColor;
use Cwd qw(cwd);                # library to know the path

my (@object, @file, @dir) = ();

if (($#ARGV + 1) ne 1) {
        print "Warning!! You should put the system directory path (e.g. /usr), where you want to know the content!\n";
} else {
        if (! -d $ARGV[0]) {
                print "Warning!! The first element should be a directory!\n";
        } else {
                chdir $ARGV[0];
                print color "green";
                print "\nProcessing...\n";
                print color "reset";
                sleep 2;
                @object = glob "*";              # put all dir objects in an array

                foreach (@object) {
                        if (-d $_) {
                                push(@dir, $_);
                        } else {
                                push(@file, $_);
                        }
                }
                
                print color "underline";
                print "\nUsername";
                print color "reset";
                print ": $ENV{ LOGNAME }\n\n";
                sleep 1;
                print color "underline";
                print "Directory";
                print color "reset";
                print ": '$ARGV[0]' = '" . cwd . "'\n\n";
                sleep 1;
                print color "underline";
                print "File";
                print color "reset";
                print ": @file\n\n";
                sleep 1;
                print color "underline";
                print "Directory";
                print color "reset";
                print ": @dir\n\n";
        }
}
