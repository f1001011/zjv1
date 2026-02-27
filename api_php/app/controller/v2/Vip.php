<?php

namespace app\controller\v2;

use app\controller\Base;
use app\model\VipModel;

class Vip extends Base
{
    public $UserInfo = '';

    public function initialize()
    {
        $this->UserInfo = $this->request->UserInfo;
        if (empty($this->UserInfo)) {
            show(204, [], language(10017))->send();
            exit;
        }
        parent::initialize();
    }

    // GET /api/v2/vip/info
    public function info()
    {
        $level     = intval($this->UserInfo->level_vip ?? 0);
        $currentXp = intval($this->UserInfo->current_experience ?? 0);

        // 查询下一级所需经验
        $maxLevel   = 9;
        $nextLevelXp = 0;
        if ($level < $maxLevel) {
            $nextLevelXp = VipModel::getLevelExp($level + 1);
        }

        // totalXp: 当前等级阈值 + 当前经验
        $currentLevelExp = VipModel::getLevelExp($level);
        $totalXp = $currentLevelExp + $currentXp;

        return show(1, [
            'level'       => $level,
            'currentXp'   => $currentXp,
            'nextLevelXp' => $nextLevelXp,
            'totalXp'     => $totalXp,
        ]);
    }

    // GET /api/v2/vip/log  (暂无 user_id 字段，返回空列表)
    public function log()
    {
        return show(1, [
            'list'    => [],
            'hasMore' => false,
            'total'   => 0,
        ]);
    }
}
