#!/usr/bin/env sh
source .env
# forge verify-contract $INIT_SET_ADMIN_OP InitSetAdminOp --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia
# forge verify-contract $SET_IMPLEMENTATION_OP SetImplementationOp --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia
# forge verify-contract $DEFAULT_OPS_FACADE DefaultOpsFacade --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia
# forge verify-contract $DICTIONARY_UPGRADEABLE_IMPL DictionaryUpgradeable --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia
# forge verify-contract $DICTIONARY_UPGRADEABLE_ETHERSCAN_IMPL DictionaryUpgradeableEtherscan --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia
# forge verify-contract $DICTIONARY_UPGRADEABLE_ETHERSCAN DictionaryUpgradeableEtherscanProxy --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia --constructor-args $DICTIONARY_UPGRADEABLE_ETHERSCAN_ARGS
# forge verify-contract $UCS_DEPLOYER UCSDeployer --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia --constructor-args $UCS_DEPLOYER_ARGS

# forge verify-contract $DICTIONARY_ETHERSCAN DictionaryEtherscan --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia --constructor-args $DICTIONARY_ETHERSCAN_ARGS
forge verify-contract $PROXY_ETHERSCAN ERC7546ProxyEtherscan --verifier-url $VERIFIER --etherscan-api-key $ETHERSCAN_API_KEY --chain sepolia --constructor-args $PROXY_ETHERSCAN_ARGS
