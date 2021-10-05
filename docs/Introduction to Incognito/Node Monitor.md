# How to use the Node Monitor

The node monitor is officially live to prepare all validators for the upcoming slashing release. It's integral for releasing the network because nodes must be healthy for the network to be stable.

For more details, a node will be slashed (a.k.a swapping out of a shard committee at the end of epoch) in case the node does not contribute sufficient required votes on blocks committed in an epoch. The required votes are 50% currently.

This is how to monitor your node and avoid slashing.

## 1. Access the Node Monitor

Navigate to https://monitor.incognito.org. You will see the following interface:

<image height=300 src=https://user-images.githubusercontent.com/90896055/135942933-688f9bad-dee5-4568-b10e-4174f6cd4166.png>
*Figure 1 - The node monitor page*
<br/>

The tool allows you to check your nodes’ statuses (My nodes) as well as the whole network’s inactive nodes (Inactive nodes).

## 2. Add nodes to your list

### Obtain a node’s validator key from the keychain tab in your Incognito app.

Note: the next release will include a more convenient way for you to obtain the Validator Public Key.

<image width=300 src="https://user-images.githubusercontent.com/90896055/135942107-6df7ff97-f0dc-4db9-b713-56354fa189b4.png"> <image width=300 src="https://user-images.githubusercontent.com/90896055/135942244-d7c0e48b-d3cc-458a-be8e-40037279ebc6.png"> <image width=300 src="https://user-images.githubusercontent.com/90896055/135942255-2e613195-a5ba-4f69-882f-b3907410a98d.png">
  
*Figure 2 - Obtain Validator public key from Incognito app*

### Input node name (arbitrary), and associated validator key.

Then click ‘Check’. This will add the node to your list so you can monitor important information. To add another Node, just repeat the process.

<image height=300 src=https://user-images.githubusercontent.com/90896055/135942560-63c2e8ea-416a-4831-b66c-eedc3159b549.png>
*Figure 3 - Add a node to monitor list*

## 3. Review health of your nodes

### Here’s what the information in each column means:

**Name** - the node name. This does not need to line up with the name of your node in the app.

**Validator Public key** - the key associated with this particular node.

**Role**:

* Waiting: waiting to be selected into a shard
* Pending Shard i: where i is from 0 to 7, being selected into shard i, waiting to get into a committee
* Committee Shard i: where i is from 0 to 7, being in a shard committee and earning rewards
* Not staked - the key is not yet staked

**Status**:

* Online: syncing data
* Offline: not syncing data and no votes (starting from the date the node was added to the monitor)
* Unknown: running outdated code (i.e., an old docker tag) so the tool does not have appropriate data to show.

**Sync State**:

* Node stall: syncing is disabled
* Beacon syncing: syncing beacon blocks
* Beacon stall: syncing beacon blocks but the node cannot insert the blocks. Issues may be different among nodes so please reach out to @Support for further assistance
* Shard syncing - syncing shard blocks
* Shard stall - syncing shard blocks but the node cannot insert the blocks
* Latest: syncing the up-to-date beacon block. If the node is in a shard committee, it also shows the node is caught up with shard chain
* Unknown: no data

**Vote Stats**: vote percentages of the two most recent epochs where the node was in a shard committee.

## 4. See historical activity

Just click on the node. There will be a pop-up detailing vote count (%), as well as earning history for each epoch. Please note that all data applies only from the date the Node was added to the monitor.

<image width=500 src=https://user-images.githubusercontent.com/90896055/135942648-76f1ac36-639b-43ab-8acd-17b79de1199b.png>
*Figure 5 - Node details*

## 5. See health of a node right on Incognito app

In addition to using the Node monitor’s web version, you can also see health as well as historical activity of your node right on Incognito app.

<image width=300 src=https://user-images.githubusercontent.com/90896055/135942724-757b0069-40c0-4ef4-bdc8-59dd61de697e.png> <image width=300 src=https://user-images.githubusercontent.com/90896055/135942737-f6c71be0-33e2-43ff-b808-b7b363b69849.png> <image width=300 src=https://user-images.githubusercontent.com/90896055/135942743-9a60841f-af5e-4080-beaf-b02d47625022.png> <image width=300 src=https://user-images.githubusercontent.com/90896055/135942788-04f163b3-702e-4848-a0a6-154267281dec.png>

If you have any questions, please let us know in the comments below. @0xkumi is the responsible dev for this initiative, but feel free to reach out to any of us if you need assistance.

Looking forward to seeing an entire network of healthy nodes!

### Inactive nodes

The Inactive nodes display all nodes which may get slashed mostly because of Offline status once the Slashing is enabled.

<image height=300 src=https://user-images.githubusercontent.com/90896055/135943029-7dae8783-3998-443d-8594-a589830565a0.png>
*Figure 6 - Inactive nodes*

Similarly, it’s possible to view a node details when clicking on a node from the table.

<image width=500 src=https://user-images.githubusercontent.com/90896055/135943140-899889a8-b348-44c3-91bb-24d16dfae018.png>
*Figure 7 - Inactive node details*
  
<br/>
  
That’s it for now!

Last but not least, please start using the tool to see how your nodes operate and then take into account of getting issues resolved as soon as possible if any. Again, it’s surely our responsibility to help you out with these node issues.

We still keep working on the tool to add more insight to it such as node contribution statistics, average vote latency, histogram of vote counter and number of active/inactive nodes. Always happy to hear your feedback!

### Follow the community discussion about this topic:
[How to use the Node Monitor](https://we.incognito.org/t/how-to-use-the-node-monitor/11684?u=jared)

