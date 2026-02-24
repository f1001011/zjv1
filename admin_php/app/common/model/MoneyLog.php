<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class MoneyLog extends Model
{
    public $name = 'common_pay_money_log';
    use TraitModel;
    public function user()
    {
        return $this->hasOne(UserModel::class, 'id', 'uid');
    }

    public function getTypeAttr($value)
    {
         $type = [1 => '收入', 2 => '支出', 3 => '官方', 4 => '提现退款'];
//        $type = [1 => 'income', 2 => 'pay', 3 => 'Amount change', 4 => 'Withdrawal refund'];
        return isset($type[$value]) ? $type[$value] : $value;
    }

    public function getStatusAttr($value)
    {

        //详细类型 101充值  102 签到 103 用户每日收益 104 代理返佣  110 购买商品消费金额
        //  111 购买商品消耗积分 115 官方充值产品余额  116 获得可提现金额 120 获得积分，
        //121 获得绿币 122 股权  123碳票 201 提现 202 团队提现 205 官方减少产品余额 216 减少可提现金额
        $type = [
            101 => '充值',
            102 => '签到',
            103 => '用户每日收益',
            104 => '代理返佣',
            110 => '购买商品消费金额',
            111 => '购买商品消耗积分',
            115 => '官方充值产品余额',
            116 => '获得可提现金额',
            120 => '获得积分',
            121 => '获得绿币',
            122 => '获得股权',
            123 => '获得碳票',
            124 => '获得碳汇',
            201 => '提现',
            202 => '团队提现',
            205 => '减少产品余额',//官方
            216 => '减少可提现金额',//官方
            217=>'后台调整余额增加',
            218=>'后台调整余额减少',
            219=>'后台调整购买产品余额增加',
            220=>'后台调整购买产品余额减少',
            221=>'后台调整积分增加',
            222=>'后台调整积分减少',
            223=>'后台调整购买产品绿币增加',
            224=>'后台调整购买产品绿币减少',
            225=>'后台调整个人佣金增加',
            226=>'后台调整个人佣金减少',
            227=>'后台调整团队佣金增加',
            228=>'后台调整团队佣金减少',
            229=>'后台调整碳票增加',
            230=>'后台调整碳票减少',
            231=>'后台调整碳汇增加',
            232=>'后台调整碳汇减少',
            233=>'后台调整冻结金额增加',
            234=>'后台调整冻结金额减少',
            206=>'微信支付',
            207=>'支付宝支付',
            237 =>'提现拒绝',
            238 =>'团队提现拒绝',
        ];
//        217:218 (后台调整余额增加:减少)
//219:220  后台调整购买产品余额增加:减少
//221:222   后台调整购买产品积分增加:减少
//223:224   后台调整购买产品绿币增加:减少
//225:226   后台调整个人佣金增加:减少
//227:228   后台调整团队佣金增加:减少
//229:230   后台调整碳票增加:减少
//231:232   后台调整碳汇增加:减少
//233:234   后台调整冻结金额增加:减少
         return isset($type[$value]) ? $type[$value] : '管理调整';
    }
    public static function page_list($where,$limit,$page,$order)
    {
        $map=self::whereMap();
        return self::alias('a')
            ->where($where)
            ->where($map)
            ->join('common_user b', 'a.uid = b.id','left')
            ->join('common_admin c', 'a.market_uid = c.id','left')
            ->field('a.*,b.user_name,b.phone,b.nickname,c.user_name admin_name')
            ->order($order)
            ->paginate(['list_rows'=>$limit,'page'=>$page], false)->each(function($item, $key){
               if($item['money_before'] > $item['money_end']){
                   $item['money'] = '-'.$item['money'];
               }else{
                   $item['money'] =  '+'.$item['money'];
               }
            });
            return $item;
    }


    public static function inserts($type,$status,$money,$money_before,$money_end,$uid,$market_uid,$mark,$source_id){
        return self:: insertGetId([
            'create_time' => date('Y-m-d H:i:s'),
            'type' => $type,
            'status' => $status,
            'money_before' => $money_before,
            'money_end' => $money_end,
            'money' => $money,
            'uid' => $uid,
            'market_uid' => $market_uid,
            'source_id' => $source_id,
            'mark' => $mark,
        ]);
    }

}