<?php

namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class BankModel extends Model
{
    use TraitModel;
    public $name = 'common_pay_sys_bank';

    public static function page_one($map = []){
        return self::where($map)->find();
    }

    /**
     * 列表
     * @param $map
     * @param $limit
     * @param $page
     * @return \think\Paginator
     * @throws \think\db\exception\DbException
     */
    public static function page_list($map = [],$limit,$page){

        return self::where($map)->paginate(['list_rows' => $limit, 'page' => $page]);
    }
    public static function insets($data = []){
        return self::insertGetId($data);
    }
}