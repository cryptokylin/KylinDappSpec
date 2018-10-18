package io.cryptokylin.KylinSDK.been;

/**
 * 回调
 */
public class Callback {
    /**
     * 错误信息代码，0表示成功
     */
    private int code;
    /**
     * 其他信息
     */
    private String msg;
    /**
     * 处理请求的调用路径，比如 wallet/login/request
     */
    private String path;
    /**
     * e.g.wallet4bixin
     */
    private String platformid;
    /**
     * 将dapp发起请求时所携带的authorization参数原样返回做认证
     */
    private String authorization;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getPlatformid() {
        return platformid;
    }

    public void setPlatformid(String platformid) {
        this.platformid = platformid;
    }

    public String getAuthorization() {
        return authorization;
    }

    public void setAuthorization(String authorization) {
        this.authorization = authorization;
    }
}
