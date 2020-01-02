<?php
namespace app\admin\controller;

use think\db\exception\DataNotFoundException;
use think\db\exception\ModelNotFoundException;
use think\exception\DbException;
use think\Request;
use think\Session;
use think\Url;

/**
 * Class Login
 * 登录控制器
 */
class Login extends Base
{

    /**
     *  登录页面
     */
    public function index()
    {
        if ($this->isLogin()) {
            $this->redirect('index/index');
        }
        return $this->fetch();
    }

    /**
     * 登录操作验证
     * @param Request $request
     * @throws DataNotFoundException
     * @throws ModelNotFoundException
     * @throws DbException
     */
    public function login(Request $request)
    {
        if ($request->isPost()) {
            $captcha = $request->post("captcha");
            if (captcha_check($captcha)) {
                $account = $request->post("account");
                $password = $request->post("password");

                $ret = \app\admin\model\Admin::login($account, $password);

                if (1 == $ret['code']) {
                    // 登录成功
                    $this->success();
                } else {
                    $this->error($ret['msg']);
                }

            } else {
                $this->error("图片验证码输入错误！");
            }
        } else {
            $this->error("请求方式错误！");
        }
    }

    /**
     * 退出登录
     */
    public function logOut()
    {
        Session::set("uid", NULL, "admin");
        Session::set('uinfo', NULL, 'admin');
        $this->success("退出成功！", Url::build('/admin/login/index'));
    }
}