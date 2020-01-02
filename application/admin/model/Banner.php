<?php
namespace app\admin\model;

use think\Cache;
use think\Model;
use traits\model\SoftDelete;


class Banner extends Model
{
    /**
     * 初始化
     */
    protected static function init()
    {
        $event_arr = ['afterWrite', 'afterDelete'];
        $model_name = self::getModel()->name;
        foreach ($event_arr as $k => $v) {
            self::{$v}(function ($model) use ($model_name) {
                Cache::clear($model_name . 'cache_data');
            });
        }
    }
    
    use SoftDelete;

    // 自动维护时间戳
    protected $autoWriteTimestamp = true;
    // 定义时间戳字段名
    protected $createTime = 'create_time';
    protected $updateTime = 'update_time';
}