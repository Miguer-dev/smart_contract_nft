-include .env

.PHONY: all test clean deploy-puppy deploy-star fund help install snapshot format anvil mint-puppy mint-star

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

help:
	@echo "Usage:"
	@echo "  make deploy-star [ARGS=...]\n    example: make deploy-star ARGS=\"--network goerli\""
	@echo ""
	@echo "  make mint-puppy [ARGS=...]\n    example: make mint-puppy ARGS=\"--network goerli\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install Cyfrin/foundry-devops@0.0.11 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test 

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://127.0.0.1:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network goerli,$(ARGS)),--network goerli)
	NETWORK_ARGS := --rpc-url $(GOERLI_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

deploy-puppy:
	@forge script script/DeployBasicNft.s.sol:DeployBasicNft $(NETWORK_ARGS)

deploy-star:
	@forge script script/DeployStarNft.s.sol:DeployStarNft $(NETWORK_ARGS)

mint-puppy:
	@forge script script/Interactions.s.sol:MintPuppyNft $(NETWORK_ARGS)

mint-star:
	@forge script script/Interactions.s.sol:MintStarNft $(NETWORK_ARGS)

	