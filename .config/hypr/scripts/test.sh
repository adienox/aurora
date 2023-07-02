#!/bin/bash

array=(one two three)
array[1]='something'
array[3]='something'

echo "${array[@]}"
