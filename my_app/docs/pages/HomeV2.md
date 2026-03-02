# Page: HomeV2 (`/`)

**File:** `src/views/HomeV2.vue`
**Route name:** `Home`
**Auth required:** No
**旧首页保留路径:** `/home-v1` → `src/views/Home.vue`（route name: `HomeV1`）

---

## Layout Overview

```
┌─────────────────────────────┐
│  (orb-red/cyan/amber/lime bg + dot grid) │
│                             │
│  [头像双环]  时段问候  [🔔]  │
│                             │
│ ┌── Hero 余额卡 ────────────┐ │
│ │  旋转彩虹边框              │ │
│ │  扫描线 + 扫光             │ │
│ │  LIVE● 账户余额   VIP徽章  │ │
│ │  ¥ [数字滚筒]             │ │
│ │  今日收益 | 冻结金额        │ │
│ │  [充值] [提现] [转账] [明细]│ │
│ └──────────────────────────┘ │
│                             │
│  [📢 公告滚动条]             │
│                             │
│ ┌── 快捷功能 4×2 ───────────┐ │
│ │ 流量 话费 会员 游戏        │ │
│ │ VIP  商品 生活 更多        │ │
│ └──────────────────────────┘ │
│                             │
│  [促销卡A]  [促销卡B]        │
│                             │
│  🔥热门商品  [全部→]         │
│  ← [卡] [卡] [卡] [卡] →   │
│                             │
│  ⊞全部商品                  │
│  [分类筛选横向滚动]           │
│  [商品] [商品]               │
│  [商品] [商品]               │
│  ... infinite scroll ...    │
└─────────────────────────────┘
       BottomNav (fixed)
```

---

## Animations

| 动画名 | 效果 | 时长 |
|---|---|---|
| `border-spin` | Hero 卡旋转彩虹渐变边框 | 5s linear ∞ |
| `scan-line` | 青色扫描线从上到下穿越 Hero 卡 | 3.5s linear ∞ |
| `hero-shim` | 光晕扫光横扫 Hero 卡 | 5s ease-in-out ∞ |
| `avatar-ring` | 头像双层红色脉冲波纹（r1/r2 错峰 0.8s） | 2.4s ease-out ∞ |
| `notif-pulse` | 通知红点外扩呼吸光晕 | 1.8s ease-in-out ∞ |
| `live-pulse` | 绿色 LIVE 指示点缩放跳动 | 1.4s ease-in-out ∞ |
| `quick-ring-out` | 快捷按钮涟漪扩散（各按钮 `--qd` 错峰 0.18s） | 2.2s ease-out ∞ |
| `icon-float` | 促销卡图标浮动 + 微旋转 | 3.5s ease-in-out ∞ |
| `promo-shim` | 促销卡扫光 | 4s ease-in-out ∞ |
| `flame-flicker` | 热门标题火焰图标忽明忽暗 | 1.2s ease-in-out ∞ |
| `marquee` | 公告栏无缝横向滚动（内容×2 实现无缝） | 28s linear ∞ |
| `drift` | 4 个背景光球浮动（16/21/25/19s 各异） | — |
| `v-motion spring` | 所有区块依次弹入，delay 梯度 50ms→1000ms | stiffness 170~260 |

---

## Sections

### Header
- 头像：红色渐变方块 + 双层 `avatar-ring` 脉冲波纹
- 问候语：根据当前小时计算（`timeGreeting` computed）
  - 0–5 → 夜深了 / 6–11 → 早上好 / 12–13 → 中午好 / 14–17 → 下午好 / 18+ → 晚上好
- 右侧铃铛按钮 → `router.push('/balance')`，红点 `notif-pulse` 动画

### Hero Balance Card
- 旋转边框：`.hero-border-el` 绝对定位 `inset:-100%`，`conic-gradient` + `border-spin`
- 内层：`margin:2px` 形成 2px 彩色边框视觉
- 数字滚筒：`animatedBalance` ref，`easeOutQuart` 2200ms 动画，`requestAnimationFrame`
  - `integerChars` computed → 千分位分隔，每位独立 `.digit-col` + `.digit-strip`
  - strip 高度 46px × 10 = 460px，`translateY(-${digit * 10}%)` 定位
- 操作按钮：4 个，颜色来自 `heroActions` computed（red/cyan/amber/lime），3D 浮雕 + hover 上浮

### Notice Bar
- `noticeList` 数组 × 2 渲染，CSS `marquee` 动画实现无缝滚动
- 右侧 `.notice-fade-r` 渐变遮罩

### Quick Features (4×2)
- `quickFeatures` 数组，8 项，各有 `--qc`（颜色）、`--qg`（glow）、`--qd`（动画延迟）CSS 变量
- `.quick-ring` 涟漪：`scale(0.75→1.25)` + `opacity(0.7→0)`

### Promo Cards
- `promoCards` computed，2 列 grid
- 每张卡：`--pb`（背景渐变）、`--pg`（glow）、`--ptc`（tag 颜色）CSS 变量

### Hot Products
- `hotProducts` = `displayProducts.slice(0, 8)`，横向滚动
- 3D 图标同 Home.vue 模式

### All Products
- 分类筛选 + 2 列 grid + IntersectionObserver 无限滚动
- 逻辑与 Home.vue 完全一致（`fetchGoodsTypes` / `fetchGoodsList`）

---

## Data & API

| 调用 | 函数 | 时机 |
|---|---|---|
| 用户余额 | `fetchUserInfo()` → `info.money_balance` | onMounted（有 token 才调用） |
| 商品分类 | `fetchGoodsTypes()` | onMounted |
| 商品列表 | `fetchGoodsList(category, page, 10)` | onMounted + 分类切换 + 滚动 |

---

## Composables & Stores

```ts
import { userBalance, setUserBalance } from '@/stores/user'
import { fetchUserInfo }               from '@/api/auth'
import { fetchGoodsTypes, fetchGoodsList } from '@/api/product'
```

---

## CSS Variables Used

```
--bg-base  --bg-card  --border
--orb-red  --orb-cyan  --orb-amber
--hac  --hac-g   (hero action button color/glow)
--qc   --qg  --qd  (quick feature color/glow/delay)
--pb   --pg  --ptc  (promo card bg/glow/tag-color)
--hbg  --hgl        (hot card bg/glow)
--ac                (category active color)
--nc                (BottomNav active color, inherited)
```

---

## Icons (lucide-vue-next)

```
User, Bell, Crown, Volume2,
Flame, ChevronRight, Package, LayoutGrid,
ArrowDownCircle, ArrowUpCircle, ArrowLeftRight, ClipboardList,
ShoppingBag, TrendingUp, Lock,
Wifi, Phone, Gamepad2, Coffee, Star, ShoppingCart, Gift, Zap,
CreditCard, Music, Signal, Sword, Gem, Car
```

---

## Notes

- BottomNav 正常显示（route.name = `'Home'`，与旧首页相同）
- 旧首页访问路径：`/home-v1`（route name: `HomeV1`）
- `bg-grid`：固定点阵背景，`radial-gradient` 28px 间距，mask 渐隐边缘
- Hero 卡旋转边框兼容性：`conic-gradient` 需 Chrome 69+ / Safari 12.1+（移动端均支持）
- 数字滚筒 `digit-strip` 使用 `cubic-bezier(0.34, 1.45, 0.64, 1)` 弹性过渡
