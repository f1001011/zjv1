import axios from '@/utils/request'

export function getVipListApi(data) {
    return axios.post({ url: '/vip/index', data: data }).then((res) => { return res })
}

export function addVipApi(data) {
    return axios.post({ url: '/vip/add', data: data }).then((res) => { return res })
}

export function editVipApi(data) {
    return axios.post({ url: '/vip/edit', data: data }).then((res) => { return res })
}

export function delVipApi(data) {
    return axios.post({ url: '/vip/del', data: data }).then((res) => { return res })
}
