package com.jiabaoer.controller;

import com.jiabaoer.mapper.AlbumMapper;
import com.jiabaoer.mapper.BlogMapper;
import com.jiabaoer.mapper.BlogTypeMapper;
import com.jiabaoer.pojo.Friends;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.pojo.User;
import com.jiabaoer.service.FriendsService;
import com.jiabaoer.service.UserService;
import com.jiabaoer.utils.CodeUtil;
import com.jiabaoer.utils.EmailUtil;
import com.jiabaoer.utils.Md5Util;
import com.qq.connect.QQConnectException;
import com.qq.connect.api.OpenID;
import com.qq.connect.api.qzone.PageFans;
import com.qq.connect.api.qzone.UserInfo;
import com.qq.connect.javabeans.AccessToken;
import com.qq.connect.javabeans.qzone.PageFansBean;
import com.qq.connect.javabeans.qzone.UserInfoBean;
import com.qq.connect.javabeans.weibo.Company;
import com.qq.connect.oauth.Oauth;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class UserController {

    @Resource
    private UserService userServiceImpl;

    @Resource
    private BlogMapper blogMapper;

    @Resource
    private BlogTypeMapper blogTypeMapper;

    @Resource
    private AlbumMapper albumMapper;

    @Resource
    private FriendsService friendsServiceImpl;

    @RequestMapping("/admin/main")
    public String main() {
        return "/admin/main";
    }

    @RequestMapping("/login")
    public String login() {
        return "forward:login.jsp";
    }

    @RequestMapping("/register")
    public String register() {
        return "forward:register.jsp";
    }

    @RequestMapping("/music")
    public String music() {
        return "music";
    }

    @RequestMapping("/updPwd")
    public String updPwd() {
        return "forward:updPwd.jsp";
    }

    @RequestMapping("/about")
    public ModelAndView about() {
        long blogCount = blogMapper.selectBlogCount();
        long blogTypeCount = blogTypeMapper.selectBlogTypeCount();
        long albumCount = albumMapper.selectAlbumCount();
        User user = userServiceImpl.selUserInfo("jiabaoer");
        //查询所有友链
        List<Friends> friends = friendsServiceImpl.selectAllFriends();
        ModelAndView mdv = new ModelAndView("about");
        mdv.addObject("blogCount", blogCount);
        mdv.addObject("blogTypeCount", blogTypeCount);
        mdv.addObject("albumCount", albumCount);
        mdv.addObject("user", user);
        mdv.addObject("friends", friends);
        return mdv;
    }

    @RequestMapping("/error")
    public String error() {
        return "forward:error.jsp";
    }

    /**
     * 验证邮箱是否注册
     *
     * @param email
     * @return
     */
    @RequestMapping("/checkEmail")
    @ResponseBody
    public boolean checkEmail(@Param("email") String email) {
        int i = userServiceImpl.checkEmail(email);
        if (i > 0) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * 用户注册发送验证码
     *
     * @param email
     * @return
     */
    @RequestMapping("/registerCode")
    @ResponseBody
    public String registerCode(String email, HttpServletRequest request) {
        User user = userServiceImpl.userLogin(email);
        if (user == null) {
            String regCode = EmailUtil.achieveCode();  //生成随机密码
            new Thread(new EmailUtil(email, regCode)).start();
            HttpSession session = request.getSession();
            session.setAttribute("regCode", regCode);
            session.setMaxInactiveInterval(60);
            return "验证码已发送你的QQ邮箱！";
        } else {
            return "该邮箱已注册！";
        }
    }

    /**
     * 用户注册
     *
     * @param user
     * @return
     */
    @RequestMapping("/userRegister")
    @ResponseBody
    public String userRegister(User user, String vercode, HttpServletRequest request) {
        String sessionCode = request.getSession().getAttribute("regCode").toString();
        if (vercode.equalsIgnoreCase(sessionCode)) {
            user.setHeadPictrue("/img/头像.jpg");
            user.setUserType("acc8f963fe9d433eac407dfe400c8c50");
            user.setRoleId("29a67ec4ef0c4c7194e36c733894201d");
            user.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
            user.setPassword(Md5Util.md5(user.getPassword()));
            int i = userServiceImpl.userRegister(user);
            if (i > 0) {
                return "注册成功！";
            } else {
                return "注册失败！";
            }
        } else {
            return "验证码输入错误！";
        }

    }

    /**
     * 修改密码发送验证码
     *
     * @param email
     * @return
     */
    @RequestMapping("/updPasswordCode")
    @ResponseBody
    public String updPasswordCode(String email, HttpServletRequest request) {
        User user = userServiceImpl.userLogin(email);
        if (user != null) {
            String code = EmailUtil.achieveCode();  //生成随机密码
            new Thread(new EmailUtil(user.getEmail(), code)).start();
            HttpSession session = request.getSession();
            session.setAttribute("vCode", code);
            session.setMaxInactiveInterval(60);
            return "验证码已发送你的QQ邮箱！";
        } else {
            return "该邮箱尚未注册！";
        }
    }

    /**
     * 修改密码
     *
     * @param email
     * @param password
     * @param vercode
     * @return
     */
    @RequestMapping("/updPassword")
    @ResponseBody
    public String updPassword(String email, String password, String vercode, HttpServletRequest request) {
        if (vercode.equals(request.getSession().getAttribute("vCode"))) {
            int i = userServiceImpl.updPassword(email, Md5Util.md5(password));
            if (i > 0) {
                return "修改成功";
            } else {
                return "修改失败";
            }
        } else {
            return "验证码输入错误";
        }
    }


    /**
     * 生成验证码
     *
     * @param request
     * @param response
     */
    @RequestMapping("/getCode")
    public void getCode(HttpServletRequest request, HttpServletResponse response) {
        // 调用工具类生成的验证码和验证码图片
        Map<String, Object> codeMap = CodeUtil.generateCodeAndPic();
        // 将四位数字的验证码保存到Session中。
        HttpSession session = request.getSession();
        session.setAttribute("code", codeMap.get("code").toString());
        // 禁止图像缓存。
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", -1);
        response.setContentType("image/jpg");
        // 将图像输出到Servlet输出流中。
        ServletOutputStream sos;
        try {
            sos = response.getOutputStream();
            ImageIO.write((RenderedImage) codeMap.get("codePic"), "jpg", sos);
            sos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }


    /**
     * 用户登录
     *
     * @param email
     * @param password
     * @param vercode
     * @return
     */
    @RequestMapping("/userLogin")
    @ResponseBody
    public String userLogin(String email, String password, String vercode, HttpServletRequest request) {
        String sessionCode = request.getSession().getAttribute("code").toString();
        if (vercode.equalsIgnoreCase(sessionCode)) {
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(email, Md5Util.md5(password));
            try {
                subject.login(token); // 登录验证
                return "登录成功";
            } catch (LockedAccountException e) {
                return e.getMessage();
            } catch (Exception e) {
                e.printStackTrace();
                return "用户名或者密码错误！";
            }
        } else {
            return "验证码输入错误";
        }
    }

    /**
     * 查询个人信息
     *
     * @return
     */
    @RequestMapping("/user/selUserInfo")
    @ResponseBody
    public ModelAndView selUserInfo() {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        User user = userServiceImpl.selUserInfo(id);
        ModelAndView mdv = new ModelAndView("userInfo");
        mdv.addObject("user", user);
        return mdv;
    }

    /**
     * 修改个人信息
     *
     * @param user
     * @return
     */
    @RequestMapping("/user/updUserInfo")
    @ResponseBody
    public String updUserInfo(User user) {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        user.setId(id);
        int i = userServiceImpl.updUserInfo(user);
        if (i > 0) {
            List<Object> principals = new ArrayList<>();
            principals.add(user.getEmail());
            principals.add(user);
            PrincipalCollection principalCollection = SecurityUtils.getSubject().getPrincipals();
            String realmName = principalCollection.getRealmNames().iterator().next();
            PrincipalCollection newpPrincipalCollection = new SimplePrincipalCollection(principals, realmName);
            SecurityUtils.getSubject().runAs(newpPrincipalCollection);
            return "修改成功";
        } else {
            return "修改失败";
        }
    }

    /**
     * 文件上传
     *
     * @param request
     * @param file
     * @return
     * @throws IOException
     */
    @RequestMapping("/user/updHeadPictrue")
    @ResponseBody
    public String updHeadPictrue(@Param("file") MultipartFile file, HttpServletRequest request) throws IOException {
        String name = UUID.randomUUID().toString().replaceAll("-", "").substring(0,10);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String res = sdf.format(new Date());
        //设置图片上传路径
        String url = request.getServletContext().getRealPath("userHeadPicture");
        //设置新的文件名称
        String newFileName = res + name;
        //获取图片的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        file.transferTo(new File(url + "/" + newFileName + "." + ext));
        //完整的url
        String fileUrl = "/userHeadPicture/" + newFileName + "." + ext;
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> map1 = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "上传成功");
        map.put("data", map1);
        map1.put("src", fileUrl);
        map1.put("title", newFileName);
        String result = new JSONObject(map).toString();
        return result;
    }

    /**
     * 验证密码是否正确
     *
     * @param password
     * @return
     */
    @RequestMapping("/user/checkPassword/{password}")
    @ResponseBody
    public boolean checkPassword(@PathVariable("password") String password) {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        int i = userServiceImpl.checkPassword(id, Md5Util.md5(password));
        if (i > 0) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 修改密码
     *
     * @param newPassword
     * @return
     */
    @RequestMapping("/user/updPwd")
    @ResponseBody
    public String updPwd(String newPassword) {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        User user = userServiceImpl.updPwd(id, Md5Util.md5(newPassword));
        if (user != null) {
            List<Object> principals = new ArrayList<>();
            principals.add(user.getEmail());
            principals.add(user);
            PrincipalCollection principalCollection = SecurityUtils.getSubject().getPrincipals();
            String realmName = principalCollection.getRealmNames().iterator().next();
            PrincipalCollection newpPrincipalCollection = new SimplePrincipalCollection(principals, realmName);
            SecurityUtils.getSubject().runAs(newpPrincipalCollection);
            return "修改成功";
        } else {
            return "修改失败";
        }
    }

    /**
     * 查询所有的用户
     *
     * @return
     */
    @RequestMapping("/admin/userManager")
    public ModelAndView userManager(@RequestParam(defaultValue = "0") int pageSize, @RequestParam(defaultValue = "0") int pageNumber) {
        int pageSizeInit = 6;
        if (pageSize > 0) {
            pageSizeInit = pageSize;
        }
        int pageNumberInit = 1;
        if (pageNumber > 1) {
            pageNumberInit = pageNumber;
        }
        PageInfo pageInfo = userServiceImpl.userManager(pageSizeInit, pageNumberInit);
        ModelAndView mdv = new ModelAndView("admin/userManager");
        mdv.addObject("pageInfo", pageInfo);
        return mdv;
    }

    /**
     * 根据id删除用户
     *
     * @param ids
     * @return
     */
    @RequestMapping("/admin/delUser_ids/{ids}")
    @ResponseBody
    public String delUser_ids(@PathVariable("ids") String ids) {
        int id = 0;
        if (ids.contains("-")) {
            //批量删除
            List<String> delLeave_ids = new ArrayList<String>();
            String[] str_ids = ids.split("-");
            //组装id集合
            for (String str_id : str_ids) {
                delLeave_ids.add(str_id);
            }
            id = userServiceImpl.delUserByIdList(delLeave_ids);
        } else {
            //单个删除
            id = userServiceImpl.delUserById(ids);
        }
        if (id > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 发起请求
     *
     * @return
     */
    @RequestMapping(value = "/qqLogin")
    public void qqLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("text/html;charset=utf-8");
        try {
            response.sendRedirect(new Oauth().getAuthorizeURL(request));//将页面重定向到qq第三方的登录页面
        } catch (QQConnectException e) {
            e.printStackTrace();
        }
    }

    //获取登录者的基础信息
    @RequestMapping("/afterlogin")
    public void QQAfterlogin(HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("AfterLogin=======================================================");
        response.setContentType("text/html; charset=utf-8");  // 响应编码
        PrintWriter out = response.getWriter();

        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String parameterName = parameterNames.nextElement();//code
            System.out.println(parameterName + ":" + request.getParameter(parameterName));//state
        }
        System.out.println("qq_connect_state:" + request.getSession().getAttribute("qq_connect_state"));

        try {
            // 获取AccessToken(AccessToken用于获取OppendID)
            AccessToken accessTokenObj = (new Oauth()).getAccessTokenByRequest(request);

            System.out.println("accessTokenObj:" + accessTokenObj);
            // 用于接收AccessToken
            String accessToken = null,
                    openID = null;
            long tokenExpireIn = 0L; // AccessToken有效时长

            if (accessTokenObj.getAccessToken().equals("")) {
                //                我们的网站被CSRF攻击了或者用户取消了授权
                //                做一些数据统计工作
                System.out.print("没有获取到响应参数");
            } else {
                accessToken = accessTokenObj.getAccessToken();  // 获取AccessToken
                tokenExpireIn = accessTokenObj.getExpireIn();

                request.getSession().setAttribute("demo_access_token", accessToken);
                request.getSession().setAttribute("demo_token_expirein", String.valueOf(tokenExpireIn));

                // 利用获取到的accessToken 去获取当前用的openid -------- start
                OpenID openIDObj = new OpenID(accessToken);
                // 通过对象获取[OpendId]（OpendID用于获取QQ登录用户的信息）
                openID = openIDObj.getUserOpenID();

                out.println("欢迎你，代号为 " + openID + " 的用户!");
                request.getSession().setAttribute("demo_openid", openID);
                out.println("<a href=" + "/shuoshuoDemo.html" + " target=\"_blank\">去看看发表说说的demo吧</a>");
                // 利用获取到的accessToken 去获取当前用户的openid --------- end

                out.println("<p> start -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- start </p>");
                // 通过OpenID获取QQ用户登录信息对象(Oppen_ID代表着QQ用户的唯一标识)
                UserInfo qzoneUserInfo = new UserInfo(accessToken, openID);
                // 获取用户信息对象(只获取nickename与Gender)
                UserInfoBean userInfoBean = qzoneUserInfo.getUserInfo();
                out.println("<br/>");
                if (userInfoBean.getRet() == 0) {
                    out.println(userInfoBean.getNickname() + "<br/>");
                    out.println(userInfoBean.getGender() + "<br/>");
                    out.println("黄钻等级： " + userInfoBean.getLevel() + "<br/>");
                    out.println("会员 : " + userInfoBean.isVip() + "<br/>");
                    out.println("黄钻会员： " + userInfoBean.isYellowYearVip() + "<br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
                    out.println("<image src=" + userInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
                } else {
                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + userInfoBean.getMsg());
                }
                out.println("<p> end -----------------------------------利用获取到的accessToken,openid 去获取用户在Qzone的昵称等信息 ---------------------------- end </p>");


                out.println("<p> start ----------------------------------- 验证当前用户是否为认证空间的粉丝------------------------------------------------ start <p>");
                PageFans pageFansObj = new PageFans(accessToken, openID);
                PageFansBean pageFansBean = pageFansObj.checkPageFans("97700000");
                if (pageFansBean.getRet() == 0) {
                    out.println("<p>验证您" + (pageFansBean.isFans() ? "是" : "不是") + "QQ空间97700000官方认证空间的粉丝</p>");
                } else {
                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + pageFansBean.getMsg());
                }
                out.println("<p> end ----------------------------------- 验证当前用户是否为认证空间的粉丝------------------------------------------------ end <p>");


                out.println("<p> start -----------------------------------利用获取到的accessToken,openid 去获取用户在微博的昵称等信息 ---------------------------- start </p>");
                com.qq.connect.api.weibo.UserInfo weiboUserInfo = new com.qq.connect.api.weibo.UserInfo(accessToken, openID);
                com.qq.connect.javabeans.weibo.UserInfoBean weiboUserInfoBean = weiboUserInfo.getUserInfo();
                if (weiboUserInfoBean.getRet() == 0) {
                    //获取用户的微博头像----------------------start
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL30() + "/><br/>");
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL50() + "/><br/>");
                    out.println("<image src=" + weiboUserInfoBean.getAvatar().getAvatarURL100() + "/><br/>");
                    //获取用户的微博头像 ---------------------end

                    //获取用户的生日信息 --------------------start
                    out.println("<p>尊敬的用户，你的生日是： " + weiboUserInfoBean.getBirthday().getYear()
                            + "年" + weiboUserInfoBean.getBirthday().getMonth() + "月" +
                            weiboUserInfoBean.getBirthday().getDay() + "日");
                    //获取用户的生日信息 --------------------end

                    StringBuffer sb = new StringBuffer();
                    sb.append("<p>所在地:" + weiboUserInfoBean.getCountryCode() + "-" + weiboUserInfoBean.getProvinceCode() + "-" + weiboUserInfoBean.getCityCode()
                            + weiboUserInfoBean.getLocation());

                    //获取用户的公司信息---------------------------start
                    ArrayList<Company> companies = weiboUserInfoBean.getCompanies();
                    if (companies.size() > 0) {
                        //有公司信息
                        for (int i = 0, j = companies.size(); i < j; i++) {
                            sb.append("<p>曾服役过的公司：公司ID-" + companies.get(i).getID() + " 名称-" +
                                    companies.get(i).getCompanyName() + " 部门名称-" + companies.get(i).getDepartmentName() + " 开始工作年-" +
                                    companies.get(i).getBeginYear() + " 结束工作年-" + companies.get(i).getEndYear());
                        }
                    } else {
                        //没有公司信息
                    }
                    //获取用户的公司信息---------------------------end
                    out.println(sb.toString());
                } else {
                    out.println("很抱歉，我们没能正确获取到您的信息，原因是： " + weiboUserInfoBean.getMsg());
                }
                out.println("<p> end -----------------------------------利用获取到的accessToken,openid 去获取用户在微博的昵称等信息 ---------------------------- end </p>");
            }
        } catch (QQConnectException e) {
        }
    }
}
