This tutorial is to help calculate the price of a pToken.

#### Get BeaconHeight

##### RPC to get beaconeststatedetail

```bash
// Call RPC to get BeaconHeight 
curl --location --request GET 'https://community-fullnode.incognito.org/fullnode' \
--header 'Content-Type: application/json' \
--header 'Cookie: __cfduid=de366883b49019c0910e43a39d16d3b111610982365' \
--data-raw '{
    "jsonrpc": "1.0",
    "method": "getbeaconbeststatedetail",
    "params": [""],
    "id": 1
    }'
```

##### response

```bash
{
	"Id": 1,
	"Result": {
        "BeaconHeight": 962117,
        ...
    }
}
```

### getpdestate

Get pdexstate is to help check pool size of the pair token/token on pDex

In this case we are only look for pair PRV/pBTC. Data format as Token1IdStr(prv id) - Token2IdStr(pBTC id)

##### RPC

```bash

 
//Call RPC to get pdexstate 

{
   "jsonrpc":"1.0",
   "method":"getpdestate",
   "params":[{
      "BeaconHeight": 835380 // this value get from step 1 rpc
   }],
   "id":1
}
```

##### Response

```bash
{
    "Id": 1,
    "Result": {
       "WaitingPDEContributions": {
           ...
       },
        "PDEPoolPairs": {
            "pdepool-835380-0000000000000000000000000000000000000000000000000000000000000004-b832e5d3b1f01a4f0623f7fe91d6673461e1f5d37d91fe78c5c2e6183ff39696": {
                "Token1IDStr": "0000000000000000000000000000000000000000000000000000000000000004",
                "Token1PoolValue": 1906314094145580,
                "Token2IDStr": "b832e5d3b1f01a4f0623f7fe91d6673461e1f5d37d91fe78c5c2e6183ff39696",
                "Token2PoolValue": 171442164981
            }, 
        }
.....
...
}
```

### Token Price

From the result of poolPair rpc, we use code to make example on how to calculate token price from pool pair

```javascript
 //golang .

  var decimal1 int64 
	var decimal2 int64 
	
	decimal1 = 9  // decimal PRV
	decimal2 = 9 // decimal pBTC 
	
	var Token2PoolValue float64 
	var Token1PoolValue float64
	
	Token1PoolValue = 2794646452014123 // PRV in pool size 
	Token2PoolValue = 181299347091  // pBTC in pool size 
	
  x := math.Ceil((Token2PoolValue *Token1PoolValue) / (Token2PoolValue + math.Pow10(int(decimal2))))
	priceToken1ToBuyToken2 := (Token1PoolValue - x) / math.Pow10(int(decimal1)) 
		
  fmt.Println(priceToken1ToBuyToken2)
```
