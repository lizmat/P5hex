use v6.*;
use Test;
use P5hex;

plan 4;

for <abc 0xabc> {
    is hex($_), 2748, "did $_ explicitely get handled ok";
    is .&hex,   2748, "did $_ implicitely get handled ok";
}

# vim: expandtab shiftwidth=4
