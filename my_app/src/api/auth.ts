import request from './request'

export const loginByPhone = (data: { phone: string; pwd: string }) =>
  request.post('/login', data)

// ── 图形验证码（本地 mock，注册时前端自绘）────────────────────────────────────
const CAPTCHA_CHARS = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'
export const fetchCaptcha = (): Promise<{ captchaId: string; code: string }> =>
  new Promise(resolve =>
    setTimeout(() => {
      const code = Array.from({ length: 4 }, () =>
        CAPTCHA_CHARS[Math.floor(Math.random() * CAPTCHA_CHARS.length)]
      ).join('')
      resolve({ captchaId: `cap_${Date.now()}`, code })
    }, 80)
  )

export const register = (data: { phone: string; captcha: string; pwd: string; upwd: string; user_name?: string; agent_id?: string | number; sfz?: string }) =>
  request.post('/register', data)
