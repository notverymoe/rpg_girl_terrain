# /bin/bash

mkdir -p out/test/;

cd src/
openscad -q "${1}" -o "../out/test/test.stl";
cd ../

admesh "out/test/test.stl";

rm "out/test/test.stl";
