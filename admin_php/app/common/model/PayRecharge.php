<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class PayRecharge extends Model
{
    public $name = 'common_pay_recharge';
    use TraitModel;
    public function getSuccessTimeAttr($value)
    {
        return empty($value) ? '未确认充值' : $value;
    }

    //确认充值
    public function setStatus($post)
    {
        $id = $post['id'];
        if ($id < 1) return false;

        return $this->update(
            ['id' => $id,
                'admin_uid' => session('admin_user.id'),
                'success_time' => date('Y-m-d H:i:s')
            ]);
    }

    public static function page_list($where,$limit, $page,$date)
    {
        $map=self::whereMap();
        //时间查询存在
        if (empty($date)) {
            $res = self::alias('a')
                ->where($where)
                 ->where($map)
                ->join('common_user b', 'a.uid = b.id', 'left')
                ->join('common_admin c', 'a.admin_uid = c.id', 'left')
                ->field('a.*,b.user_name,b.phone,b.nickname,c.user_name as admin_name')
                ->order('a.status asc,a.id desc');

        } else {
            $res = self::alias('a')
                ->where($where)
                ->whereBetweenTime('a.create_time', $date['start'], $date['end'])
                 ->where($map)
                ->join('common_user b', 'a.uid = b.id', 'left')
                ->join('common_admin c', 'a.admin_uid = c.id', 'left')
                ->field('a.*,b.user_name,b.phone,c.user_name as admin_name')
                  ->order('a.status asc,a.id desc');

        }
        return $res->paginate(['list_rows' => $limit, 'page' => $page], false);
    }

}