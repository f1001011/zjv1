<?php
declare (strict_types=1);

namespace app\command;

use app\model\GoodsDayModel;
use app\model\GoodsOrderModel;
use app\model\MoneyLogModel;
use app\model\UserModel;
use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;
use think\facade\Db;

class HireCmd extends Command
{
    protected function configure()
    {
        //已经分红完的订单进行处理成已完成指令配置，到期返回 用户可提金额
        //每3小时一次
        $this->setName('hire')
            ->setDescription('the hire command');
    }

    protected function execute(Input $input, Output $output)
    {

        //查询没有返可释放金额的订单
        $GoodsOrderInfo = GoodsOrderModel::where('status', 1)
            ->where('surplus_red_day', 0)
            ->select()
            ->toArray();

        if (empty($GoodsOrderInfo)) {
            $output->writeln('没有可完成订单');
            return;
        }

        foreach ($GoodsOrderInfo as $key => $value) {
            $DayInfo = [];
            //查询商品可提现金额
            Db::startTrans();
            try {
                $DayInfo = GoodsDayModel::where('id', $value['day_id'])->find();
                if (empty($DayInfo)) {
                    continue;
                }
                //释放可提现金额
                if ($DayInfo['withdrawable_money'] > 0) {
                    $UserInfo = UserModel::find($value['uid']);
                    if (empty($UserInfo)){
                        continue;
                    }
                    UserModel::inc('money_approve', $DayInfo['withdrawable_money'])->where('id',$UserInfo['id'])->update();
                    MoneyLogModel::inserts(1, 116, $UserInfo['money_approve'], $UserInfo['money_approve'] + $DayInfo['withdrawable_money'], $DayInfo['withdrawable_money'], $UserInfo['id'], $UserInfo['market_uid'], '释放可提现金额:' . $value['goods_name'], $value['id']);
                }
                GoodsOrderModel::where('id', $value['id'])->update(['status' => 2]);
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                dump($e->getMessage());
            }
        }
        // 指令输出
        $output->writeln('hire');
    }
}
