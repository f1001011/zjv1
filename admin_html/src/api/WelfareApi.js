import axios from '@/utils/request';

export function getWelfareListApi(data) {
  return axios.post({
    url: '/welfare/list',
    params: data
  }).then((res) => {
    return res
  })
}

export function getWelfareEditApi(data) {
    return axios.post({
            url: '/welfare/edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function getWelfareAddApi(data) {
    return axios.post({
            url: '/welfare/add',
            data: data,
    }).then((res) => {
            return res
    })
}

export function getWelfareGroundingApi(data) {
    return axios.post({
            url: '/welfare/grounding',
            data: data,
    }).then((res) => {
            return res
    })
}

export function getWelfareDetailApi(data) {
    return axios.post({
            url: '/welfare/detail',
            data: data,
    }).then((res) => {
            return res
    })
}

export function getWelfareDelApi(data) {
    return axios.post({
            url: '/welfare/del',
            data: data,
    }).then((res) => {
            return res
    })
}
