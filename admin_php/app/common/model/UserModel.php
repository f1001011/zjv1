<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\facade\Db;
use think\Model;

class UserModel extends Model
{
    use TraitModel;

    public $name = 'common_user';

//    public function getPwdAttr($value)
//    {
//        return '';
//    }
//
//    public function getwithdrawPwdAttr($value)
//    {
//        return '';
//    }

    public static function page_list($where, $limit, $page, $date)
    {
        $map = self::whereMapUser();
        //时间查询存在
        if (empty($date)) {
            $res = self::alias('b')->where($where)->where($map)
                //->where(['a.status' => 1])
                ->join('common_admin a', 'b.market_uid = a.id', 'left')
                ->field('b.*,a.user_name admin')
                ->order('id desc');
        } else {
            $res = self::alias('b')
                ->where($where)
                ->where($map)
                ->whereBetweenTime('b.create_time', $date['start'], $date['end'])->where(['b.status' => 1])
                ->join('common_admin a', 'b.market_uid = a.id', 'left')
                ->field('b.*,a.user_name admin')
                ->order('id desc');
        }
        return $res->paginate(['list_rows' => $limit, 'page' => $page], false)
            ->each(function ($item, $key) {
                $item->tg_url_txt = tg_url().$item->invitation_code;
                $item->tg_url_google='';
                !empty($item->invitation_code) && $item->tg_url_google = captchaUrl($item->invitation_code);
                unset($item->withdraw_pwd);
                unset($item->pwd);
                $item->agent_id_1=self::where('id', $item->agent_id_1)->value('phone');
                $item->agent_id_2=self::where('id', $item->agent_id_2)->value('phone');
                $item->agent_id_3=self::where('id', $item->agent_id_3)->value('phone');
                $item->login_time=Db::name('common_home_token')->where('user_id', $item->id)->value('create_time');
            });
    }
    //代理商个人信息
    public static function page_one($limit,$page)
    {
//        $map = self::whereMap();
        //if (empty($map)) return false;
        $map = [];
        if (session('admin_user.agent')){
            $map['a.id'] = session('admin_user.id');
        }else{
            $map['a.type'] =1;
        }

        return self::alias('a')
            ->where($map)
            ->join('common_admin b', 'a.market_uid = b.id', 'left')
            ->field('a.*,b.user_name admin')
            ->paginate(['list_rows' => $limit, 'page' => $page], false)
            ->each(function ($item, $key) {
                $item->tg_url_txt = $_SERVER['REQUEST_SCHEME'] . '://' . randomkey(5) .'.'. config('ToConfig.app_tg.tg_url') . '?code=' . $item->invitation_code;
            });
    }

    public function info($id){
        return $this->find($id);
    }


    public function refuse_money($uid, $money){
        $this->where('id', $uid)->dec('money_freeze',$money)->dec('total_withdraw',$money)->inc('money_approve', $money)->update();
//        $this->where('id', $uid)->inc('total_withdraw', $money * -1);
    }

    public function refuse_team_money($uid, $money){
        $this->where('id', $uid)->inc('money_hire', $money)->update();
    }
    public function add_total_withdraw($uid, $money){
        $this->where('id', $uid)->inc('total_withdraw', $money)->update();
    }

    //直接删除
    public function del($id)
    {
        $find = $this->find($id);
        if (empty($find))
            return false;
        return $find->delete();
    }
}