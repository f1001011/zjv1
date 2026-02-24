<?php

namespace app\common\pay;

use app\common\model\MoneyLog;
use app\common\model\PayRecharge;
use app\common\model\SysConfig;
use app\common\model\UserModel;
use think\facade\Db;

class PayOrderv1
{
    //代收
    protected $key = 'cf934f8bb9e5423fac1aea924ba48564';
    protected $mchId = '100015171';//商户 ID
    protected $passageId = ''; //通道 ID
    protected $notifyUrl = '';//异步通知回调地址
    protected $callBackUrl = '';//充值成功回跳地址
    protected $payUrl = 'https://payment.dzxum.com/pay/web';

    public function __construct(){
        //查询商户号
        $SysConfig=new SysConfig();
        $this->callBackUrl  = $SysConfig->where('name','web_address')->value('value');
        $this->passageId = $SysConfig->where('name','passage_id')->value('value');
        $this->notifyUrl = $SysConfig->where('name','notify_url')->value('value');
    }

    public function createOrder($amount,$otherData)
    {//订单ID，订单编号，订单金额，订单用户 $otherData
        $data = [
            'version'=>'1.0',
            'mch_id'=>$this->mchId,
            'notify_url'=>$this->notifyUrl,
            'page_url'=>$this->callBackUrl,
            'mch_order_no'=>$otherData['order_on'],
            'pay_type'=>$this->passageId,//支付类型
            'trade_amount'=>$amount,
            'order_date'=>date('Y-m-d H:i:s'),
            'goods_name' =>'用户充值',
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
            $PayRecharge->where('id', $data['id'])->update(['status' => 1, 'success_time' => date('Y-m-d H:i:s'),'admin_uid'=>0,'platform_on'=>$data['trade_no']]);
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
