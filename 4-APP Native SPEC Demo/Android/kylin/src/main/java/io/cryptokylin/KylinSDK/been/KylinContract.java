package io.cryptokylin.KylinSDK.been;

import java.util.List;

import io.cryptokylin.KylinSDK.Constant;

/**
 * 登录
 */
public class KylinContract {
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
     * 当前帐号
     */
    private String account;
    /**
     * 当前帐号对应的公钥地址，钱包会拿该地址对应的私钥进行签名
     */
    private String address;
    /**
     * 合约options，可选参数
     */
    private String options;
    /**
     * 当前标识该此次调用的ID，可选参数
     */
    private String actionid;
    /**
     * 其他信息，可用作钱包信息呈现，可选参数
     */
    private String msg;
    /**
     * 指定回调scheme
     */
    private String cb;
    /**
     * 合法的EOS action格式数据，具体格式见备注
     */
    //private String actions;
    private List<String> actions;

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

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOptions() {
        return options;
    }

    public void setOptions(String options) {
        this.options = options;
    }

    public String getActionid() {
        return actionid;
    }

    public void setActionid(String actionid) {
        this.actionid = actionid;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public List<String> getActions() {
        return actions;
    }

    public void setActions(List<String> actions) {
        this.actions = actions;
    }
}
