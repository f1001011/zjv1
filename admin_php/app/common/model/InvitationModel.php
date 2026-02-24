<?php


namespace app\common\model;


use app\common\traites\TraitModel;
use think\Model;

class InvitationModel extends Model
{
    use TraitModel;
    public $name = 'common_invitation';

    public static function page_list($limit,$page){
        return self::paginate(['list_rows' => $limit, 'page' => $page], false);
    }
}