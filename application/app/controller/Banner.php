<?php
namespace app\app\controller;

use think\Controller;
use think\Request;
use HXC\App\Common;
use HXC\App\Curd;

class Banner extends SignInController
{
    /**
    * 增删改查封装在Curd内，如需修改复制到控制器即可
    */
    use Common,Curd;
    
    protected $model = 'Banner';
    
    protected $validate = 'Banner'; 
    
    protected $with = '';//关联关系
    
    protected $cache = true;//是否开启缓存查询，仅对前台查询生效，通过模型方式进行增，改，删的操作，都会刷新缓存
    
    protected $order = '';

}