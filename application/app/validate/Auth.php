<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2019-05-13
 * Time: 13:56
 */

namespace app\app\validate;


use think\Validate;

class Auth extends Validate
{
    protected $rule = [
        'password'  =>  'require',
        'old_password' => 'require',
        'nickname' => 'require',
        'code' => 'require',
        'username' => 'require'
    ];

    protected $message = [
            'nickname.require'  =>  '昵称不能为空',
        'password.require'  =>  '密码不能为空',
        'old_password.require'  =>  '旧密码不能为空',
        'username.require'  =>  '用户名不能为空',
        'code.require'  =>  '请输入验证码',
    ];

    protected $scene = [
        'edit' => ['password'],
        'login' => ['username','password'],
        'register' => ['username','password','nickname','code'],
        'resetPassword' => ['password','old_password']
    ];
}