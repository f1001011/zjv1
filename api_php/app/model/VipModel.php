<?php

namespace app\model;

class VipModel extends BaseModel
{
    public $name = 'common_vip';

    // 获取指定等级的经验阈值
    public static function getLevelExp(int $level): int
    {
        $row = self::where('vip', $level)->find();
        return $row ? intval($row['experience']) : 0;
    }

    // 获取所有等级配置，按等级升序
    public static function getAllLevels(): array
    {
        return self::order('vip asc')->select()->toArray();
    }
}
