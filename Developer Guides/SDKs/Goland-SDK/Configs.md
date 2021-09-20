configs & init Blockchain object 

```bash
client := &http.Client{}

	bc := incognitoclient.NewBlockchain(
		client,
		"https://testnet.incognito.org/fullnode", // this is fullnode of the network 
		"",
		"",
		"",
		"0000000000000000000000000000000000000000000000000000000000000004", // this is token default to load 
	)
```

#### More Detail

https://pkg.go.dev/github.com/incognitochain/go-incognito-sdk/incognitoclient
