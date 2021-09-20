## React-Native Mobile

We recommend this section for advance develop, whois want to re-build incognito-wallet.

Incognito open-source the mobile wallet app, any one can clone source and build it to use.

Now I tutorial step by step how to re-config and build incognito wallet.

### Insert Image

## Setup Envirnoment

Incognito build source use React-Native, so let setup your PC env develop for React-Native follow this link to do it [React-Native-App](https://facebook.github.io/react-native/docs/getting-started). 

then now ,

```bash
# clone source code 
git clone https://github.com/incognitochain/incognito-wallet.git

# checkout develop branch 
git checkout develop 

# Make sure you copied .sample.env to .env (or .env.production in production build,
# will fallback to .env if this file was not exist) for setting enviroment varibles.

cp .sample.env .env

#Install dependencies, make sure Yarn was installed

yarn 
yarn postinstall


#Start project in development

#react-native run-android (for Android)
#react-native run-ios (for iOS) 

#also please look the package.json we have config commandline to build. you can run :

#open 1st terminal console
yarn start 
#open 2nd terminal console
yarn androidDebug #(for android )
yarn iosDebug #(for ios )
```

### Build & Run

```bash
#open 1st terminal console
yarn start 
#open 2nd terminal console
yarn androidDebug #(for android )
yarn iosDebug #(for ios )
```
