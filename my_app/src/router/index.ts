import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import Home from '../views/Home.vue'
import Login from '../views/Login.vue'
import BalanceCenter from '../views/BalanceCenter.vue'
import { setLocale } from '../i18n'

// ── 无需登录 ────────────────────────────────────────────────────────────────
const publicRoutes: Array<RouteRecordRaw> = [
    { path: '/login',   name: 'Login',         component: Login },
    { path: '/balance', name: 'BalanceCenter',  component: BalanceCenter },
]

// ── 需要登录 ────────────────────────────────────────────────────────────────
const authRoutes: Array<RouteRecordRaw> = [
    { path: '/', name: 'Home', component: Home, meta: { requiresAuth: true } },
]

const routes: Array<RouteRecordRaw> = [...publicRoutes, ...authRoutes]

const router = createRouter({
    history: createWebHistory(),
    routes
})

router.beforeEach((to, from, next) => {
    // 检测 URL 中的 lang 参数并切换语言
    if (to.query.lang) {
        setLocale(to.query.lang as string)
    }

    const token = localStorage.getItem('token')
    if (to.meta.requiresAuth && !token) {
        next({ name: 'Login' })
    } else {
        next()
    }
})

export default router