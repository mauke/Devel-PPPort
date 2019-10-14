################################################################################
#
#            !!!!!   Do NOT edit this file directly!   !!!!!
#
#            Edit mktests.PL and/or parts/inc/misc instead.
#
#  This file was automatically generated from the definition files in the
#  parts/inc/ subdirectory by mktests.PL. To learn more about how all this
#  works, please read the F<HACKERS> file that came with this distribution.
#
################################################################################

BEGIN {
  if ($ENV{'PERL_CORE'}) {
    chdir 't' if -d 't';
    @INC = ('../lib', '../ext/Devel-PPPort/t') if -d '../lib' && -d '../ext';
    require Config; import Config;
    use vars '%Config';
    if (" $Config{'extensions'} " !~ m[ Devel/PPPort ]) {
      print "1..0 # Skip -- Perl configured without Devel::PPPort module\n";
      exit 0;
    }
  }
  else {
    unshift @INC, 't';
  }

  sub load {
    eval "use Test";
    require 'testutil.pl' if $@;
  }

  if (17736) {
    load();
    plan(tests => 17736);
  }
}

use Devel::PPPort;
use strict;
BEGIN { $^W = 1; }

package Devel::PPPort;
use vars '@ISA';
require DynaLoader;
@ISA = qw(DynaLoader);
bootstrap Devel::PPPort;

package main;

use vars qw($my_sv @my_av %my_hv);

ok(&Devel::PPPort::boolSV(1));
ok(!&Devel::PPPort::boolSV(0));

$_ = "Fred";
ok(&Devel::PPPort::DEFSV(), "Fred");
ok(&Devel::PPPort::UNDERBAR(), "Fred");

if ("$]" >= 5.009002 && "$]" < 5.023 && "$]" < 5.023004) {
  eval q{
    no warnings "deprecated";
    no if $^V > v5.17.9, warnings => "experimental::lexical_topic";
    my $_ = "Tony";
    ok(&Devel::PPPort::DEFSV(), "Fred");
    ok(&Devel::PPPort::UNDERBAR(), "Tony");
  };
}
else {
  ok(1);
  ok(1);
}

my @r = &Devel::PPPort::DEFSV_modify();

ok(@r == 3);
ok($r[0], 'Fred');
ok($r[1], 'DEFSV');
ok($r[2], 'Fred');

ok(&Devel::PPPort::DEFSV(), "Fred");

eval { 1 };
ok(!&Devel::PPPort::ERRSV());
eval { cannot_call_this_one() };
ok(&Devel::PPPort::ERRSV());

ok(&Devel::PPPort::gv_stashpvn('Devel::PPPort', 0));
ok(!&Devel::PPPort::gv_stashpvn('does::not::exist', 0));
ok(&Devel::PPPort::gv_stashpvn('does::not::exist', 1));

$my_sv = 1;
ok(&Devel::PPPort::get_sv('my_sv', 0));
ok(!&Devel::PPPort::get_sv('not_my_sv', 0));
ok(&Devel::PPPort::get_sv('not_my_sv', 1));

@my_av = (1);
ok(&Devel::PPPort::get_av('my_av', 0));
ok(!&Devel::PPPort::get_av('not_my_av', 0));
ok(&Devel::PPPort::get_av('not_my_av', 1));

%my_hv = (a=>1);
ok(&Devel::PPPort::get_hv('my_hv', 0));
ok(!&Devel::PPPort::get_hv('not_my_hv', 0));
ok(&Devel::PPPort::get_hv('not_my_hv', 1));

sub my_cv { 1 };
ok(&Devel::PPPort::get_cv('my_cv', 0));
ok(!&Devel::PPPort::get_cv('not_my_cv', 0));
ok(&Devel::PPPort::get_cv('not_my_cv', 1));

ok(Devel::PPPort::dXSTARG(42), 43);
ok(Devel::PPPort::dAXMARK(4711), 4710);

ok(Devel::PPPort::prepush(), 42);

ok(join(':', Devel::PPPort::xsreturn(0)), 'test1');
ok(join(':', Devel::PPPort::xsreturn(1)), 'test1:test2');

ok(Devel::PPPort::PERL_ABS(42), 42);
ok(Devel::PPPort::PERL_ABS(-13), 13);

ok(Devel::PPPort::SVf(42), "$]" >= 5.004 ? '[42]' : '42');
ok(Devel::PPPort::SVf('abc'), "$]" >= 5.004 ? '[abc]' : 'abc');

ok(&Devel::PPPort::Perl_ppaddr_t("FOO"), "foo");

ok(&Devel::PPPort::ptrtests(), 63);

ok(&Devel::PPPort::OpSIBLING_tests(), 0);

if ("$]" >= 5.009000) {
  eval q{
    ok(&Devel::PPPort::check_HeUTF8("hello"), "norm");
    ok(&Devel::PPPort::check_HeUTF8("\N{U+263a}"), "utf8");
  };
} else {
  ok(1, 1);
  ok(1, 1);
}

@r = &Devel::PPPort::check_c_array();
ok($r[0], 4);
ok($r[1], "13");

ok(!Devel::PPPort::SvRXOK(""));
ok(!Devel::PPPort::SvRXOK(bless [], "Regexp"));

if ("$]" < 5.005) {
        skip 'no qr// objects in this perl', 0;
        skip 'no qr// objects in this perl', 0;
} else {
        my $qr = eval 'qr/./';
        ok(Devel::PPPort::SvRXOK($qr));
        ok(Devel::PPPort::SvRXOK(bless $qr, "Surprise"));
}

ok( Devel::PPPort::NATIVE_TO_LATIN1(0xB6) == 0xB6);
ok( Devel::PPPort::NATIVE_TO_LATIN1(0x1) == 0x1);
ok( Devel::PPPort::NATIVE_TO_LATIN1(ord("A")) == 0x41);
ok( Devel::PPPort::NATIVE_TO_LATIN1(ord("0")) == 0x30);

ok( Devel::PPPort::LATIN1_TO_NATIVE(0xB6) == 0xB6);
if (ord("A") == 65) {
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x41) == 0x41);
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x30) == 0x30);
}
else {
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x41) == 0xC1);
    ok( Devel::PPPort::LATIN1_TO_NATIVE(0x30) == 0xF0);
}

ok(  Devel::PPPort::isALNUMC_L1(ord("5")));
ok(  Devel::PPPort::isALNUMC_L1(0xFC));
ok(! Devel::PPPort::isALNUMC_L1(0xB6));

ok(  Devel::PPPort::isOCTAL(ord("7")));
ok(! Devel::PPPort::isOCTAL(ord("8")));

ok(  Devel::PPPort::isOCTAL_A(ord("0")));
ok(! Devel::PPPort::isOCTAL_A(ord("9")));

ok(  Devel::PPPort::isOCTAL_L1(ord("2")));
ok(! Devel::PPPort::isOCTAL_L1(ord("8")));

# For the other properties, we test every code point from 0.255, and a
# smattering of higher ones.  First populate a hash with keys like '65:ALPHA'
# to indicate that the code point there is alphabetic
my $i;
my %types;
for $i (0x41..0x5A, 0x61..0x7A, 0xAA, 0xB5, 0xBA, 0xC0..0xD6, 0xD8..0xF6,
        0xF8..0x101)
{
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:ALPHA"} = 1;
    $types{"$native:ALPHANUMERIC"} = 1;
    $types{"$native:IDFIRST"} = 1;
    $types{"$native:IDCONT"} = 1;
    $types{"$native:PRINT"} = 1;
    $types{"$native:WORDCHAR"} = 1;
}
for $i (0x30..0x39, 0x660, 0xFF19) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:ALPHANUMERIC"} = 1;
    $types{"$native:DIGIT"} = 1;
    $types{"$native:IDCONT"} = 1;
    $types{"$native:WORDCHAR"} = 1;
    $types{"$native:GRAPH"} = 1;
    $types{"$native:PRINT"} = 1;
    $types{"$native:XDIGIT"} = 1 if $i < 255 || ($i >= 0xFF10 && $i <= 0xFF19);
}

for $i (0..0x7F) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:ASCII"} = 1;
}
for $i (0..0x1f, 0x7F..0x9F) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:CNTRL"} = 1;
}
for $i (0x21..0x7E, 0xA1..0x101, 0x660) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:GRAPH"} = 1;
    $types{"$native:PRINT"} = 1;
}
for $i (0x09, 0x20, 0xA0) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:BLANK"} = 1;
    $types{"$native:SPACE"} = 1;
    $types{"$native:PSXSPC"} = 1;
    $types{"$native:PRINT"} = 1 if $i > 0x09;
}
for $i (0x09..0x0D, 0x85, 0x2029) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:SPACE"} = 1;
    $types{"$native:PSXSPC"} = 1;
}
for $i (0x41..0x5A, 0xC0..0xD6, 0xD8..0xDE, 0x100) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:UPPER"} = 1;
    $types{"$native:XDIGIT"} = 1 if $i < 0x47;
}
for $i (0x61..0x7A, 0xAA, 0xB5, 0xBA, 0xDF..0xF6, 0xF8..0xFF, 0x101) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:LOWER"} = 1;
    $types{"$native:XDIGIT"} = 1 if $i < 0x67;
}
for $i (0x21..0x2F, 0x3A..0x40, 0x5B..0x60, 0x7B..0x7E, 0xB6, 0xA1, 0xA7, 0xAB,
        0xB7, 0xBB, 0xBF, 0x5BE)
{
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    $types{"$native:PUNCT"} = 1;
    $types{"$native:GRAPH"} = 1;
    $types{"$native:PRINT"} = 1;
}

$i = ord('_');
$types{"$i:WORDCHAR"} = 1;
$types{"$i:IDFIRST"} = 1;
$types{"$i:IDCONT"} = 1;

# Now find all the unique code points included above.
my %code_points_to_test;
my $key;
for $key (keys %types) {
    $key =~ s/:.*//;
    $code_points_to_test{$key} = 1;
}

# And test each one
for $i (sort { $a <=> $b } keys %code_points_to_test) {
    my $native = Devel::PPPort::LATIN1_TO_NATIVE($i);
    my $hex = sprintf("0x%02X", $native);

    # And for each code point test each of the classes
    my $class;
    for $class (qw(ALPHA ALPHANUMERIC ASCII BLANK CNTRL DIGIT GRAPH IDCONT
                   IDFIRST LOWER PRINT PSXSPC PUNCT SPACE UPPER WORDCHAR
                   XDIGIT))
    {
        if ($i < 256) {  # For the ones that can fit in a byte, test each of
                         #three macros.
            my $suffix;
            for $suffix ("", "_A", "_L1") {
                my $should_be = ($i > 0x7F && $suffix ne "_L1")
                                ? 0     # Fail on non-ASCII unless L1
                                : ($types{"$native:$class"} || 0);
                my $eval_string = "Devel::PPPort::is${class}$suffix($hex)";
                my $is = eval $eval_string || 0;
                die "eval 'For $i: $eval_string' gave $@" if $@;
                ok($is, $should_be, "'$eval_string'");
            }
        }

        # For all code points, test the '_utf8' macros
        if ("$]" < 5.006) {
            skip("No UTF-8 on this perl", 0);
            if ($i > 255) {
                skip("No UTF-8 on this perl", 0);
            }
        }
        else {
            my $utf8 = quotemeta Devel::PPPort::uvoffuni_to_utf8($i);
            if ("$]" < 5.007 && $native > 255) {
                skip("Perls earlier than 5.7 give wrong answers for above Latin1 code points", 0);
            }
            elsif ("$]" <= 5.011003 && $native == 0x2029 && ($class eq 'PRINT' || $class eq 'GRAPH')) {
                skip("Perls earlier than 5.11.3 considered high space characters as isPRINT and isGRAPH", 0);
            }
            else {

                my $should_be = $types{"$native:$class"} || 0;
                my $eval_string = "Devel::PPPort::is${class}_utf8_safe(\"$utf8\", 0)";
                my $is = eval $eval_string || 0;
                die "eval 'For $i, $eval_string' gave $@" if $@;
                ok($is, $should_be, sprintf("For U+%04X '%s'", $native, $eval_string));
            }

            # And for the high code points, test that a too short malformation (the
            # -1) causes it to fail
            if ($i > 255) {
                if ("$]" >= 5.025009) {
                    skip("Prints an annoying error message that khw doesn't know how to easily suppress", 0);
                }
                else {
                    my $eval_string = "Devel::PPPort::is${class}_utf8_safe(\"$utf8\", -1)";
                    my $is = eval "no warnings; $eval_string" || 0;
                    die "eval '$eval_string' gave $@" if $@;
                    ok($is, 0, sprintf("For U+%04X '%s'", $native, $eval_string));
                }
            }
        }
    }
}

if ("$]" < 5.006000) {
    my $i;
    for $i (1..58) {    # Should be 44, don't know why not
        skip 'UTF-8 not implemented on this perl', 0;
    }
}
else {
    my $ret = Devel::PPPort::toLOWER_utf8_safe('A', 0);
    ok($ret->[0], ord 'a', "ord of lowercase of A is 97");
    ok($ret->[1], 'a', "Lowercase of A is a");
    ok($ret->[2], 1, "Length of lowercase of A is 1");

    my $utf8 = Devel::PPPort::uvoffuni_to_utf8(0xC0);
    my $lc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0xE0);
    $ret = Devel::PPPort::toLOWER_utf8_safe($utf8, 0);
    ok($ret->[0], Devel::PPPort::LATIN1_TO_NATIVE(0xE0), "ord of lowercase of 0xC0 is 0xE0");
    ok($ret->[1], $lc_utf8, "Lowercase of UTF-8 of 0xC0 is 0xE0");
    ok($ret->[2], 2, "Length of lowercase of UTF-8 of 0xC0 is 2");

    $utf8 = Devel::PPPort::uvoffuni_to_utf8(0x100);
    $lc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0x101);
    $ret = Devel::PPPort::toLOWER_utf8_safe($utf8, 0);
    ok($ret->[0], 0x101, "ord of lowercase of 0x100 is 0x101");
    ok($ret->[1], $lc_utf8, "Lowercase of UTF-8 of 0x100 is 0x101");
    ok($ret->[2], 2, "Length of lowercase of UTF-8 of 0x100 is 2");

    my $eval_string = "Devel::PPPort::toLOWER_utf8_safe(\"$utf8\", -1);";
    $ret = eval $eval_string;
    my $fail = $@;  # Have to save $@, as it gets destroyed
    ok($ret, undef, "Returns undef for illegal short char");
    ok($fail, eval 'qr/Malformed UTF-8 character/', 'Gave appropriate error for short char');

    if ("$]" > 5.025008) {
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
    }
    else {
        $eval_string = "Devel::PPPort::toLOWER_utf8_safe(\"$utf8\", -3);";
        $ret = eval $eval_string;
        $fail = $@;
        ok($ret, undef, "Returns undef for zero length string");
        ok($fail, eval 'qr/Attempting case change on zero length string/',
           'Gave appropriate error for short char');
    }

    $ret = Devel::PPPort::toUPPER_utf8_safe('b', 0);
    ok($ret->[0], ord 'B', "ord of uppercase of b is 66");
    ok($ret->[1], 'B', "Uppercase of b is B");
    ok($ret->[2], 1, "Length of uppercase of b is 1");

    $utf8 = Devel::PPPort::uvoffuni_to_utf8(0xE1);
    my $uc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0xC1);
    $ret = Devel::PPPort::toUPPER_utf8_safe($utf8, 0);
    ok($ret->[0], Devel::PPPort::LATIN1_TO_NATIVE(0xC1), "ord of uppercase of 0xC0 is 0xE0");
    ok($ret->[1], $uc_utf8, "Uppercase of UTF-8 of 0xE1 is 0xC1");
    ok($ret->[2], 2, "Length of uppercase of UTF-8 of 0xE1 is 2");

    $eval_string = "Devel::PPPort::toUPPER_utf8_safe(\"$utf8\", -1);";
    $ret = eval $eval_string;
    $fail = $@;
    ok($ret, undef, "Returns undef for illegal short char");
    ok($fail, eval 'qr/Malformed UTF-8 character/', 'Gave appropriate error for short char');

    if ("$]" > 5.025008) {
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
    }
    else {
        $eval_string = "Devel::PPPort::toUPPER_utf8_safe(\"$utf8\", -3);";
        $ret = eval $eval_string;
        $fail = $@;
        ok($ret, undef, "Returns undef for zero length string");
        ok($fail, eval 'qr/Attempting case change on zero length string/',
           'Gave appropriate error for short char');
    }

    $utf8 = Devel::PPPort::uvoffuni_to_utf8(0x103);
    $uc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0x102);
    $ret = Devel::PPPort::toUPPER_utf8_safe($utf8, 0);
    ok($ret->[0], 0x102, "ord of uppercase of 0x103 is 0x102");
    ok($ret->[1], $uc_utf8, "Uppercase of UTF-8 of 0x103 is 0x102");
    ok($ret->[2], 2, "Length of uppercase of UTF-8 of 0x102 is 2");

    $ret = Devel::PPPort::toTITLE_utf8_safe('b', 0);
    ok($ret->[0], ord 'B', "ord of titlecase of b is 66");
    ok($ret->[1], 'B', "Titlecase of b is B");
    ok($ret->[2], 1, "Length of titlecase of b is 1");

    $utf8 = Devel::PPPort::uvoffuni_to_utf8(0xE1);
    my $tc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0xC1);
    $ret = Devel::PPPort::toTITLE_utf8_safe($utf8, 0);
    ok($ret->[0], Devel::PPPort::LATIN1_TO_NATIVE(0xC1), "ord of titlecase of 0xC0 is 0xE0");
    ok($ret->[1], $tc_utf8, "Titlecase of UTF-8 of 0xE1 is 0xC1");
    ok($ret->[2], 2, "Length of titlecase of UTF-8 of 0xE1 is 2");

    $eval_string = "Devel::PPPort::toTITLE_utf8_safe(\"$utf8\", -1);";
    $ret = eval $eval_string;
    $fail = $@;
    ok($ret, undef, "Returns undef for illegal short char");
    ok($fail, eval 'qr/Malformed UTF-8 character/', 'Gave appropriate error for short char');

    if ("$]" > 5.025008) {
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
    }
    else {
        $eval_string = "Devel::PPPort::toTITLE_utf8_safe(\"$utf8\", -3);";
        $ret = eval $eval_string;
        $fail = $@;
        ok($ret, undef, "Returns undef for zero length string");
        ok($fail, eval 'qr/Attempting case change on zero length string/',
           'Gave appropriate error for short char');
    }

    $utf8 = Devel::PPPort::uvoffuni_to_utf8(0x103);
    $tc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0x102);
    $ret = Devel::PPPort::toTITLE_utf8_safe($utf8, 0);
    ok($ret->[0], 0x102, "ord of titlecase of 0x103 is 0x102");
    ok($ret->[1], $tc_utf8, "Titlecase of UTF-8 of 0x103 is 0x102");
    ok($ret->[2], 2, "Length of titlecase of UTF-8 of 0x102 is 2");

    $ret = Devel::PPPort::toFOLD_utf8_safe('C', 0);
    ok($ret->[0], ord 'c', "ord of foldcase of C is 100");
    ok($ret->[1], 'c', "Foldcase of C is c");
    ok($ret->[2], 1, "Length of foldcase of C is 1");

    $utf8 = Devel::PPPort::uvoffuni_to_utf8(0xC2);
    my $fc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0xE2);
    $ret = Devel::PPPort::toFOLD_utf8_safe($utf8, 0);
    ok($ret->[0], Devel::PPPort::LATIN1_TO_NATIVE(0xE2), "ord of foldcase of 0xC2 is 0xE2");
    ok($ret->[1], $fc_utf8, "Foldcase of UTF-8 of 0xC2 is 0xE2");
    ok($ret->[2], 2, "Length of foldcase of UTF-8 of 0xC2 is 2");

    $utf8 = Devel::PPPort::uvoffuni_to_utf8(0x104);
    $fc_utf8 = Devel::PPPort::uvoffuni_to_utf8(0x105);
    $ret = Devel::PPPort::toFOLD_utf8_safe($utf8, 0);
    ok($ret->[0], 0x105, "ord of foldcase of 0x104 is 0x105");
    ok($ret->[1], $fc_utf8, "Foldcase of UTF-8 of 0x104 is 0x105");
    ok($ret->[2], 2, "Length of foldcase of UTF-8 of 0x104 is 2");

    $eval_string = "Devel::PPPort::toFOLD_utf8_safe(\"$utf8\", -1);";
    $ret = eval $eval_string;
    $fail = $@;
    ok($ret, undef, "Returns undef for illegal short char");
    ok($fail, eval 'qr/Malformed UTF-8 character/', 'Gave appropriate error for short char');

    if ("$]" > 5.025008) {
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
        skip "Zero length inputs cause assertion failure; test dies in modern perls", 0;
    }
    else {
        $eval_string = "Devel::PPPort::toFOLD_utf8_safe(\"$utf8\", -3);";
        $ret = eval $eval_string;
        $fail = $@;
        ok($ret, undef, "Returns undef for zero length string");
        ok($fail, eval 'qr/Attempting case change on zero length string/',
           'Gave appropriate error for short char');
    }

    if ("$]" < 5.007003) {
        my $i;
        for $i (1..6) {
            skip 'Multi-char case changing not implemented in this perl', 0;
        }
    }
    else {
        $utf8 = Devel::PPPort::uvoffuni_to_utf8(0xDF);

        $ret = Devel::PPPort::toUPPER_utf8_safe($utf8, 0);
        ok($ret->[0], ord 'S', "ord of uppercase of 0xDF is ord S");
        ok($ret->[1], 'SS', "Uppercase of UTF-8 of 0xDF is SS");
        ok($ret->[2], 2, "Length of uppercase of UTF-8 of 0xDF is 2");

        $ret = Devel::PPPort::toFOLD_utf8_safe($utf8, 0);
        ok($ret->[0], ord 's', "ord of foldcase of 0xDF is ord s");
        ok($ret->[1], 'ss', "Foldcase of UTF-8 of 0xDF is ss");
        ok($ret->[2], 2, "Length of foldcase of UTF-8 of 0xDF is 2");
    }
}

ok(&Devel::PPPort::av_top_index([1,2,3]), 2);
ok(&Devel::PPPort::av_tindex([1,2,3,4]), 3);

