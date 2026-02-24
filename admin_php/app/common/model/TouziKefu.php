<?php


namespace app\common\model;
use app\common\traites\TraitModel;
use think\Model;

class TouziKefu extends Model
{
    use TraitModel;
    public $name = 'common_kefu';

    public static function page_list($where,$limit,$page,$order)
    {
      $map=self::whereMap();
//        return self::alias('b')
//            ->field('b.*,a.user_name admin_name')
//            ->join('common_admin a', 'b.market_uid = a.id', 'left')
//            ->where($where)
//            ->where($map)
//            ->order($order)
//            ->paginate(['list_rows'=>$limit,'page'=>$page], false);

        return self::where($where)
            ->where($map)
            ->order($order)
            ->paginate(['list_rows'=>$limit,'page'=>$page], false);
    }

}