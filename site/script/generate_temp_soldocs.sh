#!/usr/bin/env sh

command -v forge >/dev/null 2>&1 || {
	# Download and install Foundry
	curl -L https://foundry.paradigm.xyz | bash

    # Update PATH to include Foundry binaries
    # export PATH=$HOME/.foundry/bin:$PATH

	# Update Foundry
	foundryup

}

# Navigate to the parent directory, set PATH, generate docs, and return to site directory
cd ..
forge doc -o temp_soldocs/
