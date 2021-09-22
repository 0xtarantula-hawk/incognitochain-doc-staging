### 3 Steps to have a simple pAPP

#### 1. Create simple reactjs app

```bash
npx create-react-app my-app
cd my-app
npm start

yarn add https://github.com/incognitochain/sdk#papp-client-sdk
```

#### 2. Install pAPP-SDK

```bash
yarn add https://github.com/incognitochain/sdk#papp-client-sdk
```

Import SDK & Action

PAPP-SDK

```javascript
#SDK
export function requestSendTx({ receivers, info }) {
  new Validator('info', info).string();
  new Validator('receivers', receivers).required().receivers();

  const pendingTxId = _genPendingTxId();
  return new Promise((resolve, reject) => {
    // // request timeout in 5 mins
    // const timeout = setTimeout(() => {
    //   delete pendingRequestTxs[pendingTxId];
    //   reject(sdkError(ERROR_CODE.REQUEST_SEND_TX_TIMEOUT, 'Request send TX timeout'));
    // }, 5 * 60 * 1000);
    __sendCommand(COMMANDS.SEND_TX, { pendingTxId, receivers, info });
    pendingRequestTxs[pendingTxId] = { resolve, reject /* timeout */ };
  });
}

export function requestSingleSendTx(
  toAddress,
  nanoAmount,
  info,
  paymentInfos = []
) {
  new Validator('toAddress', toAddress).required().paymentAddress();
  new Validator('nanoAmount', nanoAmount).required().nanoAmount();
  new Validator('info', info).string();
  new Validator('paymentInfos', paymentInfos).paymentInfos();

  const pendingTxId = _genPendingTxId();
  return new Promise((resolve, reject) => {
    try {
      __sendCommand(COMMANDS.SEND_TX, {
        pendingTxId,
        toAddress,
        amount: nanoAmount,
        info,
        paymentInfos,
      });
      resolve(pendingTxId);
    } catch (error) {
      reject(error);
    } finally {
      pendingRequestTxs[pendingTxId] = { resolve, reject /* timeout */ };
    }
  });
}
```

Example to Use

```javascript
import SDK from 'papp-sdk';

const txInfo = await SDK.requestSingleSendTx(toAddress, nanoAmount,"Paid Salary Incognito",null);
//console.log(txInfo); 
var txInfoStr = JSON.stringify(txInfo); 
//alert(txInfoStr);
if (txInfo.txId) {
//uiControl.showMessage('Rolling...'); 
//console.log(txInfo.txId); 
  
}
```

#### 3. Result on Incognito-wallet

go to the wallet -> open home/browser enter your local IP:port of the reactjs app

example: http://192.168.1.15:3000 (192.168.1.15 => your PC running the react-app)

You will see a confirm transaction like image on the incognito-wallet

### Insert Image
