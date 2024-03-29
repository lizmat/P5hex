use v6.d;

proto sub hex(|) is export {*}
multi sub hex() { hex CALLER::LEXICAL::<$_> }
multi sub hex(Str() $s) {
    $s ~~ / ^ <[a..f A..F 0..9]>* $ /
      ?? ($s ?? $s.parse-base(16) !! 0)
      !! +$s  # let numerification handle parse errors
}

proto sub oct(|) is export {*}
multi sub oct() { oct CALLER::LEXICAL::<$_> }
multi sub oct(Str() $s is copy) {
    $s .= trim-leading;
    if $s ~~ / \D / {                            # something non-numeric there
        with $s ~~ / ^0 <[xob]> \d+ $/ {           # standard 0x string
            +$_
        }
        else {                                     # not a standard 0x string
            with $s ~~ /^ \d+ / {                    # numeric with trailing
                .Str.parse-base(8)
            }
            else {                                   # garbage
                +$_                                   # throw numification error
            }
        }
    }
    else {                                       # just digits
        $s.parse-base(8)
    }
}

=begin pod

=head1 NAME

Raku port of Perl's hex() / oct() built-ins

=head1 SYNOPSIS

  use P5hex; # exports hex() and oct()

  print hex '0xAf'; # prints '175'
  print hex 'aF';   # same

  $val = oct($val) if $val =~ /^0/;

=head1 DESCRIPTION

This module tries to mimic the behaviour of Perl's C<hex> and C<oct> built-ins
as closely as possible in the Raku Programming Language.

=head1 ORIGINAL PERL 5 DOCUMENTATION

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

=head1 PORTING CAVEATS

In future language versions of Raku, it will become impossible to access the
C<$_> variable of the caller's scope, because it will not have been marked as
a dynamic variable.  So please consider changing:

    hex;

to either:

    hex($_);

or, using the subroutine as a method syntax, with the prefix C<.> shortcut
to use that scope's C<$_> as the invocant:

    .&hex;

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

Source can be located at: https://github.com/lizmat/P5hex . Comments and
Pull Requests are welcome.

=head1 COPYRIGHT AND LICENSE

Copyright 2018, 2019, 2020, 2021, 2023 Elizabeth Mattijsen

Re-imagined from Perl as part of the CPAN Butterfly Plan.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
