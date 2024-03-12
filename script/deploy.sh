#!/usr/bin/env sh
source .env

script="forge script UCSDeployScript -vvvvv"
rpc="--rpc-url $RPC_URL"
verify="--verify --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY"

dryrun="$script $rpc"
run="$dryrun $verify --broadcast"

# eval "$run --sig 'deployProxyEtherscan()'"
# eval "$dryrun --sig 'deployProxyEtherscan()'"
# eval "$dryrun --sig 'deployDictionaryUpgradeableEtherscan()'"
# eval "$run --sig 'upgradeDefaultFacadeToV2(address)' $DICTIONARY_UPGRADEABLE_ETHERSCAN"
# eval "$run --sig 'getOrCreateDefaultOpsFacadeV2()'"
# eval "$run --sig 'setDefaultOps(address)' $DICTIONARY_UPGRADEABLE_ETHERSCAN"
eval "$run --sig 'setEtherscanOps(address)' $DICTIONARY_UPGRADEABLE_ETHERSCAN"

# eval "$dryrun --sig 'getDeps()'"
