#!/bin/sh bash
timeUp=$(date "+%Y-%m-%d %H:%M:%S")
echo $timeUp
sudo apt install jq -y
run()
{
  cd ~/aos/
  validator_key=xxx
  bootnode="mainnet-bootnode.incognito.org:9330"
  is_shipping_logs=1
  latest_tag=$1
  current_tag=$2
  data_dir="inco-data"
  eth_data_dir="inco-eth-mainnet-data"
  logshipper_data_dir="logshipper-mainnet-data"


  if [ -z "$node_port" ]; then
    node_port="9433";
  fi
  if [ -z "$rpc_port" ]; then
    rpc_port="9334";
  fi

  docker -v || bash -c "wget -qO- https://get.docker.com/ | sh"

  if [ -d "$PWD/${eth_data_dir}" ]
  then
    sudo rm -r $PWD/${eth_data_dir}
    sudo rm -r $PWD/${logshipper_data_dir}
  fi

  docker stop inc_mainnet
  docker stop eth_mainnet
  docker rm -f inc_mainnet
  docker rm -f eth_mainnet
  if [ "$current_tag" != "" ]
  then
    docker image rm -f incognitochain/incognito-mainnet:${current_tag}
  fi

  docker pull incognitochain/incognito-mainnet:${latest_tag}

  docker run --restart=always -p $node_port:$node_port -p $rpc_port:$rpc_port -e NODE_PORT=$node_port -e RPC_PORT=$rpc_port -e BOOTNODE_IP=$bootnode -e GETH_NAME=eth-fullnode.incognito.org -e GETH_PROTOCOL=https -e GETH_PORT= -e MININGKEY=${validator_key} -e TESTNET=false -v $PWD/${data_dir}:/data -d --name inc_mainnet incognitochain/incognito-mainnet:${latest_tag}

}

#current_latest_tag=""
current_latest_tag=$(docker ps  | awk '{print $2}' | grep "incognito-mainnet")
#update auto-update
#cd ~/aos/ability/incognito/ && curl -LO https://storage.googleapis.com/incognito/nodes/auto_update.sh

tags=$(curl -s -X GET https://hub.docker.com/v2/namespaces/incognitochain/repositories/incognito-mainnet/tags?page_size=100 | jq '.results[].name' | tr -d "\"")
sorted_tags=($(echo ${tags[*]} | sort -rn))
latest_tag=${sorted_tags[0]}
docker rmi 21190ec76704
docker restart inc_mainnet

if [ "$current_latest_tag" != "$latest_tag" ]
then
  run $latest_tag $current_latest_tag
  current_latest_tag=$latest_tag
fi
