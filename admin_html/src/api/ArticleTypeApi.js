import axios from '@/utils/request';

export function getArticleTypeListApi(data) {
  return axios.post({
    url: '/article_type/list',
    data: data,
  }).then((res) => {
    return res
  })
}
export function getArticleTypeAddApi(data) {
  return axios.post({
    url: '/article_type/add',
    data: data,
  }).then((res) => {
    return res
  })
}


export function getArticleTypeDelApi(data) {
  return axios.post({
    url: '/article_type/del',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getArticleTypeDetailApi(data) {
  return axios.post({
    url: '/article_type/detail',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getArticleTypeEditApi(data) {
  return axios.post({
    url: '/article_type/edit',
    data: data,
  }).then((res) => {
    return res
  })
}

export function getArticleTypeStatusApi(data) {
  return axios.post({
    url: '/article_type/status',
    params: data
  }).then((res) => {
    return res
  })
}


export function getInvitationListApi(data) {
  return axios.post({
    url: '/invitation/index',
    data: data
  }).then((res) => {
    return res
  })
}

export function getInvitationAddApi(data) {
  return axios.post({
    url: '/invitation/add',
    data: data
  }).then((res) => {
    return res
  })
}

export function getInvitationEditApi(data) {
  return axios.post({
    url: '/invitation/edit',
    data: data
  }).then((res) => {
    return res
  })
}

export function getInvitationStatusApi(data) {
  return axios.post({
    url: '/invitation/status',
    data: data
  }).then((res) => {
    return res
  })
}
