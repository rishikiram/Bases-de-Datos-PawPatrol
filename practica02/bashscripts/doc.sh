#!/bin/bash -x
if ! [[ -d "src/Doc" ]]; then
    mkdir src/Doc
fi

javadoc --source-path src -d src/Doc src/Main.java
