# /bin/sh

ROOT_DIR="$(pwd)"
pushd .

rm -rf out/

mkdir -p out/base/
pushd src/sample/base
for i in *.scad; do openscad -o "$ROOT_DIR/out/base/${i%.*}.stl" "$i"; done;
popd

mkdir -p out/scifi/
pushd src/sample/scifi/
for i in *.scad; do openscad -o "$ROOT_DIR/out/scifi/${i%.*}.stl" "$i"; done;
popd
