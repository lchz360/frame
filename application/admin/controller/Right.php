<?php
namespace app\admin\controller;

/**
 * main区域需要一个模板布局
 * Class Right
 * @package app\admin\controller
 */
class Right extends Signin
{
    public function _initialize()
    {
        parent::_initialize();
        $this->view->engine->layout('common/layout');
    }
}
