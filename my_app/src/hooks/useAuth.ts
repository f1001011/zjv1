import { useRouter } from 'vue-router'
import { loginByPhone as loginApi, register as registerApi } from '../api/auth'

export function useAuth() {
  const router = useRouter()

  const login = async (phone: string, password: string) => {
    const res = await loginApi({ phone, pwd: password })
    const token = (res as any).token
    if (token) localStorage.setItem('token', token)
    router.push({ name: 'Home' })
    return res
  }

  const register = async (phone: string, code: string, password: string, agentId: string) => {
    const res = await registerApi({ phone, captcha: code, pwd: password, upwd: password, agent_id: agentId, user_name: phone })
    router.push({ name: 'Login' })
    return res
  }

  const logout = () => {
    localStorage.removeItem('token')
    router.push({ name: 'Login' })
  }

  return { login, register, logout }
}
