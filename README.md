# blockchain

mkdir node01 node02 node03

./geth --datadir node01 account new

./geth --datadir node01 init genesis.json
./geth --datadir node02 init genesis.json
./geth --datadir node03 init genesis.json


./geth --identity "node1" --http  --http.port "8000" --rpc.enabledeprecatedpersonal --authrpc.port  "8550" --http.corsdomain "*" --datadir "/home/trungdq/blockchain/geth-1.13/node01" --port "30303" --nodiscover  --http.api "eth,net,web3,personal,miner,admin" --networkid 1234 --nat "any" --allow-insecure-unlock --mine --miner.etherbase="0xE2184E9935baefa6681b5DCaE678C077F8D5529B"
./geth --identity "node2" --http  --http.port "8001" --rpc.enabledeprecatedpersonal --authrpc.port  "8551" --http.corsdomain "*" --datadir "/home/trungdq/blockchain/geth-1.13/node02" --port "30304" --nodiscover  --http.api "eth,net,web3,personal,miner,admin" --networkid 1234 --nat "any" --allow-insecure-unlock
./geth --identity "node3" --http  --http.port "8002" --authrpc.port  "8552" --http.corsdomain "*" --datadir "/home/trungdq/blockchain/geth-1.13/node03" --port "30305" --nodiscover  --http.api "eth,net,web3,personal,miner,admin" --networkid 1234 --nat "any" --allow-insecure-unlock

personal.unlockAccount(eth.accounts[0])

./geth --exec admin.nodeInfo attach node01/geth.ipc


// truy cập vào node02
addPeer("enode://<enode>")
// truy cập vào node03
addPeer("enode://<enode>")

> eth.sendTransaction({from:eth.accounts[0], to:eth.accounts[1], value:1000, gasPrice: 500})

./geth --networkid=1234 account list


./geth --mine --miner.etherbase=0x78ce1EaE2D22eB00b8eCC6eeFBd304CDa034d18a

