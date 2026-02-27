import axios from '@/utils/request';

export function getProductV2ListApi(data) {
    return axios.post({
            url: '/productv2/index',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productV2EditApi(data) {
    return axios.post({
            url: '/productv2/edit',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productV2AddApi(data) {
    return axios.post({
            url: '/productv2/add',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productV2DelApi(data) {
    return axios.post({
            url: '/productv2/del',
            data: data,
    }).then((res) => {
            return res
    })
}
