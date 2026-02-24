<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class TouziFirstBuy extends Model
{
    use TraitModel;
    public $name = 'touzi_first_buy';
    /**
     * 记录
     * @param number $uid
     * @param number $agent_id_1
     * @param number $product_id
     * */
    public static  function record($uid,$agent_id_1,$product_id){
              $data['uid']=$uid;
              $data['agent_id_1']=$agent_id_1;
              $data['product_id']=$product_id;
              $data['add_time']=time();
              self::insert($data);
    }

}