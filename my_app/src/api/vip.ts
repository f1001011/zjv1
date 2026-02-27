import request from './request'
import type { VipInfo, XpRecord } from '@/types/vip'

export const fetchVipInfo = (): Promise<VipInfo> =>
  request.get('/v2/vip/info')

export const fetchVipXpHistory = (params: { page: number; pageSize: number }) =>
  request.get('/v2/vip/log', { params: { page: params.page, limit: params.pageSize } })
    .then((res: any) => ({
      list:    (res?.list ?? []) as XpRecord[],
      hasMore: res?.hasMore ?? false,
      total:   res?.total ?? 0,
    }))
