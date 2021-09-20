Example to use SDK to create wallet

```
// method 
func (b Blockchain) CreateWalletAddress() (paymentAddress, pubkey, readonlyKey, privateKey string, err error)
```

Example:

```
//bc := NewBlockchain(....)

address, pubKey, readonlyKey, privateKey, err := bc.CreateWalletAddress()
if err != nil {
	return err
}
```

#### More Detail

https://pkg.go.dev/github.com/incognitochain/go-incognito-sdk/incognitoclient
