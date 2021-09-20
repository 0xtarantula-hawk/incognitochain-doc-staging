#### Apply for NodeJS:

https://github.com/incognitochain/sdk-v2

```bash
#Install SDK 

yarn add https://github.com/incognitochain/sdk-v2

#Usage 
#Copy wasm binary to your root project:

cp node_modules/incognito-js/privacy.wasm .

//In your application ex : main.js 
//Load SDK & Init object 

const incognitoJs = require('incognito-js/build/node');

//Load WebAssembly:
await incognitoJs.goServices.implementGoMethodUseWasm();

// Implement storage
```

#### Apply for Browser:

```bash
//Copy wasm binary to your root project:
//cp node_modules/incognito-js/privacy.wasm .

//Module

import * as incognitoJs from 'incognito-js';

// Load WebAssembly:

await incognitoJs.goServices.implementGoMethodUseWasm();

// Next implement storage.
```

####

or import Javascript file to HTML

```html
<script src="...incognito-js/build/web/browser/index.js"></script>
<script>
	// Load WebAssembly:
	await incognitoJs.goServices.implementGoMethodUseWasm();
</script>
```

#### With React-Native

Please use [react-native-incognito-js](https://github.com/incognitochain/react-native-incognito-js) for React Native.

#### Implements Storage

`incognitoJs` needs to cache some data into storage to work correctly like coin information, tx history, etc. So please implement `incognitoJs` storage service:

```bash
incognitoJs.storageService.implement({
  // namespace: 'YOUR-STORAGE-NAMESPACE',
  setMethod: (key: string, value: string) {
    return new Promise((resolve, reject) => {
        // store data to storage device, for example:
        // localStorage on Browser
        // AsyncStorage on React Native

        resolve();

        if (error) {
            reject(error);
        }
    });
  },
  getMethod: (key: string) {
    return new Promise(() => {
        // get data from device storage
    });
  },
  removeMethod: (key: string) {
    return new Promise(() => {
        // remove data from device storage
    });
  },
});
```
