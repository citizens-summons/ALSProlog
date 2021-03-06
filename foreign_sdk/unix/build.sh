#!/bin/sh
if test -d ALS_Prolog_Foreign_SDK
then
	rm -r ALS_Prolog_Foreign_SDK
fi
SDK=`pwd`/..
GENERIC=../../../core/alsp_src/generic
mkdir ALS_Prolog_Foreign_SDK
cd ALS_Prolog_Foreign_SDK
mkdir include
cp $GENERIC/alspi.h include
cp $GENERIC/alspi_slib.h include
mkdir source
cp $GENERIC/alspi_slib.c source
mkdir documentation
cp "$SDK"/docs/FI_Manual.pdf documentation
cp "$SDK"/docs/FI_Ref.pdf documentation
mkdir examples
cp "$SDK"/examples/unix/Examples_Read_Me examples
cd examples
mkdir even
mkdir qa
mkdir tutorial
cp "$SDK"/examples/common/even.c even
cp "$SDK"/examples/unix/even/*_makefile even
cp "$SDK"/examples/common/qa.c qa
cp "$SDK"/examples/common/know.pro qa
cp "$SDK"/examples/unix/qa/*_makefile qa
cp "$SDK"/examples/common/examples.c tutorial
cp "$SDK"/examples/unix/tutorial/*_makefile tutorial
