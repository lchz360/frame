<?php
namespace app\app\validate;

use think\Validate;

class Banner extends Validate
{
    protected $rule = [
        'id' => 'require'
    ];

    protected $message = [
        'id.require'  =>  'id不能为空',
    ];

    protected $scene = [
        'delete' => ['id'],//删
        'update' => ['id'],//改
        'store' => [''],//增
        'index' => [''],//查
    ];
}