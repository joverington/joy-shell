#!/bin/sh
#
# joy-shell jpo (c) 2018	
#
# Support script to run joy on a familiy alignment from a master alignment file
#
version="0.1"
#
echo "###################################"
echo "#                                 #"
echo "# joy-shell (c) jpo MDC 2017-2018 #"
echo "#                                 #"
echo "###################################"
echo " "
if [ $# -ne 2 ] ; then echo "usage - joy-shell filename width" ; exit 1 ; fi
#
echo "joy-shell: version - " $version
#
# list of pdbs to be processed, they are ordered in the alignemin in the order of this string
#
list="3uon 5dsgA 5cxv 4dajA 3rze 6cm4 3pblA 5wiuA 4ib4 6bqh 2rh1 2vt4A 4iaq 2ydv 5uenA 3v2w 4z34 5tgzA 4s0vA 4zjc 4dkl 4ej4 4djhA 4ea3A 5x33 5t1aA 4mbsA 3oduA 2lnl 5lweA 4xt1 4zud 5unfA 5vbl 5o9h 5xsz 4xnw 5ndd 3vw7 4ntj 5zbq 5glh 4grvA 4phu 1u19A 2z73A"
#
echo "joy-shell: processed istructure files are... " $list
echo "joy-shell: processed alignment file is... " $1
echo "joy-shell: formatted alignment width is... " $2
#
rm -f joy.ali 
#
for i in $list
do
 echo ">P1;"$i >> joy.ali
 atm2seq $i.pdb | grep structure >> joy.ali
 echo "joy_shell: processing file: " $i
 grep $i $1 | grep -v explain | grep -v "missing structure" | grep -v "date" | sed -e 's/P1;//' | sed -e "s/$i//" | sed -e 's/^ *//' | grep -v ' 20' >> joy.ali
done
#
echo " "
echo "joy_shell: file processing complete! prepared joy.ali"
echo " "
echo "joy_shell: running joy with alignment width " $1
#
joy --nwidth $2 joy.ali
#
exit
