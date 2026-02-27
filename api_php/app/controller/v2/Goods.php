<?php

namespace app\controller\v2;

use app\controller\Base;
use app\model\GoodsModel;
use app\model\GoodsTypeModel;

class Goods extends Base
{
    // 商品分类列表
    public function typeList()
    {
        $where = [
            ['status', '=', 1],
        ];
        $list = GoodsTypeModel::page_list($where, 'id,type_name,sort');
        return show(1, $list);
    }

    // 商品列表（分页）
    public function goodsList()
    {
        $tid = $this->request->get('tid/d', 0);
        $map = [
            ['status', '=', 1],
            ['del', '=', 0],
        ];

        if ($tid > 0) {
            $map[]=['goods_type_id', '=', $tid];
        }

        $page  = $this->request->get('page/d', 1);
        $limit = $this->request->get('limit/d', 10);
        if ($page  <= 0) $page  = 1;
        if ($limit <= 0) $limit = 10;
        if ($limit > 20) $limit = 20;

        $list = GoodsModel::page_list($map, $limit, $page, 'sort desc')
            ->hidden(['del', 'goods_agent_1', 'goods_agent_2', 'goods_agent_3', 'goods_day_red'])
            ->toArray();

        return show(1, $list);
    }

    // 商品详情
    public function goodsOne()
    {
        $id = $this->request->get('id/d', 0);
        if ($id <= 0) {
            return show(0, [], language(10057));
        }

        $one = GoodsModel::getOne([['id', '=', $id], ['del', '=', 0]]);
        if (empty($one)) {
            return show(0, [], language(10058));
        }

        return show(1, $one);
    }
}
