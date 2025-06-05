#!/bin/bash

ff="amber99sb-star-ildnTRUE"
wat="tip3p"

proot="GGFGG"

for soup in soup_XXXL soupF_XXXL
do
    for rep in 0 1 2
    do
        for lambda in 0 1 
        do

            # PROTEIN
        	tpr="../data/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt"
            xtc="../data/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt_proc"
            out="../analysis/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt_density"

    	    gmx density -s  $tpr -f ${xtc} -o $out -dt 10 -d X -b 100000 <<EOF 
16
EOF
        
            ie=0
            for i in $(seq 0 1 49)
            do
                out="../analysis/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt_density_bin${i}"
                ib=$ie
                ie=$((ib + 10000))
        	    gmx density -s  $tpr -f ${xtc} -o $out -d X -b $ib -e $ie <<EOF &
16
EOF
            done
            wait

            ## PEPTIDE
            out="../analysis/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt_densityF2Y"
            gmx density -s  $tpr -f ${xtc} -o $out -dt 10 -d X -b 100000 <<EOF &
13
EOF
            ie=0
            for i in $(seq 0 1 49)
            do
                out="../analysis/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt_densityF2Y_bin${i}"
                ib=$ie
                ie=$((ib + 10000))
    	        gmx density -s  $tpr -f ${xtc} -o $out -dt 10 -d X  -b $ib -e $ie <<EOF &
13
EOF
           done
           wait

           ## WATER
           out="../analysis/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt_densityH2O"
           gmx density -s  $tpr -f ${xtc} -o $out -dt 10 -d X -b 100000 <<EOF &
15
EOF

           ie=0
           for i in $(seq 0 1 49)
           do
               out="../analysis/${proot}_${soup}_${ff}_${wat}_rep${rep}_l${lambda}_npt_densityH2O_bin${i}"
               ib=$ie
               ie=$((ib + 10000))
    	       gmx density -s  $tpr -f ${xtc} -o $out -dt 10 -d X  -b $ib -e $ie <<EOF &
15
EOF
            done
            wait
        done
    done
    break
done
