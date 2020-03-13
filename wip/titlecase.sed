#!/usr/bin/env sed -f
#
# TITLECASE.SED --Convert text to "title" case ("Looks a Bit Like this").
#
s/^a/A/
s/^b/B/
s/^c/C/
s/^d/D/
s/^e/E/
s/^f/F/
s/^g/G/
s/^h/H/
s/^i/I/
s/^j/J/
s/^k/K/
s/^l/L/
s/^m/M/
s/^n/N/
s/^o/O/
s/^p/P/
s/^q/Q/
s/^r/R/
s/^s/S/
s/^t/T/
s/^u/U/
s/^v/V/
s/^w/W/
s/^x/X/
s/^y/Y/
s/^z/Z/
#
# Capitalise the first character of very word
#
s/ a/ A/g
s/ b/ B/g
s/ c/ C/g
s/ d/ D/g
s/ e/ E/g
s/ f/ F/g
s/ g/ G/g
s/ h/ H/g
s/ i/ I/g
s/ j/ J/g
s/ k/ K/g
s/ l/ L/g
s/ m/ M/g
s/ n/ N/g
s/ o/ O/g
s/ p/ P/g
s/ q/ Q/g
s/ r/ R/g
s/ s/ S/g
s/ t/ T/g
s/ u/ U/g
s/ v/ V/g
s/ w/ W/g
s/ x/ X/g
s/ y/ Y/g
s/ z/ Z/g
#
# final fixups for articles, "short" prepositions etc.
#
s/ A / a /g
s/ And / and /g
s/ As / as /g
s/ At / at /g
s/ By / by /g
s/ For / for /g
s/ In / in /g
s/ Is / is /g
s/ Of / of /g
s/ On / on /g
s/ Per / per /g
s/ The / the /g
s/ To / to /g
s/ Up / up /g
