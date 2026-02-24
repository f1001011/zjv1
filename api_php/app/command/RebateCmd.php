<?php
declare (strict_types=1);

namespace app\command;

use app\model\FanYongModel;
use app\model\GoodsOrderModel;
use app\model\MoneyLogModel;
use app\model\SysConfigModel;
use app\model\UserModel;
use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;
use think\facade\Db;

class RebateCmd extends Command
{
    protected function configure()
    {
        // 返佣计划任务 指令配置
        //每10分钟一次
        $this->setName('rebate')
            ->setDescription('the rebate command');
    }

    protected function execute(Input $input, Output $output)
    {
        //1 用户购买了商品。返佣金给 3级代理
        //$one = 0.21;
        //$two = 0.05;
        //$three = 0.02;

        $AgentHireOne = SysConfigModel::page_value([['name', '=', 'agent_hire_one']]);//一级返佣
        $AgentHireTow = SysConfigModel::page_value([['name', '=', 'agent_hire_tow']]);//二级
        $AgentHireThree = SysConfigModel::page_value([['name', '=', 'agent_hire_three']]);//三级
        $one = !empty($AgentHireOne) ? $AgentHireOne/100: 0.21;
        $two = !empty($AgentHireTow) ? $AgentHireTow/100: 0.05;
        $three = !empty($AgentHireThree) ? $AgentHireThree/100: 0.02;


        //查询没有返佣金的 订单
        $GoodsOrderInfo = GoodsOrderModel::where('status', 0)->select()->toArray();
        if (empty($GoodsOrderInfo)) {
            $output->writeln('没有可返佣订单');
            return;
        }

        $UserModel = new UserModel();


        foreach ($GoodsOrderInfo as $key => $value) {

            $UserInfo = [];
            $UserInfo = $UserModel->where('id', $value['uid'])->find();
            if (empty($UserInfo)) {
                continue;
            }

            $OneMoney = $TwoMoney = $ThreeMoney = 0;
            $AgentOne = $AgentTwo = $AgentThree = [];
            //用户信息存在，开始一级返佣
            //1 级获得返佣
            Db::startTrans();
            try {
                if ($UserInfo['agent_id'] > 0) {
                    $OneMoney = $value['order_money'] * $one;
                    //查询代理信息
                    $AgentOne = $UserModel->where('id', $UserInfo['agent_id'])->find();
                    if (!empty($AgentOne)) {
                        $UserModel->where('id', $UserInfo['agent_id'])->inc('money_hire', $OneMoney)->update();
                        //写入资金记录
                        MoneyLogModel::inserts(1, 104, $AgentOne['money_hire'], $AgentOne['money_hire'] + $OneMoney, $OneMoney, $AgentOne['id'], $UserInfo['market_uid'], '用户' . $UserInfo['user_name'] . ' 一级返佣购买'.$value['goods_name'].'返佣金', $value['id']);
                        FanYongModel::ToInsert($AgentOne['id'], $OneMoney, 1, '一级推返佣', 1, $UserInfo['user_name'] . '购买'.$value['goods_name'].'返佣金', $AgentOne['user_name'], date('Y-m-d H:i:s'), $value['id'], 0, $value['uid']);
                    }
                }

                //2 级获得返佣
                if ($UserInfo['agent_id_2'] > 0) {
                    $TwoMoney = $value['order_money'] * $two;
                    //查询代理信息
                    $AgentTwo = $UserModel->where('id', $UserInfo['agent_id_2'])->find();
                    if (!empty($AgentTwo)) {
                        $UserModel->where('id', $UserInfo['agent_id_2'])->inc('money_hire', $TwoMoney)->update();
                        //写入资金记录
                        MoneyLogModel::inserts(1, 104, $AgentTwo['money_hire'], $AgentTwo['money_hire'] + $TwoMoney, $TwoMoney, $AgentTwo['id'], $UserInfo['market_uid'], '用户' . $UserInfo['user_name'] . ' 二级返佣购买'.$value['goods_name'].'返佣金', $value['id']);
                        FanYongModel::ToInsert($AgentTwo['id'], $TwoMoney, 2, '二级推返佣', 1, $UserInfo['user_name'] . '购买'.$value['goods_name'].'返佣金', $AgentTwo['user_name'], date('Y-m-d H:i:s'), $value['id'], 0, $value['uid']);
                    }
                }

                //3 级获得返佣
                if ($UserInfo['agent_id_3'] > 0) {
                    $ThreeMoney = $value['order_money'] * $three;
                    //查询代理信息
                    $AgentThree = $UserModel->where('id', $UserInfo['agent_id_3'])->find();
                    if (!empty($AgentTwo)) {
                        $UserModel->where('id', $UserInfo['agent_id_3'])->inc('money_hire', $ThreeMoney)->update();
                        //写入资金记录
                        MoneyLogModel::inserts(1, 104, $AgentThree['money_hire'], $AgentThree['money_hire'] + $ThreeMoney, $ThreeMoney, $AgentThree['id'], $UserInfo['market_uid'], '用户' . $UserInfo['user_name'] . ' 三级返佣购买'.$value['goods_name'].'返佣金', $value['id']);
                        FanYongModel::ToInsert($AgentThree['id'], $ThreeMoney, 3, '三级推返佣', 1, $UserInfo['user_name'] . '购买'.$value['goods_name'].'返佣金', $AgentThree['user_name'], date('Y-m-d H:i:s'), $value['id'], 0, $value['uid']);
                    }
                }

                //返佣完成，订单改为已经获得返佣
                GoodsOrderModel::where('id', $value['id'])->update(['status' => 1]);
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                dump($e->getMessage());
            }
        }


        // 指令输出
        $output->writeln('rebate');
    }
}
