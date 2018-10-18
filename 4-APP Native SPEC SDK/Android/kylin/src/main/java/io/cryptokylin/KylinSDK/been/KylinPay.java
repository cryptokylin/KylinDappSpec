package io.cryptokylin.KylinSDK.been;

import io.cryptokylin.KylinSDK.Constant;

/**
 * 支付
 */
public class KylinPay {
    /**
     * 协议版本
     */
    private String v = Constant.SDK_VERSION;
    /**
     * 支付账户，可选参数
     */
    private String from;
    /**
     * 接收币的目的账户
     */
    private String to;
    /**
     * 每个数字资产的唯一标识
     */
    private String tokenid;
    /**
     * 支付数量
     */
    private String num;
    /**
     * 转账备注，可选参数
     */
    private String memo;
    /**
     * 其他信息，可用作钱包信息呈现，可选参数
     */
    private String msg;
    /**
     * 当前支付订单ID，可选参数
     */
    private String actionid;
    /**
     * 用户身份ID，可选参数
     */
    private String userid;
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

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getTokenid() {
        return tokenid;
    }

    public void setTokenid(String tokenid) {
        this.tokenid = tokenid;
    }

    public String getNum() {
        return num;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getActionid() {
        return actionid;
    }

    public void setActionid(String actionid) {
        this.actionid = actionid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
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
