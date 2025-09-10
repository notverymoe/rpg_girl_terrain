# /bin/bash
shopt -s nullglob dotglob

cd out/;

for d in */
do 
    cd ${d};
    for f in *.stl
    do
        if [[ $f == *"."*"."* ]]; then
            echo "Skipped ${f}"
        else
            echo "Processing ${f}"
            rm -f "${f%.stl}.orig.stl"
            mv "${f}" "${f%.stl}.orig.stl"
            admesh --exact --fill-holes --remove-unconnected --write-ascii-stl="${f%.stl}.fixed.stl" "${f%.stl}.orig.stl" 1> /dev/null
        fi
    done
    cd ../;
done