# /bin/bash
shopt -s nullglob dotglob

cd out/;

for d in */
do 
    cd ${d};

    rm -rf "orig/"
    mkdir "orig/"

    for f in *.stl
    do
        if [[ $f == *"."*"."* ]]; then
            echo "Skipped ${f}"
        else
            echo "Processing ${f}"
            rm -f "orig/${f%.stl}.stl"
            mv "${f}" "orig/${f%.stl}.stl"
            admesh --exact --fill-holes --remove-unconnected --write-ascii-stl="${f%.stl}.stl" "orig/${f%.stl}.stl" 1> /dev/null
        fi
    done
    cd ../;
done