### Get Token Balance


#### SDK
```javascript
#Token Native Instance (PRV)
#account.nativeToken

const balanceBN = await account.nativeToken.getTotalBalance();
console.log('Native token total balance', balanceBN.toNumber());
```

#### In Example app: routes/Tokens

```javascript
#file token.action.js

export const actionGetBalanceToken = (token: PrivacyTokenInstance) => async (
  dispatch: Dispatch,
  getState: () => IRootState
) => {
  const state: IRootState = getState();
  const translate: ILanguage = translateSelector(state);
  const tokenTranslate = translate.token;
  const tokenId = token?.tokenId;
  let amount;
  if (!tokenId) {
    throw new Error(tokenTranslate.error.tokenIdRequired);
  }
  try {
    dispatch(actionGetBalanceTokenFetching({ tokenId }));
    const totalBalance = await token.getTotalBalance(tokenId);
    amount = totalBalance.toNumber();
  } catch (e) {
    throw e;
  } finally {
    dispatch(
      actionGetBalanceTokenFetched({
        tokenId,
        amount: amount || 0,
      })
    );
  }
  return amount;
};
```
