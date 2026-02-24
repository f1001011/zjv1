<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class PayCash extends Model
{

    public $name = 'common_pay_cash';
    use TraitModel;
    public $status = [
        0 => '申请中', 1 => '已付款', 2 => '拒绝付款',
    ];

    public function setStatus($post)
    {
        $id = $post['id'];
        if ($id < 1) return false;
        if ($post['status'] == 1) return $this->update(['id' => $id, 'admin_uid'=>session('admin_user.id'),'status' => 1]);
        if ($post['status'] == 2) return $this->update(['id' => $id,'admin_uid'=>session('admin_user.id'), 'status' => 2,'msg'=>$post['msg']]);
        return false;
    }
    public static function page_list($where,$limit, $page,$date)
    {
        $map=self::whereMap();
        if (empty($date)) {
            $res = self::alias('a')
                ->where($where)
                ->where($map)
                ->join('common_user b', 'a.u_id = b.id', 'left')
                ->join('common_admin c', 'a.admin_uid = c.id', 'left')
                ->field('a.*,b.user_name,b.phone,b.nickname,c.user_name admin_name')
                  ->order('a.status asc,a.id desc');
        }else{
            $res =  self::alias('a')
                ->where($where)
                ->where($map)
                ->whereBetweenTime('a.create_time', $date['start'], $date['end'])
                ->join('common_user b', 'a.u_id = b.id', 'left')
                ->join('common_admin c', 'a.admin_uid = c.id', 'left')
                ->field('a.*,b.user_name,b.phone,c.user_name admin_name')
                  ->order('a.status asc,a.id desc');
        }

       return $res->paginate(['list_rows' => $limit, 'page' => $page], false)->each(function($item, $key){
               $status='';
                switch ($item['status']){
                    case 0:$status = '申请中';break;
                    case 1:$status = '提现成功';break;
                    case 2:$status = '拒绝提现';break;
                }
                $item->text =$status;
            });
    }


    public static function inserts($money,$money_balance,$money_fee,$money_actual,$msg,$u_id,$u_ip,$u_city,$admin_uid,$status,$pay_type,$u_bank_name,$u_back_card,$u_back_user_name,$market_uid,$trilateral_order,$success_time){
        self::insertGetId([
            'create_time'=>date('Y-m-d H:i:s'),
            'success_time'=>$success_time,
            'money'=>$money,
            'money_balance'=>$money_balance,
            'money_fee'=>$money_fee,
            'money_actual'=>$money_actual,
            'msg'=>$msg,
            'u_id'=>$u_id,
            'u_ip'=>$u_ip,
            'u_city'=>$u_city,
            'admin_uid'=>$admin_uid,
            'status'=>$status,
            'pay_type'=>$pay_type,
            'u_bank_name'=>$u_bank_name,
            'u_back_card'=>$u_back_card,
            'u_back_user_name'=>$u_back_user_name,
            'market_uid'=>$market_uid,
            'trilateral_order'=>$trilateral_order,
        ]);
    }
}