This tutorial is how to create & send transactions

### Insert Image

### How to code transactions

#### SDK

```javascript
const history = await account.nativeToken.transfer(
    [
        {
            paymentAddressStr: "<ToAddressValue>",
            amount: 10,
            message: '<this is memo data>'
        }
    ],
    20 // fee in nano PRV
);
console.log('Native token sent with history', history);

```

#### RPC

```bash
curl --location --request POST 'https://testnet.incognito.org/fullnode' \
--header 'Content-Type: application/json' \
--header 'Cookie: __cfduid=d02b0884938833edfd78362a32848edf31606194545' \
--data-raw '{
    "id": 1,
    "jsonrpc": "1.0",
    "method": "createandsendtransaction",
    "params": [
        "112t8roafGgHL1rhAP9632Yef3sx5k8xgp8cwK4MCJsCL1UWcxXvpzg97N4dwvcD735iKf31Q2ZgrAvKfVjeSUEvnzKJyyJD3GqqSZdxN4or",
        {
            "12Rtdi54JhcJsDBYvgCFCb8Dmwhpt5S8AiRD2RQvqJFKUDLA4R2jyM2tnmBir5bRp2w1Ydp1Y85yN86ni9t2GbMNx5LaE3VmwDftjE1": 1750000000100,
            "12RxERBySmquLtM1R1Dk2s7J4LyPxqHxcZ956kupQX3FPhVo2KtoUYJWKet2nWqWqSh3asWmgGTYsvz3jX73HqD8Jr2LwhjhJfpG756": 1000000000000999,
            "12RyJTSL2G8KvjN7SUFuiS9Ek4pvFFze3EMMic31fmXVw8McwYzpKPpxeW6TLsNo1UoPhCHKV3GDRLQwdLF41PED3LQNCLsGNKzmCE5": 1750000000100,
            "12Rxy3sVosEnN5FJdHGYV41GkDinGLwUudr5k7vCfLJ9Rk7KijzJhgDPuKu4THtD8RBNYyzb462iiEh1W13niiQHbfmHdNedycb7keF": 3500000000200,
            "12Rrgnrh5KDKLZgQvX13MrjsXQr8NMmWcspzcRKVBwB7YuyRmJsm4aJeGwpnXoeeNtKP9FMt2ExeSCAe2yUuA4yAbUfMQEpSNT1Aju5": 1750000000100,
            "12RtmpqwyzghGQJHXGRhXnNqs7SDhx1wXemgAZNC2xePj9DNpxcTZfpwCeNoBvvyxNU8n2ChVijPhSsNhGCDmFmiwXSjQEMSef4cMFG": 1750000000100,
            "12RwbexYzKJwGaJDdDE7rgLEkNC1dL5cJf4xNaQ29EmpPN52C6oepWiTtQCpyHAoo6ZTHMx2Nt3A8p5jYqpYvbrVYGpVTen1rVstCpr": 1750000000100,
            "12S1DR4dMETwoGVz3KmYpVCeVYDpsjSMEjqQTJwwjoX3Gi41Ue56o6faB6LCrHQ78wXauVSNs2zjYNPWsJ32mx6QYkBAjUdJkHpPHES": 1750000000100,
            "12S5Lrs1XeQLbqN4ySyKtjAjd2d7sBP2tjFijzmp6avrrkQCNFMpkXm3FPzj2Wcu2ZNqJEmh9JriVuRErVwhuQnLmWSaggobEWsBEci": 1000000000000999,
            "12RvFuCs3hLm886pfA6KHyuD1MGqD663g8XtaiAQuSk611kuAv8zyS52CRD2uhxF5L2xjCNn4hbjkyc86L64vTyjXCEHAsRkpSMGJ6D": 1750000000100
        },
        -1,
        0
    ]
}'
```

#### Example App Source at : routes/Send/

```javascript
#look file Send.enhance.tsx
import React from 'react';
import { compose } from 'recompose';
import ErrorBoundary from 'src/components/ErrorBoundary';
import { withLayout } from 'src/components/Layout';
import { reduxForm } from 'redux-form';
import convert from 'src/utils/convert';
import { useDispatch, useSelector } from 'react-redux';
import toString from 'lodash/toString';
import { ISelectedPrivacy, selectedPrivacySelector } from 'src/routes/Token';
import { decimalSeparatorSelector } from 'src/routes/Preload';
import { defaultAccountSelector } from 'src/routes/Account';
import {
  AccountInstance,
  PaymentInfoModel,
} from 'incognito-js/build/web/browser';
import { MAX_FEE_PER_TX } from './Send.utils';
import { route as routeConfirmTx } from './features/ConfirmTx';
import { useHistory } from 'react-router-dom';

interface IProps {}

export interface TOutter {
  handleSubmit: () => void;
  handleSend: (values: {
    amount: string;
    toAddress: string;
    memo?: string;
  }) => void;
  disabledForm: boolean;
  submitting: boolean;
  validateAmount: any;
}

export const FORM_CONFIGS = {
  formName: 'form-send',
  amount: 'amount',
  toAddress: 'toAddress',
  fee: 'fee',
  memo: 'memo',
};

const enhance = (WrappedComponent: React.FunctionComponent) => (props: any) => {
  const dispatch = useDispatch();
  const history = useHistory();
  const selectedPrivacy: ISelectedPrivacy = useSelector(
    selectedPrivacySelector
  );
  const decimalSeparator = useSelector(decimalSeparatorSelector);
  const account: AccountInstance = useSelector(defaultAccountSelector);
  const handleSend = async (values: {
    amount: string;
    toAddress: string;
    memo?: string;
  }) => {
    try {
      const { amount, toAddress, memo = '' } = values;
      if (!amount || !toAddress) {
        return;
      }
      const originalAmount = convert.toOriginalAmount({
        humanAmount: amount,
        decimalSeparator,
        decimals: selectedPrivacy.pDecimals,
      });
      const paymentInfos: PaymentInfoModel[] = [
        {
          paymentAddressStr: account.key.keySet.paymentAddressKeySerialized,
          amount: toString(originalAmount),
          message: memo,
        },
      ];
      const tx = await account.nativeToken.transfer(
        paymentInfos,
        toString(MAX_FEE_PER_TX)
      );
      if (!tx) {
        throw new Error(`Failed`);
      }
      history.push(routeConfirmTx, {
        tx,
        isNativeToken: true,
      });
    } catch (error) {
      console.debug(error);
      throw error;
    }
  };
  return (
    <ErrorBoundary>
      <WrappedComponent {...{ ...props, handleSend }} />
    </ErrorBoundary>
  );
};

export default compose<IProps, TOutter>(
  withLayout,
  reduxForm<{}, TOutter>({
    form: FORM_CONFIGS.formName,
  }),
  enhance
);
```
### Network Fee(s)

Minimum fee for transaction is 1 nano PRV.

To calculate fees for a transaction we set value in chain at 1 nano prv / 1 kb size of transaction.

Transaction Formula = 1 * kb = fee
