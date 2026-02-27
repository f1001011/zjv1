<?php

namespace app\admin\controller\vip;

use app\admin\controller\Base;
use app\common\model\Vip as models;

class Vip extends Base
{
    protected $model;

    public function initialize()
    {
        $this->model = new models();
        parent::initialize();
    }

    // VIP等级列表
    public function index()
    {
        $page  = $this->request->post('page', 1);
        $limit = $this->request->post('limit', 20);
        $list  = $this->model->page_list([], $limit, $page);
        return $this->success($list);
    }

    // 新增
    public function add()
    {
        $post = $this->request->only(['vip', 'experience'], 'post', null);
        if (empty($post['vip']) && $post['vip'] !== '0') {
            return $this->failed('VIP等级不能为空');
        }
        if (!isset($post['experience'])) {
            return $this->failed('所需经验不能为空');
        }
        $exists = $this->model->where('vip', $post['vip'])->find();
        if ($exists) return $this->failed('该VIP等级已存在');

        $save = $this->model->save($post);
        if ($save) return $this->success([]);
        return $this->failed('添加失败');
    }

    // 编辑
    public function edit()
    {
        $post = $this->request->only(['id', 'vip', 'experience'], 'post', null);
        if (empty($post['id'])) return $this->failed('ID不能为空');

        $find = $this->model->where('id', $post['id'])->find();
        if (!$find) return $this->failed('记录不存在');

        $save = $this->model->update($post);
        if ($save) return $this->success([]);
        return $this->failed('修改失败');
    }

    // 删除
    public function del()
    {
        $id = $this->request->post('id', 0);
        if (!$id) return $this->failed('ID不能为空');

        $find = $this->model->where('id', $id)->find();
        if (!$find) return $this->failed('记录不存在');

        $del = $this->model->where('id', $id)->delete();
        if ($del) return $this->success([]);
        return $this->failed('删除失败');
    }
}
