<?php
declare (strict_types=1);

namespace app\command;

use app\model\GoodsDayModel;
use app\model\GoodsMoneyModel;
use app\model\GoodsOrderModel;
use app\model\MoneyLogModel;
use app\model\SendModel;
use app\model\UserModel;
use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\facade\Db;

class BonusCmd extends Command
{
    protected function configure()
    {
        // 分红   指令配置
        //每20分钟一次
        $this->setName('bonus')
            ->setDescription('the bonus command');
    }

    protected function execute(Input $input, Output $output)
    {
        //1 用户购买商品 每日分红。
        //查询没有返佣金的 订单
        $GoodsOrderInfo = GoodsOrderModel::where('status', 1)
            ->order('next_red_date asc')
            ->whereTime('next_red_date', '<=', date('Y-m-d H:i:s'))
            ->where('surplus_red_day', '>', 0)
            ->select()
            ->toArray();
        if (empty($GoodsOrderInfo)) {
            $output->writeln('没有可分红订单');
            return;
        }

        foreach ($GoodsOrderInfo as $key => $value) {
            if ($value['surplus_red_day'] <= 0) {
                continue;
            }
            if ($value['surplus_red_money'] <= 0) {
                continue;
            }
            if ($value['status'] != 1) {
                continue;
            }

            Db::startTrans();
            try {

                // 1 获取每日应该分红的金额
                $DayInfo = [];
                $DayInfo = GoodsDayModel::getOne([['id', '=', $value['day_id']]]);
                if (empty($DayInfo)) {
                    continue;
                }

                //查询商品的购买价格
                $MoneyInfo = GoodsMoneyModel::getOne([['id', '=', $value['mid']]]);
                if (empty($MoneyInfo)) {
                    continue;
                }

                $make = "<{$value['goods_name']}>发放每日收益,投注价格:<{$MoneyInfo['money']}>投注天数:<{$DayInfo['project_day']}>每日收益:<{$DayInfo['income']}>";
                //计算应该获得的金额
                $money = 0;
                $money = $value['order_number'] * $DayInfo['income'];

                // 2 给用户加上分红金额，写资金记录。写分红记录
                $UserInfo = [];
                $UserInfo = UserModel::where('id', $value['uid'])->find();
                if (empty($UserInfo)) {
                    GoodsOrderModel::where('id', $value['id'])->update(['status'=>-1]);
                    Db::commit();
                    continue;
                }
                //用户分红余额,用户总获得的分红金额
                UserModel::where('id', $value['uid'])->inc('money_balance', $money)->inc('total_red', $money)->update();
                //写资金记录
                MoneyLogModel::inserts(1, 103, $UserInfo['money_balance'], $UserInfo['money_balance'] + $money, $money, $value['uid'], $UserInfo['market_uid'], $make, $value['id']);
                //写分红记录
                SendModel::insert([
                    'user_id' => $value['uid'],
                    'product_id' => $value['id'],
                    'product_order_id' => $value['id'],
                    'user_name' => $UserInfo['user_name'],
                    'product_title' => $value['goods_name'],
                    'create_time' => date('Y-m-d H:i:s'),
                    'send_time' => date('Y-m-d H:i:s'),
                    'is_send' => 1,
                    'send_money' => $money,
                ]);

                //3 数据回改，下次分红时间，已经分红天数，剩余分红天数，已经获得的分红金额，剩余获得的 分红金额，本次分红时间，
                GoodsOrderModel::where('id', $value['id'])
                    ->inc('already_red_money', $money)
                    ->dec('surplus_red_money', $money)
                    ->inc('already_red_day', 1)
                    ->dec('surplus_red_day', 1)
                    ->update([
                        'next_red_date' => date('Y-m-d H:i:s', strtotime($value['next_red_date']." 1 day")),
                        'last_red_date' => $value['next_red_date'],
                        'update_time' => date('Y-m-d H:i:s'),
                    ]);

                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                Db::rollback();
                dump($e->getMessage());
            }
        }
        // 指令输出
        $output->writeln('bonus');
    }
}
