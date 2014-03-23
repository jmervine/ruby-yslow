#!/bin/bash

test "$version" || version="3.1.8"

cd lib
wget http://yslow.org/yslow-phantomjs-$version.zip
unzip yslow-phantomjs-$version.zip
rm yslow-phantomjs-$version.zip
