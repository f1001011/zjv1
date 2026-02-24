import axios from '@/utils/request';

export function getUserListApi(data) {
  return axios.post({
    url: '/user/list',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getUserStatusApi(data) {
  return axios.post({
    url: '/user/status',
    data: data
  }).then((res) => {
    return res
  })
}

export function getUserWithdrawalStatusApi(data) {
  return axios.post({
    url: '/user/withdrawalstatus',
    data: data
  }).then((res) => {
    return res
  })
}

export function getIsWithdrawalStatusApi(data) {
  return axios.post({
    url: '/user/is_withdrawalstatus',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getUserDelApi(params) {
  return axios.post({
    url: '/user/del',
    data: params,
  }).then((res) => {
    return res
  })
}

export function getUserDetailApi(data) {
  return axios.post({
    url: '/user/detail',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getUserAddApi(data) {
  return axios.post({
    url: '/user/add',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getUserEditApi(data) {
  return axios.post({
    url: '/user/edit',
    data: data,
  }).then((res) => {
    return res
  })
}
export function getUserRealListApi(data) {
  return axios.post({
    url: '/userreal/list',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getMoneyEditApi(data) {
  return axios.post({
    url: '/money/edit',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getMoneyOperateApi(data) {
  return axios.post({
    url: '/money/operate',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getIsStatusApi(data) {
  return axios.post({
    url: '/user/is_status',
    data: data,
  }).then((res) => {
    return res
  })
}
export function getIsAgentApi(data) {
  return axios.post({
    url: '/user/agent',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getUserRankingApi(data) {
    return axios.post({
      url: '/user/ranking',
      data: data,
    }).then((res) => {
      return res
    })
  }

export function getDailiData() {
  return axios.post({
    url: '/user/agent',
  }).then((res) => {
    return res
  })
}

export function getactionCon() {
  return axios.post({
    url: '/action/con',
  }).then((res) => {
    return res
  })
}

export function getDaiLiShangData(data) {
  return axios.post({
    url: '/user/agent',
    data
  }).then((res) => {
    return res
  })
}

export function getIdentityEdit(data) {
  return axios.post({
    url: '/user/identity',
    data
  }).then((res) => {
    return res
  })
}

export function getBankCard(data) {
  return axios.post({
    url: '/user/bankCard',
    data
  }).then((res) => {
    return res
  })
}

export function getBankCardEdit(data) {
  return axios.post({
    url: '/user/bankCardEdit',
    data
  }).then((res) => {
    return res
  })
}

