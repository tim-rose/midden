#!/bin/sh
#
# TEST-WORDY.SH --Unit tests for the word manipulation module.
#
PATH=..:$PATH
. midden
require tap

require wordy

plan 25

#
# snake case
#
ok_eq "$(snake_case Alpha)" alpha 'snake case: one element'
ok_eq "$(snake_case AlphaBetaGamma)" alpha_beta_gamma 'snake case: three elements'
ok_eq "$(snake_case AlphaBETAGamma)" alpha_betagamma 'snake case: only sensitive to a->A'
ok_eq "$(snake_case alpha_beta_gamma)" alpha_beta_gamma 'snake case: idempotent'

#
# kebab case
#
ok_eq "$(kebab_case Alpha)" alpha 'kebab case: one element'
ok_eq "$(kebab_case AlphaBetaGamma)" alpha-beta-gamma 'kebab case: three elements'
ok_eq "$(kebab_case AlphaBETAGamma)" alpha-betagamma 'kebab case: only sensitive to a->A'
ok_eq "$(snake_case alpha-beta-gamma)" alpha_beta_gamma 'snake case: idempotent'

#
# TODO: camel_case tests
#
ok_eq "$(camel_case alpha)" Alpha 'camel case: one element'
ok_eq "$(camel_case alpha_beta_gamma)" AlphaBetaGamma 'camel case: three elements'
ok_eq "$(camel_case Alpha-BETA-Gamma)" AlphaBetaGamma 'camel case: only sensitive to a->A'
ok_eq "$(camel_case AlphaBetaGamma)" AlphaBetaGamma 'snake case: idempotent'

#
# plural tests
#
ok_eq "$(plural boy)" "boys" 'plural: ending in "<vowel>y"'
ok_eq "$(plural hippy)" "hippies" 'plural: ending in "<consonant>y"'
ok_eq "$(plural studio)" "studios" 'plural: ending in "<vowel>o"'
ok_eq "$(plural tornado)" "tornadoes" 'plural: ending in "<consonant>o"'
ok_eq "$(plural princess)" "princesses" 'plural: sibilant endings (ss)'
ok_eq "$(plural snatch)" "snatches" 'plural: sibilant endings (ch)'
ok_eq "$(plural fox)" "foxes" 'plural: sibilant endings (x)'
ok_eq "$(plural soliloquy)" "soliloquies" 'plural: latin words ending in "quy"'
ok_eq "$(plural vertex)" "vertices" 'plural: latin words ending in "ex"'
# REVISIT: need to isolate plural()'s exceptions file for these tests.
ok_eq "$(plural ox)" "oxen" 'plural: exceptions'
ok_eq "$(plural knife)" "knives" 'plural: exceptions'
ok_eq "$(plural child)" "children" 'plural: exceptions'
ok_eq "$(plural other)" "others" 'plural: general case'

exit 0
