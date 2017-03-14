#!/bin/bash

for f in `git ls-files | grep "^\." | grep -v "/"`
do
  diff -u $f ~/$f
done
