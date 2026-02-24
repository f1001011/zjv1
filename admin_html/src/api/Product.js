import axios from '@/utils/request';

export function getProductListApi(data) {
    return axios.post({
            url: '/product/index',
            data: data,
    }).then((res) => {
            return res
    })
}


export function productEditApi(data) {
    return axios.post({
            url: '/product/edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productAddApi(data) {
    return axios.post({
            url: '/product/add',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productDelApi(data) {
    return axios.post({
            url: '/product/del',
            data: data,
    }).then((res) => {
            return res
    })
}

export function getProductClassListApi(data) {
    return axios.post({
            url: '/product/class_index',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productClassAddApi(data) {
    return axios.post({
            url: '/product/class_add',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productClassEditApi(data) {
    return axios.post({
            url: '/product/class_edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productClassDelApi(data) {
    return axios.post({
            url: '/product/class_del',
            data: data,
    }).then((res) => {
            return res
    })
}

export function getProductLevelListApi(data) {
    return axios.post({
            url: '/product/lev_index',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productLevelAddApi(data) {
    return axios.post({
            url: '/product/lev_add',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productLevelEditApi(data) {
    return axios.post({
            url: '/product/lev_edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productLevelDelApi(data) {
    return axios.post({
            url: '/product/lev_del',
            data: data,
    }).then((res) => {
            return res
    })
}


export function getProductTimeListApi(data) {
    return axios.post({
            url: '/product/time_index',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productTimeAddApi(data) {
    return axios.post({
            url: '/product/time_add',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productTimeEditApi(data) {
    return axios.post({
            url: '/product/time_edit',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productTimeDelApi(data) {
    return axios.post({
            url: '/product/time_del',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productSelApi(data) {
    return axios.post({
            url: '/product/sel',
            data: data,
    }).then((res) => {
            return res
    })
}


export function productMoneySelApi(data) {
    return axios.post({
            url: '/product/money_index',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productMoneyAddApi(data) {
    return axios.post({
            url: '/product/money_add',
            data: data,
    }).then((res) => {
            return res
    })
}
export function productMoneyEditApi(data) {
    return axios.post({
            url: '/product/money_edit',
            data: data,
    }).then((res) => {
            return res
    })
}

export function productMoneyDelApi(data) {
    return axios.post({
            url: '/product/money_del',
            data: data,
    }).then((res) => {
            return res
    })
}
