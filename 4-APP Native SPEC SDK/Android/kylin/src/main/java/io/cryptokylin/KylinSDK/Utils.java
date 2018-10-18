package io.cryptokylin.KylinSDK;

import android.util.Base64;

public class Utils {

    public static String encodeToString(String content) {
        try {
            return Base64.encodeToString(content.getBytes(), Base64.NO_WRAP);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public static String decodeToString(String encodedString) {
        try {
            return new String(Base64.decode(encodedString, Base64.NO_WRAP));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}
