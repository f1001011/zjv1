<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class welfare extends Model
{
    use TraitModel;
    public $name = 'common_welfare';

    public static function page_list($where,$limit, $page)
    {
        return self::alias('a')
            ->where($where)
            ->order('id desc')
            ->paginate(['list_rows'=>$limit,'page'=>$page])->each(function($item, $key){
                  $item->content = returnEditor($item->content);
                  $item->progress_content = returnEditor($item->progress_content);
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