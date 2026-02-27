<?php

use think\facade\Route;

//Route::group(function () {});
Route::rule('login/index$', 'admin/Login/index');//登陆
Route::rule('login/captcha$', 'admin/Login/captcha');//验证码
Route::rule('login/captcha_check$', 'admin/Login/captcha_check');//验证码
Route::rule('login/agent$', 'admin/agentLogin/index');//服务商登陆

Route::rule('carry/v1$', 'admin/Login/carryv1');//v1回调 代付
Route::rule('carry/v2$', 'admin/Login/carryv2');//v1回调 代付

Route::rule('upload/image$', 'admin/UploadData/image');//上传图片
Route::rule('upload/video$', 'admin/UploadData/video');//都可以上传
Route::rule('upload/index$', 'admin/VideoFf/index');//都可以上传

Route::rule('/$', 'admin/Index/index');//后台首页
Route::rule('admin/list$', 'admin/Index/index');//后台用户列表
Route::rule('admin/add$', 'admin/Index/add');//后台用户添加

Route::rule('admin/edit$', 'admin/Index/edit');//后台用户修改
Route::rule('admin/detail$', 'admin/Index/detail');//后台用户信息查看
Route::rule('admin/del$', 'admin/Index/del');//后台用户删除

Route::rule('menu/list$', 'admin/auth.Menu/index');//后台菜单列表
Route::rule('menu/add$', 'admin/auth.Menu/add');//后台菜单添加
Route::rule('menu/edit$', 'admin/auth.Menu/edit');//后台菜单修改
Route::rule('menu/detail$', 'admin/auth.Menu/detail');//后台菜单修改
Route::rule('menu/del$', 'admin/auth.Menu/del');//后台菜单删除
Route::rule('menu/column$', 'admin/auth.Menu/lists');//后台表单列表
Route::rule('menu/status$', 'admin/auth.Menu/status');//后台表单列表

Route::rule('action/list$', 'admin/auth.Action/index');//后台控制列表
Route::rule('action/add$', 'admin/auth.Action/add');//后台控制列表
Route::rule('action/edit$', 'admin/auth.Action/edit');//后台控制列表
Route::rule('action/del$', 'admin/auth.Action/del');//后台控制列表
Route::rule('action/status$', 'admin/auth.Action/status');//后台控制列表
Route::rule('action/con$', 'admin/auth.Action/list_con');//后台控制显示
Route::rule('role/list$', 'admin/auth.Role/index');//角色列表
Route::rule('role/add$', 'admin/auth.Role/add');//角色列表add
Route::rule('role/edit$', 'admin/auth.Role/edit');//角色列表edit
Route::rule('role/del$', 'admin/auth.Role/del');//角色列表del
Route::rule('role/status$', 'admin/auth.Role/status');//角色列表

Route::rule('auth/action$', 'admin/auth.BranchAuth/action_list');//控制器列表
Route::rule('auth/action_edit$', 'admin/auth.BranchAuth/action_edit');//控制器列表
Route::rule('auth/menu$', 'admin/auth.BranchAuth/menu_list');//菜单列表
Route::rule('auth/menu_edit$', 'admin/auth.BranchAuth/menu_edit');//菜单列表

Route::rule('role_menu/list$', 'admin/auth.RoleMenu/index');//角色菜单列表分组
Route::rule('role_menu/add$', 'admin/auth.RoleMenu/add');//角色菜单列表添加
Route::rule('role_menu/edit$', 'admin/auth.RoleMenu/edit');//角色菜单列表

Route::rule('power/list$', 'admin/auth.RolePower/index');//角色 api接口列表
Route::rule('power/add$', 'admin/auth.RolePower/add');//角色 api接口列表
Route::rule('power/edit$', 'admin/auth.RolePower/edit');//角色 api接口列表

//Route::rule('agent/list$', 'admin/Agent/index');//代理列表
//Route::rule('agent/add$', 'admin/Agent/add');//代理添加
//Route::rule('agent/edit$', 'admin/Agent/edit');//代理修改
//Route::rule('agent/status$', 'admin/Agent/status');//代理状态修改

Route::rule('article_type/list$', 'admin/content.ArticleType/index');//文章分类
Route::rule('article_type/add$', 'admin/content.ArticleType/add');//文章分类
Route::rule('article_type/edit$', 'admin/content.ArticleType/edit');//文章分类
Route::rule('article_type/detail$', 'admin/content.ArticleType/detail');//文章分类
Route::rule('article_type/del$', 'admin/content.ArticleType/del');//文章分类


Route::rule('article/list$', 'admin/content.Article/index');//文章内容
Route::rule('article/add$', 'admin/content.Article/add');//文章内容
Route::rule('article/edit$', 'admin/content.Article/edit');//文章内容
Route::rule('article/detail$', 'admin/content.Article/detail');//文章内容
Route::rule('article/del$', 'admin/content.Article/del');//文章内容



Route::rule('login/log$', 'admin/log.LoginLog/index');//登陆日志
Route::rule('money/log$', 'admin/log.MoneyLog/index');//资金流动日志
Route::rule('examine/log$', 'admin/log.MoneyLog/examine');//审查余额

Route::rule('admin/log$', 'admin/log.AdminLog/index');//后台操作日志

Route::rule('pay/list$', 'admin/log.PayCash/index');//提现列表日志
Route::rule('pay/pass$', 'admin/log.PayCash/pass');//提现通过
Route::rule('pay/refuse$', 'admin/log.PayCash/refuse');//提现拒绝
Route::rule('pay/is_line$', 'admin/log.PayCash/is_line');//线上线下
Route::rule('pay/amount$', 'admin/log.PayCash/amount_edit');//修改金额

Route::rule('recharge/list$', 'admin/log.PayRecharge/index');//充值列表日志
Route::rule('recharge/status$', 'admin/log.PayRecharge/status');//确认充值
Route::rule('recharge/pass$', 'admin/log.PayRecharge/pass');//充值通过
Route::rule('recharge/refuse$', 'admin/log.PayRecharge/refuse');//充值拒绝

Route::rule('order/list$', 'admin/order.order/index');//订单列表
Route::rule('order/edit$', 'admin/order.order/edit');//订单状态

//兑换列表
Route::rule('exchange/list$', 'admin/Exchange/index');//兑换订单列表
Route::rule('exchange/edit$', 'admin/Exchange/edit');//兑换订单状态

Route::rule('notice/list$', 'admin/notice.Notice/index');//公告列表
Route::rule('notice/add$', 'admin/notice.Notice/add');//公告添加
Route::rule('notice/edit$', 'admin/notice.Notice/edit');//公告修改
Route::rule('notice/del$', 'admin/notice.Notice/del');//公告删除
Route::rule('notice/detail$', 'admin/notice.Notice/detail');//公告详情
Route::rule('notice/position$', 'admin/notice.Notice/position');//公告位置
Route::rule('notice/status$', 'admin/notice.Notice/status');//公告上下架

Route::rule('notify/list$', 'admin/notice.Notify/index');//通知列表
Route::rule('notify/add$', 'admin/notice.Notify/add');//通知添加
Route::rule('notify/edit$', 'admin/notice.Notify/edit');//通知修改
Route::rule('notify/del$', 'admin/notice.Notify/del');//通知删除
Route::rule('notify/detail$', 'admin/notice.Notify/detail');//通知详情
Route::rule('notify/status$', 'admin/notice.Notify/status');//通知上下架
Route::rule('notify/notify$', 'admin/notice.Notify/notifys');//通知类型

//邀请奖励设置
Route::rule('invitation/index$', 'admin/notice.Invitation/index');
Route::rule('invitation/add$', 'admin/notice.Invitation/add');
Route::rule('invitation/edit$', 'admin/notice.Invitation/edit');
Route::rule('invitation/status$', 'admin/notice.Invitation/statusEdit');


Route::rule('bank/list$', 'admin/PayBank/index');//银行卡列表
Route::rule('bank/del$', 'admin/PayBank/del');//银行卡删除
Route::rule('bank/default$', 'admin/PayBank/default');//银行卡修改默认卡

Route::rule('pay_bank/list$', 'admin/PayBank/index');//支付银行卡列表
Route::rule('pay_bank/del$', 'admin/PayBank/del');//支付银行卡删除
Route::rule('pay_bank/default$', 'admin/PayBank/default');//支付银行卡修改默认卡

Route::rule('config/list$', 'admin/SysConfig/index');//后台配置文件列表
Route::rule('config/add$', 'admin/SysConfig/add');//后台添加
Route::rule('config/edit$', 'admin/SysConfig/edit');//后台修改
Route::rule('config/detail$', 'admin/SysConfig/detail');//配置详情
Route::rule('config/del$', 'admin/SysConfig/del');//配置删除

Route::rule('ipconfig/list$', 'admin/IpConfig/index');//后台IP白名单
Route::rule('ipconfig/add$', 'admin/IpConfig/add');//IP白名单添加
Route::rule('ipconfig/edit$', 'admin/IpConfig/edit');//IP白名单修改
Route::rule('ipconfig/detail$', 'admin/IpConfig/detail');//IP白名单详情
Route::rule('ipconfig/del$', 'admin/IpConfig/del');//IP白名单删除
Route::rule('ipconfig/status$', 'admin/IpConfig/status');//IP白名单状态修改


Route::rule('user/is_status$', 'admin/User/is_status');//用户是否虚拟账号设置
Route::rule('user/list$', 'admin/User/index');//用户列表
Route::rule('user/agent$', 'admin/User/agent_data');//代理商信息
Route::rule('money/edit$', 'admin/User/money_edit');//用户余额修改
Route::rule('money/operate$', 'admin/User/operate');//用户操作密码验证



Route::rule('user/edit$', 'admin/User/edit');//用户修改
Route::rule('user/add$', 'admin/User/add');//
Route::rule('user/del$', 'admin/User/del');//
Route::rule('user/detail$', 'admin/User/detail');//用户详情
Route::rule('user/status$', 'admin/User/status');//用户状态修改
Route::rule('user/withdrawalstatus$', 'admin/User/withdrawalstatus');//用户状态修改
Route::rule('user/bankCard', 'admin/User/bankCard');//用户银行卡
Route::rule('user/bankCardEdit', 'admin/User/bankCardEdit');//用户银行卡编辑
Route::rule('userreal/list$', 'admin/RealName/index');//用户身份证列表
Route::rule('user/identity$', 'admin/User/isRealName');//用户身份状态修改



//注册统计
Route::rule('register/all$', 'admin/count.Register/index');//今日注册量与总注册列表
Route::rule('register/today$', 'admin/count.Register/today_register');//今日注册量
Route::rule('register/total$', 'admin/count.Register/total_register');//总注册

//充值统计
Route::rule('recharge/all$', 'admin/count.Recharge/index');//今日充值与总充值列表
Route::rule('recharge/today$', 'admin/count.Recharge/today_recharge');//今日充值
Route::rule('recharge/total$', 'admin/count.Recharge/total_recharge');//总充值

//提现统计
Route::rule('withdrawal/all$', 'admin/count.Withdrawal/index');//今日提现与总提现列表
Route::rule('withdrawal/today$', 'admin/count.Withdrawal/today_withdrawal');//今日提现
Route::rule('withdrawal/total$', 'admin/count.Withdrawal/total_withdrawal');//总提现

//订单统计
Route::rule('order/all$', 'admin/count.Order/index');//今日订单与总订单列表全部
Route::rule('order/today$', 'admin/count.Order/today_order');//今日订单全部
Route::rule('order/total$', 'admin/count.Order/total_order');//总订单全部
Route::rule('order/today_pay$', 'admin/count.Order/today_pay_order');//今日订单 已经支付的
Route::rule('order/total_pay$', 'admin/count.Order/total_pay_order');//总订单　已经支付的
Route::rule('order/today_money$', 'admin/count.Order/today_pay');//今日订单金额 已支付
Route::rule('order/total_money$', 'admin/count.Order/total_pay');//总订单金额  已支付


//google验证码生成器使用
Route::rule('google/qrcode$', 'admin/base/captcha_url');//二维码地址
Route::rule('google/secret$', 'admin/base/generate_code');//google secret

//台桌
Route::rule('desktop/index$', 'admin/desktop.desktop/index');
Route::rule('desktop/add$', 'admin/desktop.desktop/add');
Route::rule('desktop/edit$', 'admin/desktop.desktop/edit');
Route::rule('desktop/status$', 'admin/desktop.desktop/status');

//版本2
Route::rule('productv2/index$', 'admin/productv2.Goods/index');
Route::rule('productv2/add$', 'admin/productv2.Goods/add');
Route::rule('productv2/edit$', 'admin/productv2.Goods/edit');
Route::rule('productv2/del', 'admin/productv2.Goods/del');
//######
//产品添加
Route::rule('product/index$', 'admin/product.TouziProduct/index');
Route::rule('product/add$', 'admin/product.TouziProduct/add');
Route::rule('product/edit$', 'admin/product.TouziProduct/edit');
Route::rule('product/del', 'admin/product.TouziProduct/del');
Route::rule('product/sel', 'admin/product.TouziProduct/page_value_list');
//产品分类添加
Route::rule('product/class_index$', 'admin/product.TouziProductClass/index');
Route::rule('product/class_add$', 'admin/product.TouziProductClass/add');
Route::rule('product/class_edit$', 'admin/product.TouziProductClass/edit');
Route::rule('product/class_del$', 'admin/product.TouziProductClass/del');
//产品等级添加
Route::rule('product/lev_index$', 'admin/product.TouziProductLev/index');
Route::rule('product/lev_add$', 'admin/product.TouziProductLev/add');
Route::rule('product/lev_edit$', 'admin/product.TouziProductLev/edit');
Route::rule('product/lev_del$', 'admin/product.TouziProductLev/del');

//产品价格
Route::rule('product/money_index$', 'admin/product.TouziProductMoney/index');
Route::rule('product/money_add$', 'admin/product.TouziProductMoney/add');
Route::rule('product/money_edit$', 'admin/product.TouziProductMoney/edit');
Route::rule('product/money_del$', 'admin/product.TouziProductMoney/del');
//产品有效期添加
Route::rule('product/time_index$', 'admin/product.TouziProductTime/index');
Route::rule('product/time_add$', 'admin/product.TouziProductTime/add');
Route::rule('product/time_edit$', 'admin/product.TouziProductTime/edit');
Route::rule('product/time_del$', 'admin/product.TouziProductTime/del');

//用户产品订单
Route::rule('touzi_order/index$', 'admin/TouziProductOrder/index');

//轮播图
Route::rule('ads/index$', 'admin/TouziAds/index');
Route::rule('ads/add$', 'admin/TouziAds/add');
Route::rule('ads/edit$', 'admin/TouziAds/edit');
Route::rule('ads/del$', 'admin/TouziAds/del');

Route::rule('user/ranking$', 'admin/User/ranking');
Route::rule('index/statistics$', 'admin/Index/statistics');//统计

Route::rule('customer/index$', 'admin/TouziKefu/index');//客服
Route::rule('customer/add$', 'admin/TouziKefu/add');//客服
Route::rule('customer/edit$', 'admin/TouziKefu/edit');//客服
Route::rule('customer/del$', 'admin/TouziKefu/del');//客服


Route::rule('wares/list$', 'admin/product.wares/index');//兑换商品列表
Route::rule('wares/edit$', 'admin/product.wares/edit');//兑换商品修改
Route::rule('wares/add$', 'admin/product.wares/add');//兑换商品添加
Route::rule('wares/del$', 'admin/product.wares/del');//兑换商品删除


Route::rule('config/list$', 'admin/config.SysConfig/index');//系统配置列表
Route::rule('config/update$', 'admin/config.SysConfig/update');//系统配置修改

//公益文章
// Route::group('welfare',function(){
//     Route::rule('list$', 'admin/content.Welfare/list');//公益文章列表
//     Route::rule('add$', 'admin/content.Welfare/add');//公益文章新增
//     Route::rule('detail$', 'admin/content.Welfare/detail');//公益文章详情
//     Route::rule('edit$', 'admin/content.Welfare/edit');//公益文章编辑
//     Route::rule('grounding$', 'admin/content.Welfare/grounding');//公益文章上下架
//     Route::rule('del$', 'admin/content.Welfare/del');//公益文章删除
//     Route::rule('donateList$', 'admin/content.Welfare/donateList');//公益捐赠列表
// });

