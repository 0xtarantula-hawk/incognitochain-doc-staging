## Create React App

```bash
npx create-react-app my-app
cd my-app
#npm start
```

## Install SDK-v2

```bash
cd my-app 
#install sdk 

yarn add https://github.com/incognitochain/sdk-v2#develop

#copy privacy 
cp node_modules/incognito-js/privacy.wasm ./public 
#run 
yarn start

# your web start at ex : http://localhost:3000
```

## User

Make sure you start project at port default of 3000, try to get file via link:
>http://localhost:3000/privacy.wasm

#### App.js

```javascript
import logo from './logo.svg';
import './App.css';
import React, { useState, useEffect } from 'react';
import * as incognitoJs from 'incognito-js/build/web/browser';
 
function App() {

  const [account0, setAccount] = useState(null);

  async function InitWalletAndGeneratedKeychain() {
    // You can await here
    
    await incognitoJs.setConfig ({
      logMethod: function(logMessage) { console.log(`LOG: ${logMessage}`);},
      chainURL: "https://testnet.incognito.org/fullnode", // 
      apiURL:  "https://<>//",
      mainnet: false, // update this property will change apiURL & chainURL if they are not defined
      wasmPath: 'http://localhost:3000/privacy.wasm' // path to the binary file, the SDK will find the wasm in where it was executed
   })

    await incognitoJs.goServices.implementGoMethodUseWasm();

    const wallet = new incognitoJs.WalletInstance();
    await wallet.init('my-passphrase', 'TEST-WALLET');

    const account1 = await wallet.masterAccount.addAccount('Account 1', 3);

    //setWallet(wallet);
    console.log('New account1', account1);

    setAccount(account1);
    
    // ...
  }

  // Similar to componentDidMount and componentDidUpdate:
  useEffect(() => {
    // Update the document title using the browser API  
    if(account0==null){
      InitWalletAndGeneratedKeychain();
    }
   
  });

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
         {account0 !=null ? 
                   <div>
                     <p> Private Key <code>{account0.key.keySet.privateKeySerialized}</code>  
                      </p>
                      <p>
                        Payment Adress <code>{account0.key.keySet.paymentAddressKeySerialized}</code>  
                      </p>
                    </div> : "" 
            }
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
```

#### SDK

```javascript
import * as incognitoJs from 'incognito-js/build/web/browser';

await incognitoJs.setConfig ({
   logMethod: function(logMessage) { console.log(`LOG: ${logMessage}`);},
   chainURL: "", // 
   apiURL:  "",
   mainnet: false, // update this property will change apiURL & chainURL if they are not defined
   wasmPath: 'http://localhost:3000/privacy.wasm' // path to the binary file, the SDK will find the wasm in where it was executed
})

 await incognitoJs.goServices.implementGoMethodUseWasm();

 const wallet = new incognitoJs.WalletInstance();
 await wallet.init('my-passphrase', 'TEST-WALLET');

 const account1 = await wallet.masterAccount.addAccount('Account 1', 3);

 //setWallet(wallet);
 console.log('New account1', account1);

 setAccount(account1);
```
