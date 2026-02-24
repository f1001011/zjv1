<?php
// +----------------------------------------------------------------------
// | 控制台配置
// +----------------------------------------------------------------------
return [
    // 指令定义
    'commands' => [
        'rebate'=>\app\command\RebateCmd::class,
        'path'=>\app\command\UserAgentPath::class,
        'bonus'=>\app\command\BonusCmd::class,
        'hire'=>\app\command\HireCmd::class,
        'team'=>\app\command\TeamCmd::class,
        'real'=>\app\command\RealCmd::class,
    ],
];
