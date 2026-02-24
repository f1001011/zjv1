<?php

namespace app\command;

use app\model\UserModel;
use think\console\Command;
use think\facade\Cache;
use think\console\Input;
use think\console\Output;
use think\facade\Db;

class RealCmd extends Command
{
    protected function configure()
    {
        //已申请实名的用户进行实名认证
        //每10分钟一次
        $this->setName('real')
            ->setDescription('the real command');
    }

    protected function execute(Input $input, Output $output)
    {
        //查询已申请实名的用户
        $where = array();
        $where['is_real_name'] = 1;
        $result = UserModel::where($where)
            ->select()
            ->toArray();

        if (empty($result)) {
            $output->writeln('没有申请实名认证用户');
            return;
        }
        $pass_arr = array();
        $reject_arr = array();
        foreach ($result as $key => $value) {
            if($this->realIdCard($value['sfz'],$value['user_name'])){
                array_push($pass_arr,$value['id']);
            }else{
                array_push($reject_arr,$value['id']);
            }
        }
        Db::startTrans();
        try {
            if(!empty($pass_arr)){
                $arr = array();
                $arr[] = ['id','in',$pass_arr];
                UserModel::where($arr)->update(['is_real_name'=>2]);
            }
            if(!empty($reject_arr)){
                $arr = array();
                $arr[] = ['id','in',$reject_arr];
                UserModel::where($arr)->update(['is_real_name'=>3]);
            }
            Db::commit();
        } catch (\Exception $e) {
            // 回滚事务
            Db::rollback();
            dump($e->getMessage());
        }
        // 指令输出
        $output->writeln('real');
    }

    /**
     * 验证身份证是否正确
     * @param $id
     * @param $name
     * @return bool
     */
    private function realIdCard($id,$name){
        $arr = array();
        $arr['appId'] = config("realId.appid");
        $arr['cardCode'] = $id;
        $arr['cardName'] = $name;
        $sign = $this->obtainSign($arr);
        $arr['sign'] = $sign;
        $realIdToken=cache::get('real_idCard_token');
        if(empty($realIdToken)){
            $realIdToken = obtainToken();
        }
        $url = realIdCheck($realIdToken);
        $result = curl_request($url,json_encode($arr,JSON_UNESCAPED_UNICODE));
        if($result['code']==200&&$result['data']['fee']&&$result['data']['resultCode']==2000){
            return true;
        }
        return false;
    }

    /**
     * 获取身份验证token
     * @return mixed
     */
    private function obtainToken(){
        $url = realIdToken();
        $result = curl_request($url);
        if(isset($result['code']) && $result['code']==0){
            show(0, [], $result['msg']);
        }
        if(isset($result['error'])){
            show(0, [], $result['error_description']);
        }
        Cache::set('real_idCard_token',$result['access_token'],'84600');
        return $result['access_token'];
    }

    /**
     * 签名
     * @param $data
     * @return string
     */
    private function obtainSign($data){
        $str = implode('',$data);
        $str = $str.config("realId.secretKey");
        return md5($str);
    }
}