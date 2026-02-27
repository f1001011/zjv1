<?php
// 全局中间件定义文件
return [
    // CORS — must be first so OPTIONS preflight is handled before auth/routing
    // 多语言加载
    \think\middleware\LoadLangPack::class,
    // Session初始化
    \think\middleware\SessionInit::class,
];
