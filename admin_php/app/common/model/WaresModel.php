<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class WaresModel extends Model
{
    use TraitModel;
    public $name = 'common_wares';

    public static function page_list($where,$limit,$page,$order)
    {

        return self::where($where)
            //->where($map)
            ->order($order)
            ->paginate(['list_rows'=>$limit,'page'=>$page], false)->each(function($item, $key){
                $item['head_img'] =  config_image($item['head_img']);
                return $item;
            });
    }

    public function getContentAttr($value){
        if (empty($value)){
            return $value;
        }
        return htmlspecialchars_decode($value);
    }
    public function getProgressContentAttr($value){
        if (empty($value)){
            return $value;
        }
        return htmlspecialchars_decode($value);
    }
}