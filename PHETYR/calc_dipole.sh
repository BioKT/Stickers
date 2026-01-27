#!/bin/bash -e

ff="amber99sb-star-ildnTRUE"
wat="tip3p"

### SOUPS
#for soup in soup_XXL soupF_XXL
#do 
#    tpr="../data/${soup}_${ff}_${wat}_dense_npt.tpr" 
#    xtc="../data/${soup}_${ff}_${wat}_dense_npt_proc.xtc"
#    out="../analysis/${soup}_${ff}_${wat}_dense_npt_dip_sqr"
#    eps="../analysis/${soup}_${ff}_${wat}_dense_npt_dip_eps"
#    gmx dipoles -s $tpr -f $xtc -o $out -temp 298 -eps $eps -b 100000 <<EOF
#0
#EOF
#
#    # Errors by blocking
#    ie=100000
#    for b in $(seq 0 1 3)
#    do
#        ib=$ie
#        ie=$((ib + 225000))
#        out="../analysis/${soup}_${ff}_${wat}_dense_npt_dip_sqr_b${b}"
#        eps="../analysis/${soup}_${ff}_${wat}_dense_npt_dip_eps_b${b}"
#        gmx dipoles -s $tpr -f $xtc -o $out -temp 298 -eps $eps -b $ib -e $ie <<EOF &
#0
#EOF
#
#    done
#    wait
#
#done
for soup in soup_XXL #soupF_XXL
do 
    for rep in 0 1 4 5
    do
        tpr="../data/${soup}_${ff}_${wat}_dense_rep${rep}_npt.tpr" 
        xtc="../data/${soup}_${ff}_${wat}_dense_rep${rep}_npt_proc.xtc"
        out="../analysis/${soup}_${ff}_${wat}_dense_rep${rep}_npt_dip_sqr"
        eps="../analysis/${soup}_${ff}_${wat}_dense_rep${rep}_npt_dip_eps"
        gmx dipoles -s $tpr -f $xtc -o $out -temp 298 -eps $eps -b 100000 <<EOF
0
EOF
    done
done
exit

### WATER
#tpr="../data/h2o_box_npt.tpr"
#xtc="../data/h2o_box_npt.xtc"
#out="../analysis/h2o_box_npt_dip_sqr"
#eps="../analysis/h2o_box_npt_dip_eps"
#gmx dipoles -s $tpr -f $xtc -o $out -dt 100 -temp 298 -eps $eps <<EOF
#0
#EOF
#
## Errors by blocking
#ie=0
#for b in $(seq 0 1 4)
#do
#    ib=$ie
#    ie=$((ib + 100000))
#    out="../analysis/h2o_box_npt_dip_sqr_b${b}"
#    eps="../analysis/h2o_box_npt_dip_eps_b${b}"
#    gmx dipoles -s $tpr -f $xtc -o $out -temp 298 -eps $eps -b $ib -e $ie <<EOF &
#0
#EOF
#done
#wait 

### SOLVENTS
#for sol in hexanol #che ben tol metoh ethoh dmso acetone hexanol octanol
#do
#    nmol=1000
#    tpr="../data/${sol}_n${nmol}_npt.tpr"
#
#    if [ ! -f $tpr ]
#    then
#        nmol=500
#        tpr="../data/${sol}_n${nmol}_npt.tpr"
#    fi
#
#    xtc="../data/${sol}_n${nmol}_npt.xtc"
#    out="../analysis/${sol}_n${nmol}_npt_dip_sqr"
#    eps="../analysis/${sol}_n${nmol}_npt_dip_eps"
#    gmx dipoles -s $tpr -f $xtc -o $out -dt 100 -temp 298 -eps $eps <<EOF
#0
#EOF
#
#    # Errors by blocking
#    ie=0
#    for b in $(seq 0 1 4)
#    do
#        ib=$ie
#        ie=$((ib + 100000))
#        out="../analysis/${sol}_n${nmol}_npt_dip_sqr_b${b}"
#        eps="../analysis/${sol}_n${nmol}_npt_dip_eps_b${b}"
#        gmx dipoles -s $tpr -f $xtc -o $out -temp 298 -eps $eps -b $ib -e $ie <<EOF &
#0
#EOF
#    done
#    wait
#done

rm \#* ../analysis/\#*

