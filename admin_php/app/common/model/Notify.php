<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class Notify extends Model
{
    use TraitModel;

    public $name = 'common_notify';
    public $notifys = [1 => '全体', 2 => '私人'];

//    public function getStatusAttr($value)
//    {
//        $type = [0 => '下架', 1 => '上架',];
//        return isset($type[$value]) ? $type[$value] : $value;
//    }
//
//    public function getTypeAttr($value)
//    {
//        $type = [1 => '全体', 2 => '私人',];
//        return isset($type[$value]) ? $type[$value] : $value;
//    }
    public static function page_list($where,$limit,$page)
    {
        return self::alias('a')
            ->where($where)
            ->order('id desc')
            ->paginate(['list_rows'=>$limit,'page'=>$page])
            ->each(function($item, $key){
                if (empty($item->unique)) return '';
                //非空时进行分割
               $model = new UserModel();
                $nickname =$model->whereIn('id',$item->unique)->column('nickname');
                if (empty($nickname)) return '';
                $nickname= implode(',',$nickname);
                if (empty($nickname)) return '';
                $item->nickname=$nickname;
            });
    }
}