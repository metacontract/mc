#!/usr/bin/env sh

# Navigate to the parent directory, set PATH, generate docs, and return to site directory
cd ../
export PATH=$HOME/.foundry/bin:$PATH
forge doc -o temp_soldocs
cd site

# Run the integrate_soldocs script
npm run ./script/integrate_soldocs.ts
