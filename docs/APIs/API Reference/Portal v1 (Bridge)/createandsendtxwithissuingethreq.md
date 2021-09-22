### createandsendtxwithissuingethreq

Issue trustless bridge token

Parameters

Example

Request body:
 
```javascript
{
    "id": 1,
    "jsonrpc": "1.0",
    "method": "createandsendtxwithissuingethreq",
    "params": [
        "Private key",
        null,
        5,
        -1,
        {
            "IncTokenID": "incTokenIDStr",
            "BlockHash": "ethBlockHash",
            "ProofStrs": "ethDepositProof",
            "TxIndex": "ethTxIdx"
        }
    ]
}
```

Response body:


Response Description:

