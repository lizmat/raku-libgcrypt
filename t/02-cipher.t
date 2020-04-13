#!/usr/bin/env raku

use Test;
use Gcrypt;
use Gcrypt::Constants;
use Gcrypt::Cipher;

Gcrypt.init(version => '1.7.6');

my $plaintext = 'The quick brown fox jumps over the lazy dog';
my $key = 'this4_#xxyh%%3hasd';

plan Gcrypt::Ciphers.enums.elems;


for Gcrypt::Ciphers.enums.kv -> $name, $algorithm
{
    subtest $name,
    {
        plan 5;

        isa-ok my $obj = Gcrypt::Cipher.new(:$algorithm, :$key),
            Gcrypt::Cipher, 'open';

        ok my $encrypted = $obj.encrypt($plaintext), 'encrypt';

        ok $obj.reset, 'reset';

        ok my $decrypted = $obj.decrypt($encrypted), 'decrypt';

        is $decrypted, $plaintext, 'correct';
    }
}

done-testing;