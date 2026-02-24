<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class FanyongLog extends Model
{
    use TraitModel;
    public $name = 'money_fanyong_log';
    /**
     * 日志记录
     *@param number $user_id
     *@param number $type
     *@param number $amount
     *@param string $remark
     *@param string $user_name
     *@param number $is_add_to_user_account
     * */
    public static function log($user_id,$type,$amount,$remark,$user_name,$is_add_to_user_account=1){
        $data['user_id']=$user_id;
        $data['money_type']=$type;
        $data['money_type_text']=fan_yong_type($type);
        $data['money_amount']=$amount;
        $data['user_name']=$user_name;
        $data['remark']=$remark;
        $data['create_time']=date('Y-m-d H:i:s');
        $data['update_time']=date('Y-m-d H:i:s');
        $data['is_add_to_user_account']=$is_add_to_user_account;
        self::insert($data);
    }
    /**
     * 查询
     * @param number $type
     * */
    public static function check_day($type){
        $res=self::where('money_type',$type)->where('create_time','>=',date('Y-m-d'))->find();
        if ($res){
            return false;
        }else{
            return true;
        }
    }

    public static function page_list($where,$limit, $page,$date)
    {
        $map=self::whereMap();
        if (empty($date)) {
            $res = self::alias('a')
                ->where($where)
                ->where($map)
                ->join('common_user b', 'a.user_id = b.id', 'left')
                ->field('a.*,b.user_name,b.phone,b.nickname')
                ->order('a.id desc');
        }else{
            $res =  self::alias('a')
                ->where($where)
                ->where($map)
                ->whereBetweenTime('a.create_time', $date['start'], $date['end'])
                ->join('common_user b', 'a.user_id = b.id', 'left')
                ->field('a.*,b.user_name,b.phone')
                ->order('a.id desc');
        }

        return $res->paginate(['list_rows' => $limit, 'page' => $page], false);
    }
}