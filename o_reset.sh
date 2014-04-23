#!/bin/sh
make -f Makefile.mic clean
make -f Makefile.mic com_uo
cp com_uo.mic scale_tests/
