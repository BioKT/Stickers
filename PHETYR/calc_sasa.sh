#!/bin/bash


proot="GGFGG"
ff="amber99sb-star-ildn"
wat="tip3p"

# WATER
#for lambda in 0 1
#do
#	tpr="../data/${proot}_${ff}_${wat}_mut_l${lambda}_npt_berendsen"
#    xtc="../data/${proot}_${ff}_${wat}_mut_l${lambda}_npt"
#    out="../analysis/${proot}_${ff}_${wat}_mut_l${lambda}_npt_sasa"
#   gmx sasa -s  $tpr -f ${xtc} -o $out -dt 10 <<EOF &
#11
#EOF
#done

# SOLVENTS
#for wat in  "che" "ethoh"  "metoh" "dmso" "tol" "ben" "hexanol" "octanol" "acetone" 
#do
#    for lambda in 0 1 
#    do
#    	tpr="../data/${proot}_${ff}_${wat}_mut_l${lambda}_npt_berendsen"
#        xtc="../data/${proot}_${ff}_${wat}_mut_l${lambda}_npt"
#        out="../analysis/${proot}_${ff}_${wat}_mut_l${lambda}_npt_sasa"
#	    gmx sasa -s  $tpr -f ${xtc} -o $out -dt 10 <<EOF &
#11
#EOF
#    done
#    wait
#done

# SLABS
wat="tip3p"
#for soup in soupF_XXXL #soup_XXXL 
#do
#    for lambda in 0 1 
#    do
#    	tpr="../data/${proot}_${soup}_${ff}_${wat}_l${lambda}_npt"
#        xtc="../data/${proot}_${soup}_${ff}_${wat}_l${lambda}_npt_proc"
#        out="../analysis/${proot}_${soup}_${ff}_${wat}_l${lambda}_npt_sasa"
#       gmx sasa -s $tpr -f $xtc -o $out -dt 10 <<EOF &
#16
#EOF
#    done
#    wait
#    break
#done

# SLAB REPLICATES
wat="tip3p"
for soup in soupF_XXXL #soupF_XXXL  
do
    for rep in 0 1 2
    do
        for lambda in 0 1 
        do
            tpr="../data/${proot}_${soup}_${ff}TRUE_${wat}_rep${rep}_l${lambda}_npt"
            xtc="../data/${proot}_${soup}_${ff}TRUE_${wat}_rep${rep}_l${lambda}_npt_proc"
            out="../analysis/${proot}_${soup}_${ff}TRUE_${wat}_rep${rep}_l${lambda}_npt_sasa"
           gmx sasa -s $tpr -f $xtc -o $out -dt 10 -e 1000000 <<EOF &
16
EOF
        done
    wait
    done
done

# SOUP HIGH TEMPERATURE
#wat="tip3p"
#for soup in soupF_XXXL soup_XXXL 
#do
#   tpr="../data/${soup}_${ff}TRUE_${wat}_nvt500"
#   xtc="../data/${soup}_${ff}TRUE_${wat}_nvt500"
#   out="../analysis/${soup}_${ff}TRUE_${wat}_nvt500_sasa"
#   gmx sasa -s $tpr -f $xtc -o $out -dt 10 <<EOF &
#14
#EOF
#done

# SOUP TIP4PEw
wat="tip4pew"
soup="soup_XXXL"
for lambda in 0 1 
do
   tpr="../data/${proot}_${soup}_${ff}TRUE_${wat}_l${lambda}_npt"
   xtc="../data/${proot}_${soup}_${ff}TRUE_${wat}_l${lambda}_npt_proc"
   out="../analysis/${proot}_${soup}_${ff}TRUE_${wat}_l${lambda}_npt_sasa"
   gmx sasa -s $tpr -f $xtc -o $out -dt 10 -e 1000000 <<EOF &
16
EOF
done

rm \#* data/\#*
