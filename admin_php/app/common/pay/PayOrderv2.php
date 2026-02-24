<?php

namespace app\common\pay;

use app\common\model\MoneyLog;
use app\common\model\PayRecharge;
use app\common\model\SysConfig;
use app\common\model\UserModel;
use think\facade\Db;

class PayOrderv2
{
    public $key = 'c47af214f2a94c059ea4574678809bb3';
    public $merchant = '7o038392';//商户 ID
    public $payCode	='';//支付编码，商户后台查阅
    public $passageId = ''; //通道 ID
    public $notifyUrl = '';//异步通知回调地址
    public $callbackUrl = '';//充值成功回跳地址
    public $payUrl = 'http://apis.xdpay168.com/client/collect/create';

    public function __construct(){
        //查询商户号
        $SysConfig=new SysConfig();
        $this->callbackUrl   = $SysConfig->where('name','web_address')->value('value');
        $this->payCode = $SysConfig->where('name','passage_idv2')->value('value');
        $this->notifyUrl = $SysConfig->where('name','notify_urlv2')->value('value');
    }
    public function createOrder($amount,$otherData,$remark,$number)
    {//订单ID，订单编号，订单金额，订单用户 $otherData
        $data = [
            'merchant'=>$this->merchant,
            'payCode'=>$this->payCode,
            'amount'=>$amount,
            'orderId'=>$otherData['order_on'],
            'notifyUrl'=>$this->notifyUrl,
            'callbackUrl'=>$this->callbackUrl,
            'remark'=>$remark,
            'number'=>$number,
        ];
        $data = array_filter($data);
        $data['sign'] = md5($this->sign($data));
        //请求 支付接口
      
        $res = curl_post($this->payUrl,$data);
        return $res;
    }

    public function sign($data)
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
        return $strs.'&key='.$this->key;
    }

    //回调方法
    public function CallbackUrl($data){
        //订单编号，订单实际支付金额
        $PayRecharge=new PayRecharge();
        //查询订单信息
        $payInfo = $PayRecharge->where('order_on',$data['order_on'])->find();

        if (empty($payInfo)){
            return false;
        }
        $payInfo = $payInfo->toArray();
        if ($payInfo['status'] == 2){
            return false;
        }

        //查询用户信息
        $userInfo = UserModel::where('id',$payInfo['uid'])->find();

        if (empty($userInfo)){
            return false;
        }
        ;
        $userInfo = $userInfo->toArray();
        $data['id'] = $payInfo['id'];
        $data['uid'] = $payInfo['uid'];

        Db::startTrans();
        try {
            //修改订单状态
            $PayRecharge->where('id', $data['id'])->update(['status' => 1,'admin_uid'=>0, 'success_time' => date('Y-m-d H:i:s'),'platform_on'=>$data['trade_no']]);
            //增加用户金额
            UserModel::where('id', $payInfo['uid'])->inc('money_balance', $data['money'])->update();
            //写入资金记录
            MoneyLog::insert([
                'create_time' => date('Y-m-d H:i:s'),
                'type' => 1,
                'status' => 101,
                'money_before' => $userInfo['money_balance'],
                'money_end' => $userInfo['money_balance'] + $data['money'],
                'money' => $data['money'],
                'uid' => $payInfo['uid'],
                'source_id' => $payInfo['id'],
                'market_uid' => 0,
                'mark' => '支付回调,充值ID：' . $data['id'],
                'class' => 1,
            ]);
            Db::commit();
            return true;
        }catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            dump($e->getMessage());die;
            return false;
        }
    }

}


//商户登录号:208999
//登录密码：123456
//商户ID：3v813173
//商户后台登录地址：http://shanghu.rainbowpay.xyz
//API请求地址： http://apis.rainbowpay.xyz/client
//回调IP过白： 74.211.104.3    13.212.192.152   139.84.133.148
//对接文档地址: http://mch.rainbowpay.xyz/api/doc.html
//支付密钥(在商户后台可以看到)
//
//需要注意的地方登录就需要绑定谷歌验证码，妥善保管好
//测试通道编码：101，测试好了联系客服开启正式通道
//
//印度正式通道编码
//UPI：11001
//原生：11101
//代付：11002