import axios from '@/utils/request';

export function getWaresListApi(data) {
    return axios.post({
            url: '/wares/list',
            data: data,
    }).then((res) => {
            return res
    })
}


export function waresEditApi(data) {
    return axios.post({
            url: '/wares/edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function waresAddApi(data) {
    return axios.post({
            url: '/wares/add',
            data: data,
    }).then((res) => {
            return res
    })
}

export function waresDelApi(data) {
    return axios.post({
            url: '/wares/del',
            data: data,
    }).then((res) => {
            return res
    })
}

export function exchangeListApi(data) {
    return axios.post({
            url: '/exchange/list',
            data: data,
    }).then((res) => {
            return res
    })
}

export function exchangeEditApi(data) {
    return axios.post({
            url: '/exchange/edit',
            data: data,
    }).then((res) => {
            return res
    })
}
