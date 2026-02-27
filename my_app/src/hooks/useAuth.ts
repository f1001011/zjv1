import { useRouter } from 'vue-router'
import { loginByPhone as loginApi, register as registerApi, fetchUserInfo } from '../api/auth'
import { setUserBalance, clearUserBalance } from '@/stores/user'

export function useAuth() {
  const router = useRouter()

  const login = async (phone: string, password: string) => {
    const res = await loginApi({ phone, pwd: password })
    const token = (res as any).token
    if (token) {
      localStorage.setItem('token', token)
      try {
        const info = await fetchUserInfo()
        setUserBalance(Number(info.money) || 0)
      } catch { /* silent */ }
    }
    router.push({ name: 'Home' })
    return res
  }

  const register = async (phone: string, code: string, password: string, agentId: string) => {
    const res = await registerApi({ phone, captcha: code, pwd: password, upwd: password, agent_id: agentId, user_name: phone })
    router.push({ name: 'Login' })
    return res
  }

  const logout = () => {
    clearUserBalance()
    localStorage.removeItem('token')
    router.push({ name: 'Login' })
  }

  return { login, register, logout }
}
