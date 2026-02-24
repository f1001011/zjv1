<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class InvitationLog extends Model
{
    use TraitModel;
    public $name = 'money_invitation_log';
    public static function page_list($where,$limit,$page,$order)
    {
        // $map=self::whereMap();
        return self::where($where)
            //->where($map)
            ->order($order)
            ->paginate(['list_rows'=>$limit,'page'=>$page], false);
    }
}