package io.cryptokylin.KylinSDK;

import android.content.Context;
import android.util.Log;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import io.cryptokylin.KylinSDK.been.Callback;
import io.cryptokylin.KylinSDK.been.KylinCallback;
import io.cryptokylin.KylinSDK.been.KylinContract;
import io.cryptokylin.KylinSDK.been.KylinLogin;
import io.cryptokylin.KylinSDK.been.KylinPay;
import io.cryptokylin.KylinSDK.been.KylinSign;

public class Demo {

    public static void testKylinPay(Context context) {
        KylinPay kylinPay = new KylinPay();
        kylinPay.setFrom("a账号"); //可选
        kylinPay.setTo("b账号");
        kylinPay.setTokenid("eos");
        kylinPay.setNum("0.0001");
        kylinPay.setMemo("test");
        kylinPay.setMsg("it is pay");
//      kylinPay.setActionid(); 可选
//      kylinPay.setUserid(); 可选
        kylinPay.setDappsymbol("dappone_c391d81c");
//      kylinPay.setAuthorization(""); 可选
        kylinPay.setCb("KylinDappDemo");
        KylinManager.getInstance().requestPay(context, kylinPay, new KylinCallback() {
            @Override
            public void callBack(Map<String, String> paramMap, Callback callBack) {
                Log.d("Kylin", paramMap.toString() + callBack);
            }
        });
    }

    public static void testKylinLogin(Context context) {
        KylinLogin kylinLogin = new KylinLogin();
        kylinLogin.setTokenid("eos");
        kylinLogin.setDappsymbol("dappone_c391d81c");
//      kylinLogin.setAuthorization("");可选
        kylinLogin.setCb("KylinDappDemo");
        KylinManager.getInstance().requestLogin(context, kylinLogin, new KylinCallback() {
            @Override
            public void callBack(Map<String, String> paramMap, Callback callBack) {
                Log.d("Kylin", paramMap.toString() + callBack);
            }
        });
    }

    public static void testKylinSign(Context context) {
        KylinSign kylinSign = new KylinSign();
        kylinSign.setTokenid("eos");
        kylinSign.setAccountname("a账号");
//      kylinSign.setCustomdata("");可选
        kylinSign.setMsg("it is sign");
        kylinSign.setDappsymbol("dappone_c391d81c");
//      kylinSign.setAuthorization("");可选
        kylinSign.setCb("KylinDappDemo");
        KylinManager.getInstance().requestSign(context, kylinSign, new KylinCallback() {
            @Override
            public void callBack(Map<String, String> paramMap, Callback callBack) {
                Log.d("Kylin", paramMap.toString() + callBack);
            }
        });
    }

    public static void testKylinContract(Context context) {
        KylinContract kylinContract = new KylinContract();
        kylinContract.setTokenid("eos");
        kylinContract.setDappsymbol("dappone_c391d81c");
//      kylinContract.setAuthorization("");可选
        kylinContract.setAccount("a账号");
        kylinContract.setAddress("公钥地址");
//      kylinContract.setOptions("");可选
//      kylinContract.setActionid("");可选
        kylinContract.setMsg("it is sign");
        kylinContract.setCb("KylinDappDemo");

        String action1 = "{\"account\":\"eosio.token\",\"name\":\"transfer\",\"authorization\":[{\"actor\":\"a账号\", \"permission\":\"owner\"}],\"data\":{\"from\":\"a账号\", \"to\":\"b账号\",\"quantity\":\"0.0001 EOS\",\"memo\":\"test\"}}";
        List<String> actions = new ArrayList<>();
        actions.add(action1);
        kylinContract.setActions(actions);

        KylinManager.getInstance().requestContract(context, kylinContract, new KylinCallback() {
            @Override
            public void callBack(Map<String, String> paramMap, Callback callBack) {
                Log.d("Kylin", paramMap.toString() + callBack);
            }
        });
    }
}
