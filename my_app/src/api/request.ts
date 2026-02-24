import axios, { InternalAxiosRequestConfig } from 'axios'

// 创建 axios 实例
const request = axios.create({
    baseURL: 'http://www.v1.com', // 替换成你的接口
    timeout: 5000
})

// 请求拦截器：自动带 token，如果没有就不带
request.interceptors.request.use(
    (config: InternalAxiosRequestConfig) => {
        const token = localStorage.getItem('token') || ''
        if (token) {
            config.headers.set('Authorization', `${token}`)
        } else {
            config.headers.delete('Authorization')
        }
        return config
    },
    error => Promise.reject(error)
)

// 响应拦截器：统一处理返回
request.interceptors.response.use(
    response => response.data, // 只返回 data
    error => {
        // 统一处理错误，比如 token 过期、网络错误
        console.error('Request error:', error)
        return Promise.reject(error)
    }
)

export default request
