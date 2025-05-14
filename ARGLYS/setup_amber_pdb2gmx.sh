#!/bin/bash

#export GMXLIB=/Users/daviddesancho/Research/software/pmx/pmx/data/mutff45
#export GMXLIB=/home/david/Research/Projects/Simulation/PMX/mutff45

ff="amber99sb-star-ildn"
wat="tip3p"
host=K
for pdb in GG${host}GG #SS${host}SS AA${host}AA YG${host}GY FG${host}GF
do
    out="../data/${pdb}_${ff}.pdb"
    top="../data/${pdb}_${ff}.top"
    itp="../data/${pdb}_${ff}_posre.itp"
    gmx pdb2gmx -f ${pdb}.pdb -o ${out} -p $top -i $itp -ignh  <<EOF
1
1
EOF
done
exit

for pdb in phe tyr ser gly 
do
    out="../data/${pdb}_${ff}TRUE.pdb"
    top="${pdb}_${ff}TRUE.top"
    itp="${pdb}_${ff}TRUE_posre.itp"
    gmx pdb2gmx -f ${pdb}.pdb -o ${out} -p $top -i $itp -ignh  <<EOF
1
1
EOF
done
rm \#* ../data/\#*
