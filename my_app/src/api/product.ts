import request from './request'
import type { GoodsType, GoodsItem } from '@/types/product'

export const fetchGoodsTypes = (): Promise<GoodsType[]> =>
  request.get('/v2/goods/type_list')

export const fetchGoodsList = (tid: number, page = 1, limit = 10): Promise<GoodsItem[]> =>
  request.get('/v2/goods/list', { params: { tid, page, limit } })

export const fetchGoodsOne = (id: number): Promise<GoodsItem> =>
  request.get('/v2/goods/one', { params: { id } })
