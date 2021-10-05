# Change log:
<details>Click to read
  
- 2021-08-31: Support multiple node per host (check the guide below for details)
  
- 2021-05-11: First version.
</details>

# How to install Incognito node
0. Preparation: install curl, wget and docker if you haven't done it yet
    ```
    sudo apt install curl wget docker.io
    ```
1. Download node setup shell script [here](https://raw.githubusercontent.com/incognitochain/incognito-chain/production/bin/inc_node_installer.sh)
    ```bash
    wget https://raw.githubusercontent.com/incognitochain/incognito-chain/production/bin/inc_node_installer.sh
    ```
    or if you prefer curl:
    ```bash
    curl https://raw.githubusercontent.com/incognitochain/incognito-chain/production/bin/inc_node_installer.sh > inc_node_installer.sh
   ```

2. open it with your favorite text editor and change the following settings:

   ```bash
   # change config here:
   BOOTNODE="mainnet-bootnode.incognito.org:9330"  # this should be left as default

   VALIDATOR_K="validator key 1,
             validator key 2,
             validator key 3"  
     # mandatory if you want to run a validator node, multiple validator keys must be separate by commas

   GETH_NAME="https://mainnet.infura.io/v3/xxxyyy"  
      # infura link (*) (follow step 3 on this thread to setup infura https://we.incognito.org/t/194)

   PORT_RPC="8334"  # change this if you prefer other port, 
     # the first node will use the port the next one use this port+1 and so on

   PORT_NODE="9433"  # change this if you prefer other port,
     # the first node will use the port the next one use this port+1 and so on

   CHECK_INTERVAL="3600" # 1 hour, interval to checking for new node update

   FULLNODE=""  # set to 1 to run as a full node, empty to run as normal node

   # New parameters since privacy v2
   INDEXER_ACCESS_TOKEN="edeaaff3f1774ad2888673770c6d64097e391bc362d7d6fb34982ddf0efd18cb" 
     # can be generate by running: $ echo "bla bla bla" | sha256sum
   NUM_INDEXER_WORKERS=100
   ```
(*) follow step 3 on [this thread](https://we.incognito.org/t/194) to setup infura.

3.  Make it executable and run to install Incognito node:
    ```bash
    sudo chmod +x inc_node_installer.sh
    sudo ./inc_node_installer.sh
    ```
4. Blink your eye (yes! one eye is enough) and it's done. If it's not, just blink a few more times faster :rofl:

# To make some change to your node:
Just follow the exact same steps as installation
# Uninstall:
Just run:
   ```bash
   sudo ./inc_node_installer.sh uninstall
   ```
# What does the inc_node_installer.sh script do?
<details>Click to read

For installation:
1. Create a new user name "*incognito*" in your system.
2. Create a systemd service "*IncognitoUpdater*" to check for new node release every hour. You can change the interval as your wish by changing the "*CHECK_INTERVAL*" setting in the script
3. Create a "*/bin/run_node.sh*" script, which will be invoked by systemd service when a new tag is found, to download and run the latest docker image.

For uninstalling:

1. Stop then remove the systemd  "*IncognitoUpdater*" service.
2. Stop and remove docker container "*inc_mainnet*"
3. Delete all Incognito block chain data
4. Remove "*incognito*" user
</details>

# What is the difference using the previous method comparing to this?
<details>Click to read
  
The previous method uses only a while loop in a shell script to check for new release. For some reason, if that update-checking script gets killed then your node will never get updated automatically again unless starting that script again manually.

This method uses systemd service to check for updates and to install the updates. Even when the update-checking script gets killed or your node gets rebooted, systemd will start it again. In short, you just have to set up your node with this method for once and leave it there, the node will always be up to date, you don’t have to worry about your node getting in trouble because it cannot update itself for different reasons.
</details>
<br/>


### To follow the community discussion visit:
[How to setup your own node in a blink of an eye (Now support multi-nodes per host)](https://we.incognito.org/t/how-to-setup-your-own-node-in-a-blink-of-an-eye-now-support-multi-nodes-per-host/12003?u=jared)
