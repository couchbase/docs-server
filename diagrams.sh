#!/bin/bash

[[ -f ./build ]] || mkdir ./build

# install-rr
[[ -f ./build/rr-1.63-java8.zip ]] || curl -L -o ./build/rr-1.63-java8.zip https://github.com/GuntherRademacher/rr/releases/download/v1.63/rr-1.63-java8.zip

# extract-rr
[[ -f ./build/rr/rr.war ]] || unzip ./build/rr-1.63-java8.zip -d ./build/rr

for file in n1ql dcl ddl dml dql tcl hints utility
do

  # generate-rr
  java -jar ./build/rr/rr.war -png -out:./build/railroads.zip -width:776 -keeprecursion -nofactoring -noinline ./modules/n1ql/partials/grammar/${file}.ebnf

  # extract-diagrams
  unzip -o ./build/railroads.zip -d ./build/tmp
  mv -f ./build/tmp/diagram/*.png ./modules/n1ql/assets/images/n1ql-language-reference

done