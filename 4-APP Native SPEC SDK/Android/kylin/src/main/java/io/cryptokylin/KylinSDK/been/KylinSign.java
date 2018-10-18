package io.cryptokylin.KylinSDK.been;

import io.cryptokylin.KylinSDK.Constant;

/**
 * 签名
 */
public class KylinSign {
    /**
     * kylinv1, 协议版本
     */
    private String v = Constant.SDK_VERSION;;
    /**
     * 每个数字资产的唯一标识
     */
    private String tokenid;
    /**
     * 提供签名的钱包账号在钱包系统中的userid。如eos中为其eos账号名，eth为公钥地址
     */
    private String accountname;
    /**
     * 自定义签名附加字段，可选参数
     */
    private String customdata;
    /**
     * 其他信息，可用作钱包信息呈现，可选参数
     */
    private String msg;
    /**
     * DApp全网唯一的symbol字段, 可选参数
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

    public String getAccountname() {
        return accountname;
    }

    public void setAccountname(String accountname) {
        this.accountname = accountname;
    }

    public String getCustomdata() {
        return customdata;
    }

    public void setCustomdata(String customdata) {
        this.customdata = customdata;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
