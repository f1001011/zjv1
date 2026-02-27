// ── 后端真实类型 ───────────────────────────────────────────────────────────────
export interface GoodsType {
  id: number
  type_name: string
  status: number
  sort: number
}

export interface GoodsItem {
  id: number
  goods_type_id: number
  goods_name: string
  goods_money: number       // 起投金额
  project_scale: number     // 项目规模
  day_red: number           // 每日收益
  period: number            // 投资周期(天)
  status: number            // 0下架 1上架
  head_img: string | null   // 封面图
  is_examine: number        // 1=新手体验
  sort: number
  buy_num: number           // 0无限次
  level_vip: number
  progress_rate: number     // 已投金额（非百分比）
}

// ── 前端 Mock 兼容类型（Home.vue 等仍在使用）──────────────────────────────────
export interface CategoryItem {
  key: string
  labelZh: string
  labelEn: string
  iconKey: string
  colorKey: string
}

export interface ProductItem {
  id: number
  category: string
  name: string
  price: number
  maxPurchase: number
  tag: string
  iconKey: string
  imageUrl?: string
}

export interface BannerItem {
  id: number
  tag: string
  title: string
  sub: string
  gradient: string
  glow: string
  iconKey: string
  imageUrl?: string
}

export interface ProductListData {
  list: ProductItem[]
  total: number
  hasMore: boolean
}

export interface ProductListParams {
  category: string
  page: number
  pageSize: number
}

export interface HomeBalanceData {
  totalAssets: number
}
