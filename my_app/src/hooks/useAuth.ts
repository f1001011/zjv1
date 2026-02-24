import { useRouter } from 'vue-router'
import { login as loginApi } from '../api/auth'

export function useAuth() {
  const router = useRouter()

  const login = async (username: string, password: string) => {
    const res = await loginApi({ username, password })
    const token = (res as any).token
    if (token) {
      localStorage.setItem('token', token)
    }
    router.push({ name: 'Home' })
    return res
  }

  return { login }
}
