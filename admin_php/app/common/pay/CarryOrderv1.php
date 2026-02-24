<?php

namespace app\common\pay;

use app\common\model\MoneyLog;
use app\common\model\PayCash;
use app\common\model\PayRecharge;
use app\common\model\SysConfig;
use app\common\model\UserModel;
use think\facade\Db;

class CarryOrderv1
{
    //代收
    protected $key = 'cf934f8bb9e5423fac1aea924ba48564';
    protected $mchId = '100015171';//商户 ID
    protected $passageId = ''; //通道 ID
    protected $notifyUrl = '';//异步通知回调地址
    protected $callBackUrl = '';//充值成功回跳地址
    protected $payUrl = 'https://payment.dzxum.com/pay/web';

    public function __construct()
    {
        //查询商户号
        $SysConfig = new SysConfig();
        $this->callBackUrl = $SysConfig->where('name', 'web_address')->value('value');
        $this->passageId = $SysConfig->where('name', 'carry_passage_id')->value('value');
        $this->notifyUrl = $SysConfig->where('name', 'carry_notify_url')->value('value');
    }

    public function createOrder($amount, $otherData, $account, $userName, $ifsc, $number)
    {//订单ID，订单编号，订单金额，订单用户 $otherData
        $data = [
            'mch_id' => $this->mchId,
            'mch_transferId'=>$otherData['order_on'],
            'transfer_amount'=>$amount,
            'apply_date'=>date('Y-m-d H:i:s'),
            'bank_code'=>'DPT0001',
            'receive_name'=>$userName,
            'receive_account'=>$account,
            'remark'=>$ifsc,
            'back_url'=>$this->notifyUrl,
        ];
        $data = array_filter($data);
        $data['sign'] = md5($this->sign($data));
        $data['sign_type'] = 'MD5';

        //请求 支付接口
        $ch = curl_init();
        curl_setopt($ch,CURLOPT_URL,$this->payUrl); //支付请求地址
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        $response=curl_exec($ch);

        curl_close($ch);
        return $response;
    }

    //生成 sign
    protected function sign($data)
    {
        ksort($data);

        $str = '';
        foreach ($data as $k => $val) {
            //参数的值为空不参与签名；
            if ($val != '') {
                $str .= $k . '=' . $val . '&';
            }
        }
        $strs = rtrim($str, '&');
        return $strs . '&key=' . $this->key;
    }

    //回调方法
    public function CallbackUrl($data)
    {
        //订单编号，订单实际支付金额
        $PayCash = new PayCash();
        //查询订单信息
        $payInfo = $PayCash->where('order_on', $data['order_on'])->find();

        if (empty($payInfo)) {
            return false;
        }

        $payInfo = $payInfo->toArray();
        if ($payInfo['status'] != 0) {
            return false;
        }

        //查询用户信息
        $userInfo = UserModel::where('id', $payInfo['uid'])->find();

        if (empty($userInfo)) {
            return false;
        }

        $userInfo = $userInfo->toArray();

        $data['id'] = $payInfo['id'];
        $data['uid'] = $payInfo['uid'];
        $data['money'] = $payInfo['money'];
        $data['money_freeze'] = $userInfo['money_freeze'];

        Db::startTrans();
        try {
            //修改订单状态
            $PayCash->where('id', $data['id'])->update(['status' => 1, 'success_time' => date('Y-m-d H:i:s')]);
            //清除冻结金额
            UserModel::where('id', $data['uid'])->inc('money_total_withdraw',$data['money'])->update();//->dec('money_freeze', $data['money'])
            //写入资金记录
            MoneyLog::insert([
                'create_time' => date('Y-m-d H:i:s'),
                'type' => 2,
                'status' => 202,
                'money_before' => $userInfo['money_freeze'],
                'money_end' => $userInfo['money_freeze'] - $data['money'],
                'money' => $data['money'],
                'uid' => $payInfo['uid'],
                'source_id' => $payInfo['id'],
                'market_uid' => 0,
                'mark' => 'v2提现回调,提现ID：' . $data['id'] . ',操作冻结金额,用户清除冻结金额' . $data['money'] . ',原有冻结金额' . $data['money_freeze'],
                'class' => 1,
            ]);
            Db::commit();
            return true;
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            dump($e->getMessage());
            die;
            return false;
        }
    }


    //回调方法
    public function CallbackUrlRefuse($data)
    {
        //订单编号，订单实际支付金额
        $PayCash = new PayCash();
        //查询订单信息
        $payInfo = $PayCash->where('order_on', $data['order_on'])->find();

        if (empty($payInfo)) {
            return false;
        }

        $payInfo = $payInfo->toArray();
        if ($payInfo['status'] != 0) {
            return false;
        }

        //查询用户信息
        $userInfo = UserModel::where('id', $payInfo['uid'])->find();

        if (empty($userInfo)) {
            return false;
        }

        $userInfo = $userInfo->toArray();

        $data['id'] = $payInfo['id'];
        $data['uid'] = $payInfo['uid'];
        $data['money'] = $payInfo['money'];
        $data['money_freeze'] = $userInfo['money_freeze'];

        Db::startTrans();
        try {
            //修改订单状态
            $PayCash->where('id', $data['id'])->update(['status' => 1, 'success_time' => date('Y-m-d H:i:s')]);
            //清除冻结金额
            Db::name('common_user')->where('id',$userInfo['id'])->inc('money_balance',$data['money'])->update();
            \app\common\model\MoneyLog::flowing(1,1,1,101,$userInfo,$data['money'],$data['id'],'拒绝提现本地货币归还');
            Db::commit();
            return true;
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            dump($e->getMessage());
            die;
            return false;
        }
    }

}
