#! /bin/bash
echo dif basique: 
diff -rq $1 $2

echo
echo Files in folder not in other
diff -rq $1 $2 | sed -e "/Only/!d" -e 's/Only in \(.*\): /\1\//g' | xargs echo

echo
echo show dif
diff -rq $1 $2 | sed -e '/ differ/!d' -e 's/Files \(.*\) and \(.*\) differ/\1 \2/g' | xargs cat