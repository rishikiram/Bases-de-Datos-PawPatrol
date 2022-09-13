#!/bin/bash -x
if [ -d "build" ]; then
    rm -r build
fi

if [ -d "src/Doc" ]; then
    rm -r src/Doc
fi