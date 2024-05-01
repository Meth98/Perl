#!/usr/bin/perl -w

# Factorial of a number

use strict;
use Scalar::Util qw(looks_like_number);
use bignum;					# to manage big numbers

my $flag = 0;
my $header;
my $msg = "";

if (($#ARGV + 1) eq 0) {
        print "Warning!! You should put a number whose you want the factorial!\n";
} else {
        for (@ARGV) {
                if (looks_like_number($_)) {
                        $flag = 1;
                        $header = "\nThe factorial is:\n\n";
                        $msg .= "$_\! = " . &factorial($_) . "\n\n";
                }
        }

	if ($flag) {
                print "$header";
                sleep 2;
                print "$msg";
        } else {
		print "Warning!! You can't put the characters!\n";
	}
}


sub factorial {
        my $x = $_[0];
        my $y = ($x - 1);

        while ($y > 0) {
                $x = $x * $y;
                $y--;
        }

        return $x;
}