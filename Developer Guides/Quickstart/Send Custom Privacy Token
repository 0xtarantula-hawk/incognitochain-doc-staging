How to use Account instance to send a custom token. 

Step 1: Import and Follow Token ID for the Account 

Step 2: Load Privacy Token Instance Object

Step 3: Make Transaction ,  only TOKEN have Pair in DEX with PRV pool size >= 10000 PRV can use for custom privacy token fee in transaction fee. if not , you need pay fee by PRV. 

```bash
   // Import Account from private key init to test.
   let importedAccount = await wallet.masterAccount.importAccount('Imported acc', 
   '112t8rnXgPXDxxX6EsPpUfBp4js9DDVB85cEATKcngub2SDJeMT9veuUbrGyVRc2xJmB1vVTsoq7KPruvNe4GDK9oRAoFLrmzi31TfaiufBf');  
```

```bash
  //STEP 1: Add Follow Token
  let tokenId = "744c8a4b27ca794a029179bc1624b7f922ffe1ef4360602d0e9e8ce242a24ffc"
  await importedAccount.followTokenById(tokenId); 
  
  //STEP 2: Get Instance of privacyToken
  const privacyToken = await importedAccount.getFollowingPrivacyToken(tokenId);
  
  //Check Object Privacy Token.
  if (privacyToken instanceof incognitoJs.PrivacyTokenInstance) {
    
    //STEP 3: transfer 
    let history  = await privacyToken.transfer([
      {
        paymentAddressStr: '12RzYMVWAujX9hdXoNFwUxpeZFDSfs3PedaiqgG36bd9RPFjdMfuNmoyXSGTvpoHzm3dXh6ABmusooJEsNzXtcGGEzJzscgWD3wNGib',
        amount: '10' // amount privacy token want to transfer 
        message: ''
      }
    ],
    '10', //fee in native token prv  : '10' nano prv
    ''    // '' : null custom privacy token fee 
    );  
    
    console.log(history);
```
