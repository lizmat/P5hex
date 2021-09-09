[![Actions Status](https://github.com/lizmat/P5hex/workflows/test/badge.svg)](https://github.com/lizmat/P5hex/actions)

NAME
====

Raku port of Perl's hex() / oct() built-ins

SYNOPSIS
========

    use P5hex; # exports hex() and oct()

    print hex '0xAf'; # prints '175'
    print hex 'aF';   # same

    $val = oct($val) if $val =~ /^0/;

DESCRIPTION
===========

This module tries to mimic the behaviour of Perl's `hex` and `oct` built-ins as closely as possible in the Raku Programming Language.

ORIGINAL PERL 5 DOCUMENTATION
=============================

    hex EXPR
    hex     Interprets EXPR as a hex string and returns the corresponding
            value. (To convert strings that might start with either 0, "0x",
            or "0b", see "oct".) If EXPR is omitted, uses $_.

                print hex '0xAf'; # prints '175'
                print hex 'aF';   # same

            Hex strings may only represent integers. Strings that would cause
            integer overflow trigger a warning. Leading whitespace is not
            stripped, unlike oct(). To present something as hex, look into
            "printf", "sprintf", and "unpack".


    oct EXPR
    oct     Interprets EXPR as an octal string and returns the corresponding
            value. (If EXPR happens to start off with "0x", interprets it as a
            hex string. If EXPR starts off with "0b", it is interpreted as a
            binary string. Leading whitespace is ignored in all three cases.)
            The following will handle decimal, binary, octal, and hex in
            standard Perl notation:

                $val = oct($val) if $val =~ /^0/;

            If EXPR is omitted, uses $_. To go the other way (produce a number
            in octal), use sprintf() or printf():

                $dec_perms = (stat("filename"))[2] & 07777;
                $oct_perm_str = sprintf "%o", $perms;

            The oct() function is commonly used when a string such as 644
            needs to be converted into a file mode, for example. Although Perl
            automatically converts strings into numbers as needed, this
            automatic conversion assumes base 10.

            Leading white space is ignored without warning, as too are any
            trailing non-digits, such as a decimal point ("oct" only handles
            non-negative integers, not negative integers or floating point).

PORTING CAVEATS
===============

In future language versions of Raku, it will become impossible to access the `$_` variable of the caller's scope, because it will not have been marked as a dynamic variable. So please consider changing:

    hex;

to either:

    hex($_);

or, using the subroutine as a method syntax, with the prefix `.` shortcut to use that scope's `$_` as the invocant:

    .&hex;

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/P5hex . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2018, 2019, 2020, 2021 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

