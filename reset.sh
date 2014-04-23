#!/bin/sh
make -f Makefile.mic clean
make -f Makefile.mic com_up
cp com_up.mic scale_tests/
