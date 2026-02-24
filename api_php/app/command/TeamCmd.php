<?php
declare (strict_types = 1);

namespace app\command;

use app\model\AgentPath;
use app\model\UserModel;
use think\console\Command;
use think\console\Input;
use think\console\Output;

class TeamCmd extends Command
{
    protected function configure()
    {
        // 清理多余的 path表用户
        $this->setName('team')
            ->setDescription('the team command');
    }

    protected function execute(Input $input, Output $output)
    {

        //删除了用户之后需要运行，其他时候不需要
//        //1 查询有的用户
//
//        $user = AgentPath::select();
//
//        foreach ($user as $key=>$value){
//            //查询ID是否在  用户数据表
//           $find =  UserModel::where('id',$value['uid'])->find();
//            if (empty($find)){
//                AgentPath::where('id',$value['id'])->delete();
//                dump($value['id']);
//            }
//        }



        $output->writeln('rebate');
    }
}
