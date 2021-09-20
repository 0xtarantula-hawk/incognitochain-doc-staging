method: CreateAndSendConstantPrivacyTransaction

Use this method to Create & Send Privacy transaction 

```
//Method
CreateAndSendConstantPrivacyTransaction
```

```
// reciver address: 12Rsf3wFnThr3T8dMafmaw4b3CzUatNao61dkj8KyoHfH5VWr4ravL32sunA2z9UhbNnyijzWFaVDvacJPSRFAq66HU7YBWjwfWR7Ff 
// private key account : 112t8roafGgHL1rhAP9632Yef3sx5k8xgp8cwK4MCJsCL1UWcxXvpzg97N4dwvcD735iKf31Q2ZgrAvKfVjeSUEvnzKJyyJD3GqqSZdxN4or

bc := NewBlockchain(....)

listPaymentAddresses := entity.WalletSend{
	Type: 0,
	PaymentAddresses: map[string]uint64{
		"12Rsf3wFnThr3T8dMafmaw4b3CzUatNao61dkj8KyoHfH5VWr4ravL32sunA2z9UhbNnyijzWFaVDvacJPSRFAq66HU7YBWjwfWR7Ff": 500000000000,
	},
}

tx, err := bc.CreateAndSendConstantPrivacyTransaction("112t8roafGgHL1rhAP9632Yef3sx5k8xgp8cwK4MCJsCL1UWcxXvpzg97N4dwvcD735iKf31Q2ZgrAvKfVjeSUEvnzKJyyJD3GqqSZdxN4or",
	listPaymentAddresses,
)
```

#### More Detail

https://pkg.go.dev/github.com/incognitochain/go-incognito-sdk/incognitoclient
