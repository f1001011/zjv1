<?php

namespace app\common\pay;

use app\common\model\MoneyLog;
use app\common\model\PayCash;
use app\common\model\SysConfig;
use app\common\model\UserModel;
use think\facade\Db;

class CarryOrderv2
{
    //代付
    protected $key = 'c47af214f2a94c059ea4574678809bb3';
    protected $mchId = '7o038392';//商户 ID
    protected $passageId = ''; //通道 ID
    protected $notifyUrl = '';//异步通知回调地址
    protected $callBackUrl = '';//充值成功回跳地址
    protected $payUrl = 'http://apis.xdpay168.com/client/pay/create';

    public function __construct()
    {
        //查询商户号
        $SysConfig = new SysConfig();
        $this->callBackUrl = $SysConfig->where('name', 'web_address')->value('value');
        $this->passageId = $SysConfig->where('name', 'carry_passage_idv2')->value('value');
        $this->notifyUrl = $SysConfig->where('name', 'carry_notify_urlv2')->value('value');
    }

    public function createOrder($amount, $otherData, $account, $userName, $ifsc, $number)
    {//订单ID，订单编号，订单金额，订单用户 $otherData
        $data = [
            'merchant' => $this->mchId,
            'payCode' => $this->passageId,
            'amount' => $amount,
            'orderId' => $otherData['order_on'],
            'notifyUrl' => $this->notifyUrl,
            'bankAccount' => $account,
            'customName' => $userName,
            'remark' => $ifsc,
            'number' => $number,
        ];
        $data = array_filter($data);
        $data['sign'] = md5($this->sign($data));
        //请求 支付接口

        $res = curl_post($this->payUrl, $data);
        return $res;
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
