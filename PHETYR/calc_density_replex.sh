#!/bin/bash

ff="amber99sb-star-ildnTRUE"
wat="tip3p"

for rep in $(seq 0 1 47)
do
    for soup in soup_XXL soupF_XXL 
    do

        # PROTEIN
    	tpr="../data/rep${rep}/${soup}_${ff}_${wat}_replex"
        ndx="../data/${soup}_${ff}_${wat}_replex"
        xtc="../data/rep${rep}/${soup}_${ff}_${wat}_replex_proc"
#        out="../analysis/${soup}_${ff}_${wat}_rep${rep}_density"
#        gmx density -s  $tpr -f ${xtc} -o $out -dt 10 -d X -b 200000 -center <<EOF &
#14
#14
#EOF

        out="../analysis/${soup}_${ff}_${wat}_rep${rep}_densityGS"
        gmx density -s  $tpr -f ${xtc} -o $out -n $ndx -dt 10 -d X -b 200000 -center <<EOF &
14
15
EOF

        out="../analysis/${soup}_${ff}_${wat}_rep${rep}_densityX"
        gmx density -s  $tpr -f ${xtc} -o $out -n $ndx -dt 10 -d X -b 200000 -center <<EOF &
14
16
EOF

        ## WATER
#        out="../analysis/${soup}_${ff}_${wat}_rep${rep}_densityH2O"
#        gmx density -s  $tpr -f ${xtc} -o $out -dt 10 -d X -b 200000 -center <<EOF &
#14
#12
#EOF
        ## ERRORS
        ie=200000
#        for i in $(seq 0 1 5)
#        do
#            out="../analysis/${soup}_${ff}_${wat}_rep${rep}_density_bin${i}"
#            ib=$ie
#            ie=$((ib + 50000))
#            echo $i $ib $ie
#    	    gmx density -s  $tpr -f ${xtc} -o $out -d X -b $ib -e $ie -center <<EOF &
#14
#14
#EOF
#        done
        wait
    done
    wait
done
rm ../*/\#*
