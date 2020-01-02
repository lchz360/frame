<?php

namespace app\admin\controller;

use think\Config;
use think\Controller;
use think\Session;

/**
 * Class Base
 * @package app\admin\controller
 * 基类控制器
 */
class Base extends Controller
{
    protected $pageSize;

    public function _initialize()
    {
        // 分页
        $configPageSize = Config::get("paginate.list_rows");
        $this->pageSize = $configPageSize;

        // 系统名称
        $siteName = getSettings("site", "siteName");
        $this->assign("sysName", $siteName);
    }

    /**
     * 验证是否登录
     * @return bool
     */
    protected function isLogin()
    {
        $uid = Session::get("uid", "admin");
        if (!$uid) {
            return false;
        }
        return true;
    }
}
