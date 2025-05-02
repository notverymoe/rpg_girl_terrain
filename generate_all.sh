# /bin/sh

rm -rf out/
mkdir out
cd src/
for i in *.scad; do openscad -o "../out/${i%.*}.stl" "$i"; done
cd ../