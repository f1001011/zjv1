# Page: Register (`/register`)

**File:** `src/views/Register.vue`
**Route name:** `Register`
**Auth required:** No

---

## Layout Overview

```
┌─────────────────────────────┐
│  (orb-cyan + lime + red bg) │
│                             │
│  [←]   注册账号      [ ]    │
│                             │
│  [UserPlus icon] 注册账号   │
│                 加入我们     │
│                             │
│ ┌─────────────────────────┐ │
│ │ ▔▔▔ cyan→lime→amber bar │ │
│ │ PHONE                   │ │
│ │ [📱 input]              │ │
│ │ 图形验证码               │ │
│ │ [🔑 input] [canvas图片] │ │
│ │ 邀请码                   │ │
│ │ [# input]               │ │
│ │ PASSWORD                │ │
│ │ [🔒 input] [👁]         │ │
│ │                         │ │
│ │ [  注册按钮  ]           │ │
│ │ 注册即代表同意用户协议    │ │
│ └─────────────────────────┘ │
│                             │
│  已有账号？ 去登录           │
└─────────────────────────────┘
```

---

## Form Fields

| 字段 | 类型 | 校验规则 |
|------|------|---------|
| phone | tel, maxlength=11 | `/^1[3-9]\d{9}$/` |
| code | text, maxlength=4 | 长度 ≥ 4 |
| agentId | text | 非空 |
| password | password | 长度 ≥ 6 |

---

## Canvas 图形验证码

- 尺寸：110×52 px（逻辑像素）
- DPR 适配：`canvas.width/height = W/H * devicePixelRatio`，`ctx.scale(dpr, dpr)`
- 内容：彩色字符（4位）+ 贝塞尔干扰曲线 × 3 + 随机噪点 × 55
- 字符颜色池：`['#ff4d4d','#00e5ff','#ffb800','#69ff47','#ff8080','#80f0ff','#ffd060']`
- 点击图片区域刷新（`@click="loadCaptcha"`），hover 显示"刷新"遮罩
- 数据来源：`fetchCaptcha()` → `{ captchaId, code }`

```ts
// src/api/auth.ts
fetchCaptcha(): Promise<{ captchaId: string; code: string }>
```

---

## Behavior

1. `onMounted` → `loadCaptcha()` 渲染初始验证码
2. 点击注册 → `validate()` 全字段校验
3. 调用 `useAuth().register(phone, code, password, agentId)`
4. 成功 → `showPopup(t('auth.registerSuccess'), 'success')`
5. 失败 → `loadCaptcha()` 刷新验证码

---

## Composables & Hooks

```ts
import { useAuth }  from '@/hooks/useAuth'
import { usePopup } from '@/composables/usePopup'
import { useI18n }  from 'vue-i18n'
import { useRouter } from 'vue-router'
```

---

## Icons (lucide-vue-next)

```
Phone, Lock, Eye, EyeOff, ChevronLeft, UserPlus, Loader2, KeyRound, RefreshCw, Hash
```

---

## i18n Keys Used

```
auth.registerTitle    auth.registerSubtitle
auth.phone            auth.phonePlaceholder    auth.phoneError
auth.smsCode          auth.smsPlaceholder      auth.codeError
auth.inviteCode       auth.inviteCodePlaceholder  auth.inviteCodeError
password              auth.newPasswordPlaceholder  auth.passwordError
auth.registerBtn      auth.registerSuccess
auth.hasAccount       auth.toLogin
```

---

## Design

- 背景：`var(--bg-base)` + 3 个浮动光球（cyan / lime / red）
- 卡片：glass card（`var(--bg-card)` + `backdrop-filter: blur(28px)`）
- 顶部彩条：`linear-gradient(90deg, #00e5ff, #69ff47, #ffb800)`
- Hero 图标：cyan 渐变（`#00e5ff → #00b0ff`）
- 提交按钮：`linear-gradient(135deg, #00e5ff, #00b0ff)`

---

## Notes

- BottomNav 在此页隐藏（`route.name !== 'Register'`）
- 验证码 canvas 不设 HTML `width/height` 属性，完全由 JS 控制（DPR 兼容）
- 邀请码为必填项，不可跳过
