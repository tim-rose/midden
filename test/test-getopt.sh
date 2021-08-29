#!/bin/sh
#
# GETOPT.SH --Unit tests for the getopt module.
#
PATH=..:$PATH
. midden
require getopt
require tap

plan 33

#
# getopt_short_spec() tests
#
ok_eq "$(getopt_short_spec 'a.alpha;b.beta;g.gamma')" 'abg' \
      'getopt_short_spec: flags only'

ok_eq "$(getopt_short_spec 'a.alpha;b.beta=;g.gamma')" 'ab:g' \
      'getopt_short_spec: option with value; but no default'

ok_eq "$(getopt_short_spec 'a.alpha;b.beta=value;g.gamma')" 'ab:g' \
      'getopt_short_spec: option with simple default value'

ok_eq "$(getopt_short_spec 'a.alpha;b.beta=value.txt;g.gamma')" 'ab:g' \
      'getopt_short_spec: default values can contain "."'

ok_eq "$(getopt_short_spec 'a.alpha;b.beta=value txt;g.gamma')" 'ab:g' \
      'getopt_short_spec: default values can contain " "'

ok_eq "$(getopt_short_spec 'n.number;e.error')" 'ne' \
      'getopt_short_spec: not confused by echo(1) options'

#
# getopt_long_spec() tests
#
ok_eq "$(getopt_long_spec 'a.alpha;b.beta;g.gamma')" 'alpha,beta,gamma' \
      'getopt_long_spec: flags only'

ok_eq "$(getopt_long_spec 'a.alpha;b.beta=;g.gamma')" 'alpha,beta:,gamma' \
      'getopt_long_spec: option with value; but no default'

ok_eq "$(getopt_long_spec 'a.alpha;b.beta=value;g.gamma')" 'alpha,beta:,gamma' \
      'getopt_long_spec: option with simple default value'

ok_eq "$(getopt_long_spec 'a.alpha;b.beta=value.txt;g.gamma')" 'alpha,beta:,gamma' \
      'getopt_long_spec: default values can contain "."'

ok_eq "$(getopt_long_spec 'a.alpha;b.beta=value txt;g.gamma')" 'alpha,beta:,gamma' \
      'getopt_long_spec: default values can contain " "'

ok_eq "$(getopt_long_spec 'a.alpha;b.be_ta=value txt;g.gamma')" 'alpha,be-ta:,gamma' \
      'getopt_long_spec: variable names have "_" mapped to "-"'

ok_eq "$(getopt_long_spec 'n.number;e.error')" 'number,error' \
      'getopt_long_spec: not confused by echo(1) options'

#
# getopt_defaults() tests.
#
ok_eq "$(getopt_defaults 'a.alpha;b.beta;g.gamma')" '' \
      'getopt_defaults: flags only'

ok_eq "$(getopt_defaults 'a.alpha;b.beta=;g.gamma')" 'beta="";' \
      'getopt_defaults: empty value'

ok_eq "$(getopt_defaults 'a.alpha;b.beta=value;g.gamma')" 'beta="value";' \
      'getopt_defaults: simple value'

ok_eq "$(getopt_defaults 'a.alpha;b.beta=value.txt;g.gamma')" \
      'beta="value.txt";' \
      'getopt_defaults: value containing "."'

ok_eq "$(getopt_defaults 'a.alpha;b.beta=value txt;g.gamma')" \
      'beta="value txt";' \
      'getopt_defaults: value containing " "'

#
# getopt_short_var() tests.
#
opts='a.alpha;b.beta=value txt;g.gamma'

ok_eq "$(getopt_short_var "$opts" a)" 'alpha' 'getopt_short_var: simple flag'
ok_eq "$(getopt_short_var "$opts" b)" 'beta=' 'getopt_short_var: option w/ value'
ok_eq "$(getopt_short_var "$opts" g)" 'gamma' 'getopt_short_var: flag after option'


ok_eq "$(getopt_long_var "$opts" alpha)" 'alpha' 'getopt_long_var: simple flag'
ok_eq "$(getopt_long_var "$opts" beta)" 'beta=' 'getopt_long_var: option w/ value'
ok_eq "$(getopt_long_var "$opts" gamma)" 'gamma' 'getopt_long_var: flag after option'

#
# getopt_args() tests.
#
opts='a.alpha;b.beta=value;g.gamma'

OPTIND=1			# reset getopt state!
ok_grep "$(getopt_args "$opts" -x 2>/dev/null)" "exit 2;" \
	'getopt_args: invalid flag causes exit'

OPTIND=1
ok_eq "$(getopt_args "$opts")" 'OPTIND=1' 'getopt_args: empty arglist'

OPTIND=1
ok_eq "$(getopt_args "$opts" -a)" \
      "$(printf '%s\n' 'alpha=1;' 'OPTIND=2')" \
      'getopt_args: single flag specified'

OPTIND=1
ok_eq "$(getopt_args "$opts" -ag)" \
      "$(printf '%s\n' 'alpha=1;' 'gamma=1;' 'OPTIND=2')" \
      'getopt_args: two flags specified together'

OPTIND=1
ok_eq "$(getopt_args "$opts" -a -g)" \
      "$(printf '%s\n' 'alpha=1;' 'gamma=1;' 'OPTIND=3')" \
      'getopt_args: two flags specified separately'

OPTIND=1
result=$(printf '%s\n' 'alpha=1;' 'gamma=1;' 'beta="foobar";' 'OPTIND=3')
ok_eq "$(getopt_args "$opts" -agb foobar)" "$result" \
      'getopt_args: flags and values specified'

#
# getopt_args() "-d" tests
#
OPTIND=1
result=$(printf '%s\n' 'beta="value";' 'OPTIND=1')
ok_eq "$(getopt_args -d "$opts")" "$result" \
      'getopt_args: "-d" supplies default value'

OPTIND=1
result=$(printf '%s\n' 'beta="value";' 'beta="foobar";' 'OPTIND=3')
ok_eq "$(getopt_args -d "$opts" -b foobar)" "$result" \
      'getopt_args: "-d" command-line overrides defaults'

OPTIND=1
opts='n.number;e.error'
result=$(printf '%s\n' 'number=1;' 'error=1;' 'OPTIND=2')
ok_eq "$(getopt_args "$opts" -ne foobar)" "$result" \
      'getopt_args: flags and values specified'
exit 0
