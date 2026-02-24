<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class Notice extends Model
{
    use TraitModel;

    public $name = 'common_notice';
//    1 首页通知 3 弹出层公告  4系统通知 5最新活动 6 平台公告 7站内信
    public $positions =
        [
            1 => '首页',
            2 => '个人中心',
            3 => '弹出层公告',
            4 => '系统通知',
            5 => '最新活动',
            6 => '平台公告',
            7 => '站内信',
        ];

    public function getStatusAttr($value)
    {
        return $value;
        $type = [0 => '下架', 1 => '上架',];
        return isset($type[$value]) ? $type[$value] : $value;
    }

    public function getPositionAttr($value)
    {
        return $value;
        return isset($this->position[$value]) ? ['key'=>$value,'value'=>$this->position[$value]] : $value;
    }
    public static function page_list($where,$limit,$page)
    {


        return self::alias('a')
            ->where($where)
            ->order('id desc')
            ->paginate(['list_rows'=>$limit,'page'=>$page])->each(function($item, $key){
               $item->value = isset($item->positions[$item->position]) ? $item->positions[$item->position] : '';
            });
    }
    public function getContentAttr($value){
        if (empty($value)){
            return $value;
        }
        return htmlspecialchars_decode($value);
    }


}