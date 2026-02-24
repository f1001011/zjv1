<?php

namespace app\common\model;


use think\Model;

class WaresOrderModel extends Model
{
    public $name = 'common_wares_order';

   public static function page_list($where,$limit,$page,$order,$field='*')
{
    return self::alias('a')
        ->join('common_wares b', 'a.wares_id = b.id', 'left')
        ->where($where)
        ->field($field)
        ->order($order)
        ->paginate(['list_rows'=>$limit,'page'=>$page], false)->each(function($item, $key){
//            $item['head_img'] =  empty($item['head_img']) ? '':TC('image_url').$item['head_img'];
//            $item['status_text'] =  TC('image_url').$item['head_img'];
            $item->user_name = UserModel::where('id',$item->uid)->value('user_name');
            switch ($item['status']){
                case 0:$item['status_text'] = '下单';break;
                case 1:$item['status_text'] = '发货中';break;
                case 2:$item['status_text'] = '运输中';break;
                case 3:$item['status_text'] = '签收';break;
                case 4:$item['status_text'] = '拒签';break;
            }
            return $item;
        });
}

    public static function getOne($map = []){
       return self::where($map)->find();
    }

    public static function inserts($data){
       return self::insertGetId($data);
    }
}