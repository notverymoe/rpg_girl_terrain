# /bin/sh

ROOT_DIR="$(pwd)"

rm -rf out/

cd src/sample/

for d in */; do 
    echo "Processing '${d%/}'";
    mkdir -p ../../out/${d};
    cd ${d};
    for i in *.scad; do 

        if [[ $i != _* ]]; then
            openscad -q "$i" -o "$ROOT_DIR/out/${d%/}/${i%.*}.stl";
            echo " - Proccessed ${d}${i%.*}";
        fi;
    done;
    cd ../;
done;
