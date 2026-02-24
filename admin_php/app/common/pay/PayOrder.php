<?php

namespace app\common\pay;

use app\common\model\MoneyLog;
use app\common\model\PayRecharge;
use app\common\model\SysConfig;
use app\common\model\UserModel;
use think\facade\Db;

class PayOrder
{
    protected $key = '8e505f217bfe40648fa0007645a887c6';
    protected $mchId = '4v716586';//商户 ID
    protected $passageId = ''; //通道 ID
    protected $notifyUrl = '';//异步通知回调地址
    protected $callBackUrl = '';//充值成功回跳地址
    protected $payUrl = 'http://apis.rainbowpay.xyz/client/collect/create';

    public function __construct(){
        //查询商户号
        $SysConfig=new SysConfig();
        $this->callBackUrl  = $SysConfig->where('name','web_address')->value('value');
        $this->passageId = $SysConfig->where('name','passage_id')->value('value');
        $this->notifyUrl = $SysConfig->where('name','notify_url')->value('value');
    }

    //mchId	商户 ID	true	string
    //passageId	通道 ID	true	string
    //amount	金额（元）	true	number
    //orderNo	商户订单号	true	string
    //notifyUrl	异步通知回调地址	true	string
    //callBackUrl	充值成功回跳地址	false	string
    //otherData	扩展字段 支付中心回调时会原样返回	false	string
    //remark	备注	false	string
    //number	号码备注	false	string
    //sign	参数签名	true	string

    public function createOrder($amount,$otherData,$remark,$number)
    {//订单ID，订单编号，订单金额，订单用户 $otherData


        $data = [
            'mchId'=>$this->mchId,
            'passageId'=>$this->passageId,
            'amount'=>$amount,
            'orderNo'=>$otherData['order_on'],
            'notifyUrl'=>$this->notifyUrl,
            'callBackUrl'=>$this->callBackUrl,
            'otherData'=>json_encode($otherData),
            'remark'=>$remark,
            'number'=>$number,
        ];
        $data = array_filter($data);
        $data['sign'] = md5($this->sign($data));
        //请求 支付接口

        $res = curl_post($this->payUrl,$data);
         
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
            $PayRecharge->where('id', $data['id'])->update(['status' => 1, 'success_time' => date('Y-m-d H:i:s'),'platform_on'=>$data['trade_no']]);
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
