# /bin/bash
shopt -s nullglob dotglob

cd out/;

for d in */
do 
    cd ${d};
    for f in *.stl
    do
        echo "Processing ${f}"
        mv "${f}" "${f%.stl}.bak.stl"
        admesh --write-ascii-stl="${f}" "${f%.stl}.bak.stl" 1> /dev/null
        rm "${f%.stl}.bak.stl"
    done
    cd ../;
done