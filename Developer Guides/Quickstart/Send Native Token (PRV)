After setup and init project, this is the next step to create an example.

How to use account instance to send (PRV) the native token.

```bash
   // Import Account from private key init to test. 
   // Or get account0 from example create app  
    const account = await wallet.masterAccount.importAccount('Imported acc', 
    '112t8rnXgPXDxxX6EsPpUfBp4js9DDVB85cEATKcngub2SDJeMT9veuUbrGyVRc2xJmB1vVTsoq7KPruvNe4GDK9oRAoFLrmzi31TfaiufBf');  
   
    //use acount instance 
    let history = await account.nativeToken.transfer([
         {
           paymentAddressStr: '12RzYMVWAujX9hdXoNFwUxpeZFDSfs3PedaiqgG36bd9RPFjdMfuNmoyXSGTvpoHzm3dXh6ABmusooJEsNzXtcGGEzJzscgWD3wNGib',
           amount:  '1000000', //string 
           message: ''  
         }
        ], 
        '10'  //Native fee , pay by PRV token. this value 10 nano prv
     );

    console.log(history.txId);
```
