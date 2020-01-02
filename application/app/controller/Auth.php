<?php
/**
 * Created by PhpStorm.
 * Auth: Administrator
 * Date: 2019-05-11
 * Time: 16:53
 */

namespace app\app\controller;


use app\app\model\User as AuthModel;
use HXC\App\Common;
use QTSms\QTSms;
use think\Config;
use think\Controller;
use HXC\App\Auth as AuthTrait;
use think\exception\DbException;
use think\Request;

class Auth extends Controller
{
    use Common, AuthTrait;

    protected $username = 'name';//登录用户名，可选定user中的任意字段

    //登录方法login
    public function login(Request $request)
    {
        $params = $request->param();
        $params_status = $this->validate($params, 'Auth.login');
        if (true !== $params_status) {
            // 验证失败 输出错误信息
            return $this->returnFail($params_status);
        }
        $res = $this->validateLogin($params);
        $data = [];
        if ($res) {//登录成功
            $data = $res->toArray();
            if ($data["is_freeze"] == 1) {
                return $this->returnFail("账号已冻结，请联系管理员进行解封，联系方式：" . getSettings("admin_phone", "admin_phone"));
            }
            $token = $this->generateToken($data);
            $data['token'] = $token;
            $this->setAuth($data, $token);
        }
        return $this->returnRes($res, '登录失败:密码不正确', $data);
    }
//    public function login(Request $request)
//    {
//        $params = $request->param();
//        $patt = '/^1[3456789][0-9]{9}$/';
//        if (!preg_match($patt, $params['mobile'])) {
//            $this->returnFail('手机号码格式有误');
//        }
//        $user = AuthModel::get([$this->username => $params['mobile']]);
//        if (!$user) {
//            return $this->returnFail('该用户不存在');
//        }
//        $message = '验证码有误';
//        $sms_config = Config::get('sms');
//        $qt_sms = new QTSms($sms_config);
//        //验证
//        $res = $qt_sms->check($params['mobile'], $params['code'], 'login');
//        $res['code'] = 1;
//        if ($res['code']) {
//            $data = $user->toArray();
//            $token = urlencode($this->generateToken($data));
//            $data['token'] = $token;
//            $this->setAuth($data, $token);
//        } else {
//            return $this->returnFail($res['message']);
//        }
//        return $this->returnRes($res, "登录失败:{$message}", $data);
//    }

    //注册方法register
    public function register(Request $request)
    {
        $params = $request->param();
        $params_status = $this->validate($params, 'Auth.register');
        if (true !== $params_status) {
            // 验证失败 输出错误信息
            return $this->returnFail($params_status);
        }
        $status = AuthModel::where([$this->username => $params['username']])->find();
        if ($status) {
            return $this->returnFail('会员已存在');
        }
        $params[$this->username] = $params['username'];
        $message = '验证码有误';
        $sms_config = Config::get('sms');
        $qt_sms = new QTSms($sms_config);
        //验证
        $res = $qt_sms->check($params['username'], $params['code'], 'register');
        if ($res["code"]) {
            $auth = new AuthModel;
            $auth->data($params, true);
            $res = $auth->allowField(true)->save();
            if ($res) {
                //自增id
                $id = $auth->id;
                return $this->returnSuccess('账号创建成功');
            } else {
                return $this->returnFail('账号创建失败');
            }
        } else {
            return $this->returnFail($message);
        }

    }
    //找回密码resetPassword

    /**
     * 找回密码
     * @param Request $request
     * @return mixed
     * @throws DbException
     */
    public function resetPassword(Request $request)
    {
        $params = $request->param();
        $params_status = $this->validate($params, 'Auth.resetPassword');
        if (true !== $params_status) {
            // 验证失败 输出错误信息
            return $this->returnFail($params_status);
        }
        $id = $this->getAuthId();
        $user = AuthModel::get($id);
        if ($params['password'] == $params['old_password']) {
            return $this->returnFail("两次输入的密码不一致");
        }
        $save_status = $user->validate('Auth.edit')->allowField(true)->save([
            'password' => $params['password']
        ]);
        if (false === $save_status) {
            return $this->returnFail($user->getError());
        } else {
            return $this->returnSuccess();
        }
    }

    public function smscheck()
    {
        $params = \request()->param();
        if (empty($params["username"])) {
            return $this->returnFail("手机号不能为空");
        }
        if (empty($params["code"])) {
            return $this->returnFail("请输入验证码");
        }
        $sms_config = Config::get('sms');
        $qt_sms = new QTSms($sms_config);
        //验证
        $res = $qt_sms->check($params['username'], $params['code'], $params["scene"]);
        if ($res["code"]) {
            return $this->returnSuccess();
        } else {
            return $this->returnFail("验证码有误");
        }
    }
}