# /bin/bash
shopt -s nullglob dotglob

if [ $# -eq 0 ]
then
    ROOT_DIR="$(pwd)";
    CORES="$(nproc)";
    CORES="$(( CORES/4 ))";
    CORES="$(( CORES < 1 ? 1 : CORES ))";

    rm -rf out/;
    cd src/sample/;

    echo "Running with ${CORES} threads";

    for d in */
    do 
        echo "Processing '${d%/}'";
        mkdir -p ../../out/${d};
        cd ${d};

        ls -w1 *.scad | xargs -n1 --max-procs=$CORES sh ../../../scripts/generate_all.sh $ROOT_DIR $d;

        cd ../;
    done

else

    if [[ $3 != _* ]]
    then
        openscad --enable all -q "$3" -o "$1/out/${2%/}/${3%.*}.stl";
        echo " - Processed ${2}${3%.*}";
    fi

fi
