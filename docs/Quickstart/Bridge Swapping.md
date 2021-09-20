#### How to swap pCoin <=> Coin. Tutorial will make an app using Goland SDK.

For this example, we will be using the bridge to trade BTC to pBTC.

First, we need 2 masater wallets. An Incognito master account & Bitcoin master account.

#### Step 1: Swap Bitcoin (BTC Network) to pBTC (Incognito Netowrk)

    1. Generate a new Bitcoin temp wallet (show qr-code) on the swap page
    2. User sends Bitcoin to the temp address (users use btc wallet to send)
    3. Check Bitcoin balance in temp wallet
    4. Send pBTC (from Incognito master wallet) to the user's Incognito payment address
    5. Send BTC from temp address to master Bitcoin wallet
    
```javascript
 
// Generate a new btc address (step1):
func (bs *BlockcypherService) GenerateAddress() (privKey, pubKey, address string, err error) {
 
   secret, err := btcec.NewPrivateKey(btcec.S256())
   if err != nil {
       err = errors.Wrap(err, "c.GenerateAddress")
       return
   }
 
   wif, err := btcutil.NewWIF(secret, bs.getNetworkParams(), true)
   if err != nil {
       err = errors.Wrap(err, "c.GenerateAddress")
       return
   }
   privKey = wif.String()
 
   addr, err := btcutil.NewAddressPubKey(wif.PrivKey.PubKey().SerializeCompressed(), bs.getNetworkParams())
   if err != nil {
       err = errors.Wrap(err, "btcutil.NewAddressPubKey")
       return
   }
 
   address = addr.EncodeAddress()
 
   return
}


// get btc balance (step2):
func (bs *BlockcypherService) GetBalance(address string) (*big.Int, error) {
 
   btcAddrInfo, err := bs.BTCGetAddrInfo(address)
   if err != nil {
       return nil, errors.Wrap(err, "c.btc.BalanceAt")
   }
   b := new(big.Int)
   b.SetUint64(btcAddrInfo.Balance)
   return b, nil
}

// send pBTC (step3):
func (b *Blockchain) SendToken(privateKey string, receiverAddress string, tokenId string, amount uint64, fee uint64, feeTokenId string) (string, error) {
   if tokenId == common.PRV {
       var listPaymentAddresses = make(map[string]uint64)
       listPaymentAddresses[receiverAddress] = amount
       return b.CreateAndSendConstantPrivacyTransaction(privateKey, serializers.WalletSend{
           Type:             0,
           PaymentAddresses: listPaymentAddresses,
       })
   }
 
   param := serializers.WalletSend{
       TokenID:     tokenId,
       Type:        1,
       PaymentAddresses: map[string]uint64{
           receiverAddress: amount,
       },
   }
 
   if feeTokenId == tokenId {
       param.TokenFee = fee
   }
 
   tx, err := b.SendPrivacyCustomTokenTransaction(privateKey, param)
 
   if err != nil {
       return "", errors.Wrap(err, "b.SendPrivacyCustomTokenTransaction")
   }
 
   txID, ok := tx["TxID"].(string)
   if !ok {
       return "", errors.Errorf("couldn't get txID: result: %+v", tx)
   }
   return txID, nil
}


// send btc (step4):
func (bs *BlockcypherService) SendTransaction(secret string, from string, destination string, amount int, fee int) (string, error) {
 
   wif, err := btcutil.DecodeWIF(secret)
   if err != nil {
       return "", err
   }
 
   pkHex := hex.EncodeToString(wif.PrivKey.Serialize())
   tx := gobcy.TempNewTX(from, destination, amount)
   tx.Fees = fee
   skel, err := bs.chain.NewTX(tx, false)
 
   if err != nil {
       return "", err
   }
   prikHexs := []string{}
   for i := 0; i < len(skel.ToSign); i++ {
       prikHexs = append(prikHexs, pkHex)
   }
 
   err = skel.Sign(prikHexs)
   if err != nil {
       log.Println(err)
       return "", err
   }
 
   skel, err = bs.chain.SendTX(skel)
   if err != nil {
       log.Println(err)
       return "", err
   }
   return skel.Trans.Hash, nil
}
```

#### Swap pBTC (Incognito Network) to Bitcoin (Bitcoin Network)

    1. Generate a new Incognito temp wallet (show qr-code) on the swap page
    2. User sends pBTC to the Incognito temp address
    3. Check pBTC balance in temp wallet
    4. Send BTC (form Bitcoin master wallet) to the users Bitcoin payment address
    5. Send pBTC to master Incognito wallet

