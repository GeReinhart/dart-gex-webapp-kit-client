#!/bin/bash


function run-tests {
	/bin/bash ./test/run.sh 
	if [[ $? -ne 0 ]]; then
	     echo 'tests failed' 
	     exit 1
	fi
}









run-tests 


