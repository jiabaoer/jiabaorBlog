package com.jiabaoer.utils;

import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.imageio.stream.ImageOutputStream;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class ImageEdit {
    /**
     * 直接给multipartFile加上文字水印再进行保存图片的操作方便省事
     *
     * @param multipartFile 文件上传的对象
     * @return
     * @throws IOException
     * @author 黄文贵
     * @version 2019年10月25日 上午11:15:56
     */
    public static MultipartFile addWorkMarkToMutipartFile(MultipartFile multipartFile,
                                                          String word) throws IOException {
        // 获取图片文件名 xxx.png xxx
        String originFileName = multipartFile.getOriginalFilename();
        // 获取原图片后缀 png
        int lastSplit = originFileName.lastIndexOf(".");
        String suffix = originFileName.substring(lastSplit + 1);
        // 获取图片原始信息
        String dOriginFileName = multipartFile.getOriginalFilename();
        String dContentType = multipartFile.getContentType();
        // 获取水印图片
        InputStream inputImg = multipartFile.getInputStream();
        Image img = ImageIO.read(inputImg);
        // 加图片水印
        int imgWidth = img.getWidth(null);
        int imgHeight = img.getHeight(null);

        BufferedImage bufImg = new BufferedImage(imgWidth, imgHeight,
                BufferedImage.TYPE_INT_RGB);
        //设置字体
        Font font = null;
        if (imgWidth < 200) {
            font = new Font("微软雅黑", Font.PLAIN, 10);
        } else if (imgWidth < 500) {
            font = new Font("微软雅黑", Font.PLAIN, 20);
        } else if (imgWidth < 800) {
            font = new Font("微软雅黑", Font.PLAIN, 30);
        } else if (imgWidth < 1200) {
            font = new Font("微软雅黑", Font.PLAIN, 50);
        } else if (imgWidth < 2000) {
            font = new Font("微软雅黑", Font.PLAIN, 100);
        }else{
            font = new Font("微软雅黑", Font.PLAIN, 200);
        }
        //调用画文字水印的方法
        markWord(bufImg, img, word, font, new Color(3, 169, 244), imgWidth, imgHeight);
        ByteArrayOutputStream bs = new ByteArrayOutputStream();
        ImageOutputStream imOut = ImageIO.createImageOutputStream(bs);
        ImageIO.write(bufImg, suffix, imOut);
        InputStream is = new ByteArrayInputStream(bs.toByteArray());

        // 加水印后的文件上传
        multipartFile = new MockMultipartFile(dOriginFileName, dOriginFileName, dContentType,
                is);
        //返回加了水印的上传对象
        return multipartFile;

    }

    /**
     * 加文字水印
     *
     * @param bufImg --BufferedImage  用来画图的宽高跟需要加水印的图片一样的空白图
     * @param img    --需要加水印的图片
     * @param text   --水印文字
     * @param font   --字体
     * @param color  --颜色
     * @param x      --水印相对于底片的x轴坐标(PS:左上角为(0,0))
     * @param y      --水印相对于底片的y轴坐标(PS:左上角为(0,0))
     * @author 黄文贵
     * @version 2019年10月25日 上午11:39:57
     */
    public static void markWord(BufferedImage bufImg, Image img, String text, Font font, Color color, int imgWidth, int imgHeight) {
        //取到画笔
        Graphics2D g = bufImg.createGraphics();
        //画底片
        g.drawImage(img, 0, 0, bufImg.getWidth(), bufImg.getHeight(), null);
        g.setColor(color);
        g.setFont(font);
        int x = imgWidth - getWatermarkLength(text, g);
        int y = imgHeight - 20;
        //位置
        g.drawString(text, x, y);
        g.dispose();
    }

    public static int getWatermarkLength(String waterMarkContent, Graphics2D g) {
        return g.getFontMetrics(g.getFont()).charsWidth(waterMarkContent.toCharArray(), 0, waterMarkContent.length());
    }

}
