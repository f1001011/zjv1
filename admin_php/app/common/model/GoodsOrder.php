<?php


namespace app\common\model;
use app\common\traites\TraitModel;
use think\Model;

class GoodsOrder extends Model
{
    use TraitModel;
    public $name = 'common_goods_order';

    public static function page_list($where, $limit, $page, $date)
    {
         $map = self::whereMapUser();
        //时间查询存在
        if (empty($date)) {
            $res = self::alias('a')
              ->join('common_user b', 'a.uid = b.id', 'left')
                  ->where($where)
                ->where($map)
                //->where(['a.status' => 1])
                ->order('a.id desc');
        } else {
            $res = self::alias('a')
              ->join('common_user b', 'a.uid = b.id', 'left')
                ->where($where)
                ->where($map)
                ->whereBetweenTime('a.create_time', $date['start'], $date['end'])
                ->order('a.id desc');
        }
        return $res->field('a.*,b.phone')->paginate(['list_rows' => $limit, 'page' => $page], false)->each(function($item, $key){
            $item['status_text'] =  self::getStatus($item['red_way']);

            return $item;
        });
    }

    public static function getStatus($status){
        $str= '';
        switch ($status){
            case 0:$str = '正常';break;
            case 1:$str = '返佣完成，正在分红中';break;
            case 2:$str = '分红完成利息返回完成';break;
            case 3:$str = '本金返回完成，全部完成';break;
        }
        return $str;
    }
}