Package go-incognito-sdk is a tutorial on inegrating with the Incognito Chain.

#### Installation

Requires Go 1.13 or later due to usage of Go Modules:

```bash
go get github.com/incognitochain/go-incognito-sdk@V0.0.1
```

#### Usage

Initialize object blockchain and play rock

```javascript
package main

import (
	"fmt"
	"github.com/incognitochain/go-incognito-sdk/incognitoclient"
	"github.com/incognitochain/go-incognito-sdk/incognitoclient/entity"
	"net/http"
)

func main() {
	client := &http.Client{}

	bc := incognitoclient.NewBlockchain(
		client,
		"https://testnet.incognito.org/fullnode",
		"",
		"",
		"",
		"0000000000000000000000000000000000000000000000000000000000000004",
	)

	listPaymentAddresses := entity.WalletSend{
		Type: 0,
		PaymentAddresses: map[string]uint64{
			"12Rsf3wFnThr3T8dMafmaw4b3CzUatNao61dkj8KyoHfH5VWr4ravL32sunA2z9UhbNnyijzWFaVDvacJPSRFAq66HU7YBWjwfWR7Ff": 500000000000,
		},
	}

	tx, err := bc.CreateAndSendConstantTransaction(
		"112t8roafGgHL1rhAP9632Yef3sx5k8xgp8cwK4MCJsCL1UWcxXvpzg97N4dwvcD735iKf31Q2ZgrAvKfVjeSUEvnzKJyyJD3GqqSZdxN4or",
		listPaymentAddresses,
	)

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Println(tx)
}
```

For detail more function in SDK, Please look link package: 
https://pkg.go.dev/github.com/incognitochain/go-incognito-sdk@v0.0.0-20201120093532-df1a9e237f10/incognitoclient
