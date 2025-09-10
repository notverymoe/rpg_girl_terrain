# /bin/bash

mkdir -p out/test/;

cd src/
openscad --enable roof -q "${1}" -o "../out/test/test.stl";
cd ../

admesh "out/test/test.stl";

rm "out/test/test.stl";
