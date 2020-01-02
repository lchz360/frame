<?php
/**
 * Created by PhpStorm.
 * Auth: Administrator
 * Date: 2019-05-11
 * Time: 16:54
 */

namespace app\app\model;


use Generate\Traits\Model\Cache;
use think\Model;
use traits\model\SoftDelete;

class User extends Model
{
    protected $hidden = ['password'];
    use SoftDelete;
    protected $deleteTime = 'delete_time';
    // 自动维护时间戳
    protected $autoWriteTimestamp = true;

    public function setPasswordAttr($val)
    {
        return password_hash($val,PASSWORD_DEFAULT);
    }
    public function setDealPasswordAttr($val)
    {
        return password_hash($val,PASSWORD_DEFAULT);
    }
}