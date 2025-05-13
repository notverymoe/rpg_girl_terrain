# /bin/sh

if [ $# -eq 0 ]
then
    ROOT_DIR="$(pwd)"
    rm -rf out/
    cd src/sample/

    for d in */
    do 
        echo "Processing '${d%/}'";
        mkdir -p ../../out/${d};
        cd ${d};

        ls -w1 *.scad | xargs -n1 --max-procs=4 sh ../../../generate_all.sh $ROOT_DIR $d;

        cd ../;
    done

else

    if [[ $3 != _* ]]
    then
        openscad -q "$3" -o "$1/out/${2%/}/${3%.*}.stl";
        echo " - Proccessed ${2}${3%.*}";
    fi

fi
