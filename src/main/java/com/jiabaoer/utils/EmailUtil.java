package com.jiabaoer.utils;

import com.sun.mail.util.MailSSLSocketFactory;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Properties;

/**
 * 发送qq邮箱
 */
public class EmailUtil implements Runnable {
    private String email;// 收件人邮箱
    private String authCode;//验证码

    public EmailUtil(String email, String authCode) {
        this.email = email;
        this.authCode = authCode;
    }

    public void run() {
        // 1.创建连接对象javax.mail.Session
        // 2.创建邮件对象 javax.mail.Message
        // 3.发送一封激活邮件
        String from = "445282611@qq.com";// 发件人电子邮箱
        String host = "smtp.qq.com"; // 指定发送邮件的主机smtp.qq.com(QQ)|smtp.163.com(网易)

        Properties properties = System.getProperties();// 获取系统属性


        try {
            properties.setProperty("mail.smtp.host", host);// 设置邮件服务器
            properties.setProperty("mail.smtp.auth", "true");// 打开认证
            properties.setProperty("mail.transport.protocol", "smtp");//发送邮件协议名称
            //QQ邮箱需要下面这段代码，163邮箱不需要
            MailSSLSocketFactory sf = new MailSSLSocketFactory();
            sf.setTrustAllHosts(true);
            properties.put("mail.smtp.ssl.enable", "true");
            properties.put("mail.smtp.ssl.socketFactory", sf);


            // 1.获取默认session对象
            Session session = Session.getDefaultInstance(properties, new Authenticator() {
                public PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("445282611@qq.com", "zzamualkhukccbeg"); // 发件人邮箱账号、授权码
                }
            });
            // 2.创建邮件对象
            Message message = new MimeMessage(session);
            // 2.1设置发件人
            message.setFrom(new InternetAddress(from));
            // 2.2设置接收人
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            // 2.3设置邮件主题
            message.setSubject("jiabaoer博客验证码");
            // 2.4设置邮件内容
            String content = "<html>\n" +
                    "\t<body>\n" +
                    "\t\t<table width=\"100%\" height=\"200px\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"center\" style=\"background:\n" +
                    "\t\t linear-gradient(to right, rgb(48, 68, 191) 0%, rgb(197, 0, 252) 100%);color: white;\">\n" +
                    "\t\t\t<th>\n" +
                    "\t\t\t\tjiabaoer博客验证码\n" +
                    "\t\t\t</th>\n" +
                    "\t\t\t<tr>\n" +
                    "\t\t\t\t<td style=\"text-align: center;\">\n" +
                    "\t\t\t\t\t<ul>\n" +
                    "\t\t\t\t\t\t<li style=\"font-family: '微软雅黑';display: block;font-size: 20px; text-align: center;list-style: none;\">你的验证码为：" + authCode + "</li>\n" +
                    "\t\t\t\t\t</ul>\n" +
                    "\t\t\t\t</td>\n" +
                    "\t\t\t</tr>\n" +
                    "\t\t</table>\n" +
                    "\t</body>\n" +
                    "</html>";
            message.setContent(content, "text/html;charset=UTF-8");
            Transport transport = session.getTransport();
            transport.connect();
            // 3.发送邮件
            transport.send(message);
            transport.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 随机验证码
    public static String achieveCode() {
        String[] beforeShuffle = new String[]{"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"};
        List list = Arrays.asList(beforeShuffle);//将数组转换为集合
        Collections.shuffle(list);  //打乱集合顺序
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            sb.append(list.get(i)); //将集合转化为字符串
        }
        return sb.toString().substring(2, 6);  //截取字符串第4到8
    }
}
