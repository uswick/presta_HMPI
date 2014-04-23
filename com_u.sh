#!/bin/sh
make -f Makefile.mic clean
make -f Makefile.mic com_u
cp com_u.mic scale_tests/
