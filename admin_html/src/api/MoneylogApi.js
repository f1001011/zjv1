import axios from '@/utils/request';

export function getMoneyListApi(data) {
  return axios.post({
    url: '/money/log',
       data: data,
  }).then((res) => {
    return res
  })
}

export function getPayListApi(data) {
  return axios.post({
    url: '/pay/list',
       data: data,
  }).then((res) => {
    return res
  })
}

export function ExcelPayListApi(data) {
  return axios.get({
    url: '/pay/list',
     data: data,
  }).then((res) => {
    return res
  })
}


export function gettPayStatusApi(data) {
  return axios.post({
    url: '/pay/status',
       data: data,
  }).then((res) => {
    return res
  })
}

export function getRechargeListApi(data) {
  return axios.post({
    url: '/recharge/list',
       data: data,
  }).then((res) => {
    return res
  })
}

export function getRechargeRefuseApi(data) {
    return axios.post({
      url: '/recharge/refuse',
         data: data,
    }).then((res) => {
      return res
    })
  }
export function getRechargePassApi(data) {
    return axios.post({
      url: '/recharge/pass',
         data: data,
    }).then((res) => {
      return res
    })
}

export function setPayRefuseApi(data) {
    return axios.post({
      url: '/pay/refuse',
         data: data,
    }).then((res) => {
      return res
    })
  }
  export function setPayPassApi(data) {
    return axios.post({
      url: '/pay/pass',
         data: data,
    }).then((res) => {
      return res
    })
  }
  export function setPayIsLineApi(data) {
    return axios.post({
      url: '/pay/is_line',
         data: data,
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

export function setUpdateMoney(data) {
  return axios.post({
    url: '/pay/amount',
    data: data,
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
export function getExamineData(data) {
  return axios.post({
    url: '/examine/log',
    data
  }).then((res) => {
    return res
  })
}




