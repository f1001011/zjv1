<?php
declare (strict_types = 1);

namespace app\validate;

use think\Validate;

class Login extends Validate
{
    /**
     * 定义验证规则
     * 格式：'字段名' =>  ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'phone'  => 'require|min:7|max:25',
        'pwd'   => 'require|alphaNum|min:8|max:25',
        'upwd' => 'require|alphaNum|min:8|max:25',
        'user_name'=>'require|min:2|max:25',
        'sfz'=>'require|alphaNum|min:15|max:25',
        'agent_id'=>'require|integer',
        'captcha'=>'require|alphaNum|min:3|max:10',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名' =>  '错误信息'
     *
     * @var array
     */
    protected $message = [
        'phone' => '手机号错误',
        'pwd'     => '密码错误',
        'upwd'     => '重复密码错误',
        'user_name'     => '用户名错误',
        'sfz'     => '身份证错误',
        'agent_id'     => '推荐人ID错误',
        'captcha'     => '验证码错误',
        ];

    protected $scene = [
        'add'  =>  ['phone','pwd','sfz','upwd','user_name','agent_id','captcha'],
        'login'=>  ['phone','pwd','captcha'],
        'forget'=>  ['phone','pwd','captcha','sfz'],
        'insert'=>  ['phone','pwd','upwd','sfz','user_name','agent_id'],
    ];
}
