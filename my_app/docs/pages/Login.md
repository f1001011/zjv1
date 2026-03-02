# Page: Login (`/login`)

**File:** `src/views/Login.vue`
**Route name:** `Login`
**Auth required:** No

---

## Layout Overview

```
┌─────────────────────────────┐
│  (orb-red + orb-cyan bg)    │
│                             │
│  [←]   登录        [ ]      │
│                             │
│  🔒 Hero icon + title       │
│     "欢迎回来"               │
│                             │
│ ┌─────────────────────────┐ │
│ │ ▔▔▔▔ top gradient bar  │ │
│ │ PHONE                   │ │
│ │ [📱 input]              │ │
│ │ PASSWORD                │ │
│ │ [🔒 input] [👁]         │ │
│ │                         │ │
│ │ [  登录按钮  ]           │ │
│ │ 忘记密码？               │ │
│ └─────────────────────────┘ │
│                             │
│  没有账号？ 立即注册          │
└─────────────────────────────┘
```

---

## Behavior

1. 输入手机号 + 密码
2. 调用 `useAuth().login(phone, password)`
3. 成功 → `showPopup(t('auth.loginSuccess'), 'success')` → 跳转 `/`
4. 失败 → `showPopup(errorMessage, 'error')` + 刷新验证码

---

## Composables Used

```ts
import { useAuth }  from '@/hooks/useAuth'
import { usePopup } from '@/composables/usePopup'
import { useI18n }  from 'vue-i18n'
import { useRouter } from 'vue-router'
```

---

## Icons (lucide-vue-next)

```
Phone, Lock, Eye, EyeOff, ChevronLeft, LogIn, Loader2
```

---

## i18n Keys Used

```
auth.loginTitle       auth.loginSubtitle
auth.phone            auth.phonePlaceholder
auth.password         auth.passwordPlaceholder
auth.loginBtn         auth.forgotPassword
auth.noAccount        auth.toRegister
auth.loginSuccess     auth.phoneError
auth.passwordError
```

---

## Design

- 背景：`var(--bg-base)` + 3 个浮动光球（red / cyan / amber）
- 卡片：glass card（`var(--bg-card)` + `backdrop-filter: blur(28px)`）
- 顶部彩条：`linear-gradient(90deg, #ff4d4d, #00e5ff, #ffb800)`
- Hero 图标：红色渐变圆角方块（`colors.gradients.deposit`）
- 提交按钮：`linear-gradient(135deg, #ff4d4d, #ff1744)`，hover 上浮 + 加深阴影
- 入场动画：`v-motion` spring（delay 梯度：topBar 40ms → hero 100ms → card 160ms → bottomLink 400ms）

---

## Notes

- BottomNav 在此页隐藏（`route.name !== 'Login'`）
- 表单校验：手机号正则 `/^1[3-9]\d{9}$/`，密码 ≥ 6 位
- 密码可切换明文/密文（`showPass` ref）
- 登录成功后 token 存入 `localStorage`，key 为 `token`
