package io.cryptokylin.KylinSDK.been;

import io.cryptokylin.KylinSDK.Constant;

/**
 * 登录
 */
public class KylinLogin {
    /**
     * kylinv1, 协议版本
     */
    private String v = Constant.SDK_VERSION;;
    /**
     * 每个数字资产的唯一标识
     */
    private String tokenid;
    /**
     * DApp全网唯一的symbol字段
     */
    private String dappsymbol;
    /**
     * 认证，格式为 accesskey + ":" + signature
     */
    private String authorization;
    /**
     * 指定回调scheme
     */
    private String cb;

    public String getV() {
        return v;
    }

    public String getTokenid() {
        return tokenid;
    }

    public void setTokenid(String tokenid) {
        this.tokenid = tokenid;
    }

    public String getDappsymbol() {
        return dappsymbol;
    }

    public void setDappsymbol(String dappsymbol) {
        this.dappsymbol = dappsymbol;
    }

    public String getAuthorization() {
        return authorization;
    }

    public void setAuthorization(String authorization) {
        this.authorization = authorization;
    }

    public String getCb() {
        return cb;
    }

    public void setCb(String cb) {
        this.cb = cb;
    }
}
