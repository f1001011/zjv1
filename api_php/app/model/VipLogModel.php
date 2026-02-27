<?php

namespace app\model;

class VipLogModel extends BaseModel
{
    public $name = 'common_vip_log';

    public static function getUserLog(int $userId, int $page, int $limit): array
    {
        $paginator = self::where('user_id', $userId)
            ->order('id desc')
            ->paginate(['list_rows' => $limit, 'page' => $page], false);

        $list = [];
        foreach ($paginator->items() as $row) {
            $list[] = [
                'id'        => (string) $row['id'],
                'sourceKey' => $row['remarks'] ?? 'task',
                'xp'        => intval($row['end_exp']) - intval($row['start_exp']),
                'createdAt' => $row['create_time'],
            ];
        }

        return [
            'list'    => $list,
            'hasMore' => $paginator->currentPage() < $paginator->lastPage(),
            'total'   => $paginator->total(),
        ];
    }
}
