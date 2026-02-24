import axios from '@/utils/request';

export function getCustomListApi(data) {
    return axios.post({
            url: '/customer/index',
            data: data,
    }).then((res) => {
            return res
    })
}


export function customEditApi(data) {
    return axios.post({
            url: '/customer/edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function customAddApi(data) {
    return axios.post({
            url: '/customer/add',
            data: data,
    }).then((res) => {
            return res
    })
}

export function customDelApi(data) {
    return axios.post({
        url: '/customer/del',
        data: data,
    }).then((res) => {
        return res
    })
}




