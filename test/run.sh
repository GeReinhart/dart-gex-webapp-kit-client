#!/bin/bash

function analyze-sources {
        echo "##################################"
        echo "## analyze-sources"
	results=$(dartanalyzer --enable-enum lib/*.dart 2>&1)
	echo "$results"
	if [[ "$results" != *"No issues found"* ]]
	then
	    exit 1
	fi
}

function install-content_shell {
        echo "##################################"
	echo "## install content_shell if not already present"
	which content_shell
	if [[ $? -ne 0 ]]; then
	  $DART_SDK/../chromium/download_contentshell.sh
	  unzip content_shell-linux-x64-release.zip

	  cs_path=$(ls -d drt-*)
	  PATH=$cs_path:$PATH
	fi
}

function launch-test  {
        url=http://localhost:8080/$1
        echo "##################################"
	echo "## launch test on $url"
	# Start pub serve
	pub serve test &
	pub_pid=$!

	# Wait for server to build elements and spin up...
	sleep 15

	# Run a set of Dart Unit tests
	results=$(content_shell --dump-render-tree $url)
	echo -e "$results"

	kill $pub_pid

	# check to see if DumpRenderTree tests
	# failed, since it always returns 0
	if [[ "$results" == *"Some tests failed"* ]]
	then
	    exit 1
	fi

	if [[ "$results" == *"Exception: "* ]]
	then
	    exit 1
	fi
}


analyze-sources
install-content_shell
launch-test test_button.html
launch-test test_toolbar.html
launch-test test_view_port.html
launch-test test_application.html
launch-test test_bus.html
launch-test test_routing.html#page2







