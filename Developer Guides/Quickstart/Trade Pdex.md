This is a quick example to use the SDK to make a request trade on Pdex.

**Note:** This transaction will not have privacy, do NOT try with your master wallet.

#### Request_trade

```javascript
const incognitoJs = require('incognito-js/build/node');
const { setConfig, WalletInstance } = incognitoJs;
// config incognito JS use testnet
setConfig({ mainnet: false, chainURL: 'https://testnet.incognito.org/fullnode' });

function setMethod(key, value) {
    return Promise.resolve();
}
function getMethod(key) {
    return Promise.resolve(null);
}
function removeMethod(key) {
    return new Promise(() => {
        // remove data from device storage
    });
}
//implement storage 
incognitoJs.storageService.implement({
    setMethod,
    getMethod,
    removeMethod,
});

(async function () {
    await incognitoJs.goServices.implementGoMethodUseWasm();
    const wallet = new WalletInstance();
    await wallet.init('my-passphrase', 'TEST-WALLET');
    const importedAccount = await wallet.masterAccount.importAccount('Master', 
        '112t8rnY4DeSGZYb8r8sSN5WJr6ZL3NCafYAQ7f7Am9KXQDGSc3Qddpn7BfHW1i6CoVVk8vKEzJ25vA9uc9EdhoLU98eoUw7fMrPPrBdNB7Q');    try {
        
        //console.debug('CONFIG', incognitoJs.getConfig());
        
        const res = await importedAccount.nativeToken.requestTrade(
            '880ea0787f6c1555e59e3958a595086b7802fc7a38276bcd80d4525606557fbc',
            1e9,
            0,
            100,
            0
        );
        console.debug('RES', res);
    } catch (error) {
        console.debug('ERROR', error);
    }
})();
```

#### sdk function

```javascript
async requestTrade(
    tokenIdBuy: TokenIdType, // token id which you want to buy.
    sellAmount: string,      // sell amount to buy token : "1000000000" => 1PRV
    minimumAcceptableAmount: string, // 
    nativeFee: string,       // fee using prv native. ex: "100" // 100 nano prv
    tradingFee: string       // fee for trading, use prv fee.
  )
```
