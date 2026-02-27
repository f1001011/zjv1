<?php

namespace app\common\model;

use app\common\traites\TraitModel;
use think\Model;

class Vip extends Model
{
    use TraitModel;
    public $name = 'common_vip';

    public static function page_list($where, $limit, $page, $order = 'id asc')
    {
        return self::where($where)
            ->order($order)
            ->paginate(['list_rows' => $limit, 'page' => $page], false);
    }

    public static function getAll()
    {
        return self::order('vip asc')->select();
    }
}
