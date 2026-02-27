<?php

namespace app\controller\v2;

use app\controller\Base;
use app\model\VipModel;
use app\model\VipLogModel;

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

    // GET /api/v2/vip/log
    public function log()
    {
        $page  = $this->request->get('page/d', 1);
        $limit = $this->request->get('limit/d', 10);
        if ($page  <= 0) $page  = 1;
        if ($limit <= 0) $limit = 10;
        if ($limit > 20) $limit = 20;

        $result = VipLogModel::getUserLog(intval($this->UserInfo->id), $page, $limit);
        return show(1, $result);
    }
}
