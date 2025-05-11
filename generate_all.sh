# /bin/sh

ROOT_DIR="$(pwd)"

rm -rf out/

cd src/sample/

for d in */; do 
    echo "Processing '${d%/}'";
    mkdir -p ../../out/${d};
    cd ${d};
    for i in *.scad; do 
        openscad -q "$i" -o "$ROOT_DIR/out/${d%/}/${i%.*}.stl" > /dev/null;
        echo " - Proccessed ${d}${i%.*}";
    done;
    cd ../;
done;
