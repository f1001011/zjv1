<?php

namespace app\common\model;

use app\common\traites\TraitModel;
use think\Model;

class SendLog extends Model
{
    use TraitModel;
    public $name = 'money_send_log';

    /**
     * 日志记录
     *@param number $user_id
     *@param number $amount
     *@param string $remark
     *@param string $user_name
     *@param number $is_send
     * */
    public static function inserts($user_id,$amount,$remark,$user_name,$is_send=1){
        $data['user_id']=$user_id;
        $data['product_id']= 0;
        $data['product_order_id']= 0;
        $data['user_name']=$user_name;
        $data['product_title']=$remark;
        $data['create_time']=date('Y-m-d H:i:s');
        $data['send_time']=date('Y-m-d H:i:s');
        $data['is_send']=$is_send;
        $data['send_money']=$amount;
        self::insert($data);
    }
}