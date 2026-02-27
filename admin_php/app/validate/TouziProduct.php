<?php


declare (strict_types=1);

namespace app\validate;

use think\Validate;
class TouziProduct extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名' =>  ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'goods_type_id'=>'require|number',
        'goods_name'=>'require|max:200',
        'goods_money'=>'require|float',
        'project_scale'=>'require|float',
        'day_red'=>'require|float',
        'period'=>'require|number',
        'status'=>'require|number',
        'warrant'=>'require|max:200',
        'head_img'=>'require|max:200',
        'bottom_img'=>'require|max:200',
        'is_examine'=>'require|number',
        'sort'=>'number',
        'is_coupon'=>'require|number',
        'progress_rate'=>'require|float',
        'id'=>'require|number',
        'level_vip'=>'number',
        'buy_num'=>'number',
        'goods_agent_1'=>'require|float',
        'goods_agent_2'=>'require|float',
        'goods_agent_3'=>'require|float',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名' =>  '错误信息'
     *
     * @var array
     */
    protected $message = [
        'goods_type_id.require' => '分类ID必填',
        'goods_type_id.number' => '分类ID必须是数字',
        'goods_name' => '标题内容不能超过200字符',
        'goods_money' => '有效期必须是数字',
        'project_scale' => '每日分红必须',
        'period' => '投资周期必须',
        'status' => '上架状态',
        'warrant' => '担保公司',
        'head_img' => '封面图',
        'bottom_img' => '详情图',
        'is_examine' => '新手体验',
        'sort' => '商品排序',
        'is_coupon' => '优惠卷',
        'progress_rate' => '投资进度',
        'goods_agent_1' => '1级返佣',
        'goods_agent_2' => '2级返佣',
        'goods_agent_3' => '3级返佣',
        'buy_num' => '购买次数',
        'level_vip' => '限制vip等级',
    ];

    /**
     * 验证场景
     * @var \string[][]
     */
    protected $scene = [
        'edit' => ['level_vip','buy_num','goods_agent_1','goods_agent_2','goods_agent_3','progress_rate','goods_type_id','goods_name','goods_money','project_scale','period','status','warrant','head_img','bottom_img','is_examine','sort','is_coupon','id'],
        'add' => ['level_vip','buy_num','goods_agent_1','goods_agent_2','goods_agent_3','progress_rate','goods_type_id','goods_name','goods_money','project_scale','period','status','warrant','head_img','bottom_img','is_examine','sort','is_coupon'],
        'del' => ['id'],
    ];
}