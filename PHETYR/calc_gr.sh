#/bin/bash

tpr="../data/h2o_box_npt.tpr"
xtc="../data/h2o_box_npt"

rdf="../analysis/rdf_h2o_OWHW_cn.xvg"
#gmx rdf -s $tpr -f $xtc -o $rdf -cn ${rdf}_cn -dt 5 -rmax 1.5 -bin 0.005 -sel 'atomname OW' -ref 'atomname HW1 HW2' -b 100000 &


rdf="../analysis/rdf_h2o_OWOW_cn.xvg"
#gmx rdf -s $tpr -f $xtc -o $rdf -cn ${rdf}_cn -dt 5 -rmax 1.5 -bin 0.005 -sel 'atomname OW' -ref 'atomname OW' -b 100000
#wait


ff="amber99sb-star-ildnTRUE"
wat="tip3p"
for soup in soup soupF
do
    tpr="../data/${soup}_XXL_${ff}_${wat}_dense_npt.tpr"
    xtc="../data/${soup}_XXL_${ff}_${wat}_dense_npt_proc.xtc"

    rdf="../analysis/${soup}_XXL_${ff}_${wat}_dense_npt_rdf_CZ_OW"
    gmx rdf -s $tpr -f $xtc -o $rdf -cn ${rdf}_cn -bin 0.005 -rmax 2 -ref 'atomname CZ' -sel 'atomname OW' -dt 5 -b 100000 &

    rdf="../analysis/${soup}_XXL_${ff}_${wat}_dense_npt_rdf_OW_OW"
    gmx rdf -s $tpr -f $xtc -o $rdf -cn ${rdf}_cn -bin 0.005 -rmax 2 -ref 'atomname OW' -sel 'atomname OW' -dt 5 -b 100000 &
        wait
done

soup=soup
for rep in 0 1 4 5 
do
    tpr="../data/${soup}_XXL_${ff}_${wat}_dense_rep${rep}_npt.tpr"
    xtc="../data/${soup}_XXL_${ff}_${wat}_dense_rep${rep}_npt_proc.xtc"

    rdf="../analysis/${soup}_XXL_${ff}_${wat}_dense_rep${rep}_npt_rdf_CZ_OW"
    gmx rdf -s $tpr -f $xtc -o $rdf -cn ${rdf}_cn -bin 0.005 -rmax 2 -ref 'atomname CZ' -sel 'atomname OW' -dt 5 -b 100000 &

    rdf="../analysis/${soup}_XXL_${ff}_${wat}_dense_rep${rep}_npt_rdf_OH_OW"
    gmx rdf -s $tpr -f $xtc -o $rdf -cn ${rdf}_cn -bin 0.005 -rmax 2 -ref 'atomname OH' -sel 'atomname OW' -dt 5 -b 100000 &
    wait
done
