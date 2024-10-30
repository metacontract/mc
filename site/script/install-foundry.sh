#!/usr/bin/env sh

# Download and install Foundry
curl -L https://foundry.paradigm.xyz | bash

# Update PATH to include Foundry binaries
export PATH=$HOME/.foundry/bin:$PATH

# Update Foundry
foundryup
