## 文件目录

- Source
    - KylinManager //统一入口
    - Constant  //协议以及版本
    - KylinParseActivity  //接收协议回调页面
    - Utils  //加密，解密工具类
    - been //公有API
        - Callback  //通用的协议返回数据封装类
        - KylinCallback //返回接口
        - KylinContract //合约需要的参数封装
        - KylinLogin //登录授权需要的参数封装
        - KylinPay  //支付需要的参数封装
        - KylinSign //签名需要的参数封装
 
## 初始化
####1.引入KylinSDK module
         api project(':kylin')    
####2. 页面注册
      <activity android:name="io.cryptokylin.KylinSDK.KylinParseActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data android:scheme="自定义" />
            </intent-filter>
        </activity>
## API
####请求支付
    /**
     * 请求支付
     * @param context
     * @param kylinPay
     * @param callBack
     */
    public void requestPay(Context context, KylinPay kylinPay, KylinCallback callBack)
    
####请求授权登录
    /**
     * 请求授权登录
     *
     * @param context
     * @param kylinLogin
     * @param callBack
     */
    public void requestLogin(Context context, KylinLogin kylinLogin, KylinCallback callBack)
####请求签名
    /**
     * 请求签名
     * @param context
     * @param kylinSign
     * @param callBack
     */
    public void requestSign(Context context, KylinSign kylinSign, KylinCallback callBack) 
####请求执行合约
    /**
     * 执行合约
     *
     * @param context
     * @param kylinContract
     * @param callBack
     */
    public void requestContract(Context context, KylinContract kylinContract, KylinCallback callBack)
    
## DEMO
####请求支付
        KylinPay kylinPay = new KylinPay();
        kylinPay.setFrom("a账号"); //可选
        kylinPay.setTo("b账号");
        kylinPay.setTokenid("eos");
        kylinPay.setNum("0.0001");
        kylinPay.setMemo("test");
        kylinPay.setMsg("it is pay");
        // kylinPay.setActionid(); 可选
        // kylinPay.setUserid(); 可选
        kylinPay.setDappsymbol("dappone_c391d81c");
        //kylinPay.setAuthorization(""); 可选
        kylinPay.setCb("KylinDappDemo");
        KylinManager.getInstance().requestPay(context, kylinPay, new KylinCallback() {
            @Override
            public void callBack(Map<String, String> paramMap, Callback callBack) {
                Log.d("Kylin", paramMap.toString() + callBack);
            }
        }); 
####请求授权登录
        KylinLogin kylinLogin = new KylinLogin();
        kylinLogin.setTokenid("eos");
        kylinLogin.setDappsymbol("dappone_c391d81c");
        //kylinLogin.setAuthorization("");可选
        kylinLogin.setCb("KylinDappDemo");
        KylinManager.getInstance().requestLogin(context, kylinLogin, new KylinCallback() {
            @Override
            public void callBack(Map<String, String> paramMap, Callback callBack) {
                Log.d("Kylin", paramMap.toString() + callBack);
            }
        });
####请求签名
        KylinSign kylinSign = new KylinSign();
        kylinSign.setTokenid("eos");
        kylinSign.setAccountname("a账号");
        //kylinSign.setCustomdata("");可选
        kylinSign.setMsg("it is sign");
        kylinSign.setDappsymbol("dappone_c391d81c");
        // kylinSign.setAuthorization("");可选
        kylinSign.setCb("KylinDappDemo");
        KylinManager.getInstance().requestSign(context, kylinSign, new KylinCallback() {
            @Override
            public void callBack(Map<String, String> paramMap, Callback callBack) {
                Log.d("Kylin", paramMap.toString() + callBack);
            }
        });
####请求执行合约请求签名
        KylinContract kylinContract = new KylinContract();
        kylinContract.setTokenid("eos");
        kylinContract.setDappsymbol("dappone_c391d81c");
        // kylinContract.setAuthorization("");可选
        kylinContract.setAccount("a账号");
        kylinContract.setAddress("公钥地址");
        // kylinContract.setOptions("");可选
        //kylinContract.setActionid("");可选
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


