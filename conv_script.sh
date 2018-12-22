#!/bin/bash

function dirtest() {
    wrk_dir="$1"
    [ ! -d "${wrk_dir}" ] && mkdir ${wrk_dir}

    [ "$(ls -A ${wrk_dir})" ] && echo "Directory not empty." && exit -1
}

function conv2svg() {
    wrk_dir="svg_files"
    dirtest $wrk_dir

    for i in `ls *.pdf`
    do
        fname=${i%%.pdf}
        inkscape --without-gui --file=$i --export-plain-svg=${wrk_dir}/${fname}.svg
    done
}


function conv2png() {
    wrk_dir="png_files"
    dirtest $wrk_dir

    for i in `ls *.pdf`
    do
        fname=${i%%.pdf}
        inkscape --without-gui $i -z --export-dpi=150 \
            --export-area-drawing --export-png=${wrk_dir}/${fname}.png
    done


}

function fhelp() {
    echo -e "\n\tUsage:"
    echo -e "\t\t$0 [svg|png]\n"
}


if [ "$1" == "png" ]
then
    conv2png

elif [ "$1" == "svg" ]
then
    conv2svg

else
    fhelp
fi
