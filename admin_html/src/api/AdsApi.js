import axios from '@/utils/request';

export function getAdsListApi(data) {
    return axios.post({
            url: '/ads/index',
            data: data,
    }).then((res) => {
            return res
    })
}


export function adsEditApi(data) {
    return axios.post({
            url: '/ads/edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function adsAddApi(data) {
    return axios.post({
            url: '/ads/add',
            data: data,
    }).then((res) => {
            return res
    })
}

export function adsDelApi(data) {
    return axios.post({
        url: '/ads/del',
        data: data,
    }).then((res) => {
        return res
    })
}




