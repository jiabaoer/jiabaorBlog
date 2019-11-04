package com.jiabaoer.utils;


import org.apache.shiro.crypto.hash.Md5Hash;

public class Md5Util {
    //密钥
    private static final String SALT = "12345.wei";

    /**
     * @param str 需要加密的字符
     * @return
     */
    public static String md5(String str) {
        return new Md5Hash(str, SALT).toString();
    }

}
