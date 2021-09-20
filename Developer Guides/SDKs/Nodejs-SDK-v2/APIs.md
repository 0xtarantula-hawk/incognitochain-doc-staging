### APIs

How to install and use Incognito SDK 

### Install

> $ yarn add https://github.com/incognitochain/sdk-v2

### Usage

```bash
cp node_modules/incognito-js/privacy.wasm
```

### Nodejs

```javascript
const incognitoJs = require('incognito-js/build/node');

// Load WebAssembly:
await incognitoJs.goServices.implementGoMethodUseWasm();
```

Follow this step to implement storage

### Browser

Module

```
import * as incognitoJs from 'incognito-js';

// Load WebAssembly:
await incognitoJs.goServices.implementGoMethodUseWasm();
```

Or import Javascript file to html (`incognitoJs` object is attached to your browser window object).

```
<script src="...incognito-js/build/web/browser/index.js"></script>
<script>
    // Load WebAssembly:
    await incognitoJs.goServices.implementGoMethodUseWasm();
</script>
```

Follow this step to implement storage

### React Native

Please use react-native-incognito-js for React Native and follow this step to implement storage.

### Implement Storage

`incognitoJs` needs to cache some data into storage to work correctly like coin information, tx history, etc. So please implement `incognitoJs` storage service:

```
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

### API

#### Config

setConfig

Usage:

```
setConfig (
    logMethod: (message: string) => void (pass null to disable log)
    chainURL: string // 
    apiURL: string
    mainnet: boolean // update this property will change apiURL & chainURL if they are not defined
) => void
```

Example:

```
const { setConfig  } = incognitoJs;

// config incognito JS use testnet
setConfig({ mainnet: false });

// config incognito JS use log
setConfig({ logMethod: function(logMessage) {
    console.log(`LOG: ${logMessage}`);
} });
```

getConfig

Get current config

#### History Services

getTxHistoryByPublicKey

Get history that belongs to an account (use accounts `publicKeySerialized` as the key)

Usage:

```
getTxHistoryByPublicKey(
    publicKeySerialized: string,
    tokenId?: string
) => Promise<TxHistoryModel[]>
```

Example:

```
const { historyServices  } = incognitoJs;

// load all tx histories for native token
const histories = await historyServices.getTxHistoryByPublicKey(
    account.key.keySet.publicKeySerialized, // publicKeySerialized of the account
    null // token id or use null for native token
);
```

checkCachedHistories

Get update for all cached tx histories (tx histories are send/init/burn/trade/contribute transactions).

Usage:

```
checkCachedHistories() => Promise
```

Example:

```
const { historyServices  } = incognitoJs;

await historyServices.checkCachedHistories(); // all tx histories were up to date

// load all tx histories for native token
const updatedHistories = await account.nativeToken.getTxHistories();
```

#### Go Services:

`incognitoJs` uses some methods implemented by Go to improve performance. Go will be built to WASM (Web Assembly) for Nodejs/browser enviroments and Gomobile for React Native.

implementGoMethodUseWasm

Used on Nodejs/browser envirnoments

Usage:

```
implementGoMethodUseWasm() => Promise
```

Example:

```
const { goServices  } = incognitoJs;

await goServices.implementGoMethodUseWasm();

console.log('Go methods were implemented!')
```

implementGoMethodManually

Implement go methods manually (for React Native). Please use react-native-incognito-js, it is a `incognitoJs` library wrapper, all Go methods have been implemented already.

Usage:

```
// define Go methods
const implementData = {
    deriveSerialNumber: (data: string) => string;
    initPrivacyTx: (data: string) => string;
    randomScalars: (data: string) => string;
    staking: (data: string) => string;
    stopAutoStaking: (data: string) => string;,
    initPrivacyTokenTx: (data: string) => string;
    withdrawDexTx: (data: string) => string;
    initPTokenTradeTx: (data: string) => string;
    initPRVTradeTx: (data: string) => string;
    initPTokenContributionTx: (data: string) => string;
    initPRVContributionTx: (data: string) => string;
    initWithdrawRewardTx: (data: string) => string;
    initBurningRequestTx: (data: string) => string;
    generateKeyFromSeed: (data: string) => string;
    scalarMultBase: (data: string) => string;
    hybridEncryptionASM: (data: string) => string;
    hybridDecryptionASM: (data: string) => string;
    generateBLSKeyPairFromSeed: (data: string) => string;
};

// implement
implementGoMethodManually(implementData) => Promise
```

Example:

```
const { goServices  } = incognitoJs;

await goServices.implementGoMethodManually({ ... });

console.log('Go methods were implemented!')
```

Go method name

List of Go method names

Example:

```
const { goServices  } = incognitoJs;

console.log(goServices.GO_METHOD_NAMES)
```

#### Wallet Services

setPrivacyUtilRandomBytesFunc

Implement random bytes function

Usage:

```
setPrivacyUtilRandomBytesFunc(Function) => void
```

Example:

```
import myRandomByteFunction from '..';
const { walletServices  } = incognitoJs;

walletServices.setPrivacyUtilRandomBytesFunc(myRandomByteFunction);
```

#### Storage Services

Implement

Implement Storage

Usage:

```
// implement data
const data = {
    setMethod(key: string, data: string) : Promise;
    getMethod(key: string) : Promise;
    removeMethod(key: string) : Promise
    namespace: string; (optional)
};

// implement
implement(data) => void
```

Example:

```
const { storageService  } = incognitoJs;

storageService.implement({ ... });
```

#### Bridge Services

removeBridgeHistory - Cancel/remove a deposit/withdrawal history

Usage:

```
removeBridgeHistory({
    historyId: number,
    currencyType: number,
    isDecentralized: boolean
}) => Promise
```

Example:

```
const { bridgeServices   } = incognitoJs;

bridgeServices.removeBridgeHistory({ ... });
```

#### Constant

All of constants used in the library

Example:

```
const { CONSTANT } = incognitoJs;

console.log('Incognito JS constants:', CONSTANT);
```

#### WalletInstance

Public Property | Type | Default Value | Description
:--- | :---: | :---: | :--- 
seed | Uint9Array |  |  |
entropy | number[] | |  |
passPhrase | string | | Wallet pass phrase
mnemonic | string |  |  |
masterAccount | MasterAccount | | The main account in wallet
name | string | | Wallet Name


init - Init a new wallet

Usage:

```
init(passPhrase: string, name?: string) => Promise<WalletInstance>
```

```
const { WalletInstance } = incognitoJs;

const wallet = new WalletInstance();
await wallet.init('my-passphrase', 'TEST-WALLET');

console.log('New wallet', wallet);
```

backup - Backup a wallet with password

Usage:

```
backup(password: string) => string
```

Example:

```
const backupWalletString = wallet.backup('backup-password');

console.log('Backed up wallet string', backupWalletString);
```

restore - Restore a wallet from backup

Usage:

```
restore(encryptedWallet: string, password: string) => Promise<WalletInstance>
```

Example:

```
const { WalletInstance   } = incognitoJs;

const wallet = await WalletInstance.restore(backupWalletString, 'backup-password');

console.log('Restored wallet', wallet);
```

### MasterAccount

MasterAccount is a special account, the Incognito wallet is only have one MasterAccount, this account can contain many Accounts (or AccountInstance)

Public Property | Type | Default Value | Description
:--- | :---: | :---: | :---
child | array | [ ] | Array of children account
key | KeyWalletModel | | key wallet

getAccounts - Get all child accounts

Usage:

```
getAccounts() => <AccountInstance>[ ]
```

Example:

```
const accounts = wallet.masterAccount.getAccounts();
console.log('Account list', accounts);
```

addAccount - Create a child account `shardId` will be randomly selected if not provided.

Usage:

```
addAccount(name: string, shardId?: number) => Promise<AccountInstance>
```

Example:

```
// create an account with shard ID 3
const account1 = await wallet.masterAccount.addAccount('Account 1', 3);
console.log('Account with shard ID 3', account1);

// create an account with random shardID
const account2 = await wallet.masterAccount.addAccount('Account 2');
console.log('Account with random shard ID', account2);
```

removeAccount - Remove an account by name

Usage:

```
removeAccount(name: string) => void 
```

Example:

```
// remove account name "Account 1"
wallet.masterAccount.removeAccount('Account 1');

console.log('Remaining accounts', wallet.masterAccount.getAccounts());
```

importAccount - Import account from its private key

Usage:

```
importAccount(name: string, privateKey: string) => Promise<AccountInstance>
```

Example:

```
// import account with private key "ABCDEF"
const importedAccount = await wallet.masterAccount.importAccount('Imported account', 'ABCDEF');

console.log('Imported account', importedAccount);
```

getBackupData - Return backup object for the account

Usage:

```
getBackupData() => string
```

Example:

```
const backupObject = wallet.masterAccount.getBackupData();
console.log('Account backup', backupObject);
```

restoreFromBackupData - Restore from backup object for the account

Usage:

```
restoreFromBackupData(backupObject) => MasterAccount
```

Example:

```
const { MasterAccount } = incognitoJs;
const masterAccount = MasterAccount.restoreFromBackupData(backupObject);

console.log('Restored master account', masterAccount);
```

AccountInstance - AccountInstance is child account belonging to MasterAccount

Public Property | Type | Default Value | Description 
:--- | :---: | :---: | :---
name | string | | Account name
isImport | boolean | false | Is this account imported
key | KeyWalletModel |  | Key wallet
nativeToken | NativeTokenInstance |  | Native token is PRV
privacyTokenIds | string[ ] | | List of following PrivacyTokenIstance id



getBLSPublicKeyB58CheckEncode - Get BLS public key

Usage:

```
getBLSPublicKeyB58CheckEncode() => Promise<string>
```

Example:

```
const blsPublicKey = await account.getBLSPublicKeyB58CheckEncode();

console.log('BLS Public Key', blsPublicKey);
```

followTokenById - Add a token id to following list of the account

Usage:

```
followTokenById(tokenId: string) => void
```

Example:

```
// follow pBTC
account.followTokenById("b832e5d3b1f01a4f0623f7fe91d6673461e1f5d37d91fe78c5c2e6183ff39696");

const followingTokens = await account.getFollowingPrivacyToken();
console.log('Following tokens', followingTokens);
console.log('Following token ids', account.privacyTokenIds);
```


