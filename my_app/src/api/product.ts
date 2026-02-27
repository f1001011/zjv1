import request from './request'
import type { GoodsType, GoodsItem } from '@/types/product'

export interface GoodsPage {
  total: number
  current_page: number
  last_page: number
  data: GoodsItem[]
}

export const fetchGoodsTypes = (): Promise<GoodsType[]> =>
  request.get('/v2/goods/type_list')

export const fetchGoodsList = (tid: number, page = 1, limit = 10): Promise<GoodsPage> =>
  request.get('/v2/goods/list', { params: { tid, page, limit } })

export const fetchGoodsOne = (id: number): Promise<GoodsItem> =>
  request.get('/v2/goods/one', { params: { id } })
