import axios, { InternalAxiosRequestConfig } from 'axios'
import { usePopup } from '@/composables/usePopup'
import router from '@/router'

// 创建 axios 实例
const request = axios.create({
    baseURL: '/api',
    timeout: 5000
})

// 请求拦截器：自动带 token
request.interceptors.request.use(
    (config: InternalAxiosRequestConfig) => {
        const token = localStorage.getItem('token') || ''
        if (token) {
            config.headers.set('Authorization', `${token}`)
        } else {
            config.headers.delete('Authorization')
        }
        config.headers.set('time', Math.floor(Date.now() / 1000).toString())
        const locale = localStorage.getItem('app_locale') || 'zh'
        config.params = { ...config.params, lang: locale === 'zh' ? 'zh-cn' : 'en' }
        return config
    },
    error => Promise.reject(error)
)

// 响应拦截器：统一处理 code 1 / 0 / 204
request.interceptors.response.use(
    response => {
        const { code, data, msg } = response.data
        const { showPopup } = usePopup()

        // 成功
        if (code === 1) return data

        // token 过期
        if (code === 204) {
            localStorage.removeItem('token')
            showPopup(msg || 'Token 已过期，请重新登录', 'warning')
            router.push({ name: 'Login' })
            return Promise.reject(new Error(msg))
        }

        // 业务失败（code === 0 或其他）
        showPopup(msg || '请求失败', 'error')
        return Promise.reject(new Error(msg))
    },
    error => {
        const { showPopup } = usePopup()
        const msg = error.response?.data?.message || error.message || '网络异常，请稍后重试'
        showPopup(msg, 'error')
        return Promise.reject(error)
    }
)

export default request
