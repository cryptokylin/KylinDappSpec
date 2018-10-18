package io.cryptokylin.KylinSDK;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.TextUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.cryptokylin.KylinSDK.been.Callback;
import io.cryptokylin.KylinSDK.been.KylinCallback;
import io.cryptokylin.KylinSDK.been.KylinContract;
import io.cryptokylin.KylinSDK.been.KylinLogin;
import io.cryptokylin.KylinSDK.been.KylinPay;
import io.cryptokylin.KylinSDK.been.KylinSign;

public class KylinManager {
    KylinCallback kylinCallback;

    private static final class Holder {
        private static final KylinManager INSTANCE = new KylinManager();
    }

    private KylinManager() {

    }

    public static final KylinManager getInstance() {
        return Holder.INSTANCE;
    }

    private static void common(Context context, String protocol, String paramJson) {
        StringBuilder uriBuild = new StringBuilder();
        uriBuild.append(protocol);
        uriBuild.append("?");
        String paramDecrypt = Utils.encodeToString(paramJson);
        uriBuild.append("params").append("=").append(paramDecrypt);
        String uriStr = uriBuild.toString();
        Uri uri = Uri.parse(uriStr);
        try {
            //预防传入到协议有问题导致闪退
            Intent intent = new Intent(Intent.ACTION_VIEW, uri);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * 请求支付
     *
     * @param context
     * @param kylinPay
     * @param callBack
     */
    public void requestPay(Context context, KylinPay kylinPay, KylinCallback callBack) {
        if (context == null || kylinPay == null || callBack == null) {
            return;
        }
        this.kylinCallback = callBack;
        String pay = JSONObject.toJSONString(kylinPay);
        common(context, Constant.KYLIN_PAY, pay);
    }


    /**
     * 请求授权登录
     *
     * @param context
     * @param kylinLogin
     * @param callBack
     */
    public void requestLogin(Context context, KylinLogin kylinLogin, KylinCallback callBack) {
        if (context == null || kylinLogin == null || callBack == null) {
            return;
        }
        this.kylinCallback = callBack;
        String login = JSONObject.toJSONString(kylinLogin);
        common(context, Constant.KYLIN_LOGIN, login);
    }

    /**
     * 请求授权登录
     *
     * @param context
     * @param kylinSign
     * @param callBack
     */
    public void requestSign(Context context, KylinSign kylinSign, KylinCallback callBack) {
        if (context == null || kylinSign == null || callBack == null) {
            return;
        }
        this.kylinCallback = callBack;
        String login = JSONObject.toJSONString(kylinSign);
        common(context, Constant.KYLIN_SIGN, login);
    }

    /**
     * 执行合约
     *
     * @param context
     * @param kylinContract
     * @param callBack
     */
    public void requestContract(Context context, KylinContract kylinContract, KylinCallback callBack) {
        if (context == null || kylinContract == null || callBack == null) {
            return;
        }
        this.kylinCallback = callBack;
        String contract = JSONObject.toJSONString(kylinContract);
        JSONObject jsonObject = JSON.parseObject(contract);

        JSONArray jsonArray = new JSONArray();
        List<String> actions = kylinContract.getActions();
        for (String action : actions) {
            JSONObject ac = JSON.parseObject(action);
            jsonArray.add(ac);
        }
        jsonObject.put("actions", jsonArray);
        common(context, Constant.KYLIN_CONTRACT, jsonObject.toJSONString());
    }

    public void callBack(Uri uri) {
        if (uri == null) {
            return;
        }
        String scheme = uri.getScheme();
        if (TextUtils.isEmpty(scheme)) {
            return;
        }
        Map<String, String> paramMap = new HashMap<>();
        String query = uri.getQuery();
        Callback callback = null;
        if (!TextUtils.isEmpty(query)) {
            String[] params = query.split("&");
            for (String param : params) {
                String[] key_Value = param.split("=");
                if (key_Value.length == 2) {
                    if ("params".equals(key_Value[0])) {
                        String decrypt = Utils.decodeToString(key_Value[1]);
                        if (!TextUtils.isEmpty(decrypt)) {
                            try {
                                callback = JSON.parseObject(decrypt, Callback.class);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                            paramMap.put(key_Value[0], decrypt);
                        }
                    } else {
                        paramMap.put(key_Value[0], key_Value[1]);
                    }
                }
            }
        }
        if (kylinCallback != null) {
            kylinCallback.callBack(paramMap, callback);
        }
    }
}
