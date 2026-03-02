# Page: VIP (`/vip`)

**File:** `src/views/Vip.vue`
**Route name:** `Vip`
**Auth required:** Yes (`meta: { requiresAuth: true }`)

---

## Layout Overview

```
┌─────────────────────────────┐
│  (level-color orb bg)       │
│                             │
│     [Crown 渐变圆形徽章]     │
│         LV.5                │
│       青金石传说             │
│    累计经验 18,200 XP        │
│                             │
│ ┌── XP 进度卡 ─────────────┐ │
│ │ 当前经验  3,200 / 5,000  │ │
│ │ ████████░░░░  64%        │ │
│ │ 距下一级还差 1,800 XP     │ │
│ └──────────────────────────┘ │
│                             │
│ ┌── 等级之路 ──────────────┐ │
│ │ ●─●─●─●─●─◉─●─●─●─●   │ │
│ │ 0  1  2  3  4  5  6...  │ │
│ └──────────────────────────┘ │
│                             │
│ ┌── 专属特权 ──────────────┐ │
│ │ [%折扣] [🎧客服]         │ │
│ │ [🎁礼包] [🛡保障]        │ │
│ └──────────────────────────┘ │
│                             │
│ ┌── 经验记录 ──────────────┐ │
│ │ [icon] 充值  2小时前 +50 │ │
│ │ [icon] 购买  1天前  +30  │ │
│ │ ... (infinite scroll)    │ │
│ └──────────────────────────┘ │
└─────────────────────────────┘
```

---

## Data & API

```ts
// src/api/vip.ts
fetchVipInfo(): Promise<VipInfo>
fetchVipXpHistory({ page, pageSize }): Promise<{ list: XpRecord[], hasMore: boolean }>

// src/types/vip.ts
interface VipInfo {
  level: number        // 0–9
  currentXp: number
  nextLevelXp: number  // 0 表示满级
  totalXp: number
}
interface XpRecord {
  id: string
  sourceKey: string    // recharge | purchase | signin | invite | task
  xp: number
  createdAt: string    // ISO 8601
}
```

---

## Level Color System

10 级各有独立配色，通过 CSS 变量注入：

| 级别 | 主题 | from → to |
|------|------|-----------|
| 0 | 灰铁 | `#6b7280` → `#9ca3af` |
| 1 | 青铜 | `#92400e` → `#cd7f32` |
| 2 | 白银 | `#6b7280` → `#d1d5db` |
| 3 | 黄金 | `#92400e` → `#ffd700` |
| 4 | 铂金 | `#475569` → `#e2e8f0` |
| 5 | 青金石 | `#0891b2` → `#67e8f9` |
| 6 | 琥珀 | `#78350f` → `#d97706` |
| 7 | 紫晶 | `#7c3aed` → `#c084fc` |
| 8 | 赤焰 | `#dc2626` → `#f87171` |
| 9 | 神话 | `#ea580c` → `#fb923c` |

Hero 区注入 `--lv-from / --lv-to / --lv-glow`；等级路节点注入 `--nc-from / --nc-to / --nc-glow`。

---

## Privileges Grid

2×2 网格，固定 4 项：

| key | icon | color |
|-----|------|-------|
| discount | Percent | `#ffd700` |
| service | Headphones | `#67e8f9` |
| gift | Gift | `#c084fc` |
| protect | ShieldCheck | `#4ade80` |

i18n 路径：`vip.priv.{key}.title` / `vip.priv.{key}.desc`

---

## XP History Infinite Scroll

- 首屏加载：`onMounted` → `loadVipInfo()` + `loadMore()`
- 翻页：`IntersectionObserver` 监听 `.sentinel` 元素，进入视口触发 `loadMore()`
- 每页 10 条，`hasMore` 控制是否继续加载
- 时间格式：`< 1h` → "N 分钟前"，`< 24h` → "N 小时前"，否则 "N 天前"

---

## Source Style Map

| sourceKey | icon | color |
|-----------|------|-------|
| recharge | Wallet | `#ffd700` |
| purchase | ShoppingBag | `#f87171` |
| signin | CalendarDays | `#4ade80` |
| invite | UserPlus | `#67e8f9` |
| task | CheckCircle2 | `#c084fc` |

---

## i18n Keys

```
vip.totalXp       vip.xpUnit        vip.currentXp
vip.nextLevel     vip.maxLevel      vip.levelRoad
vip.privileges    vip.xpHistory     vip.noMore
vip.levelNames    (array, 10 items)
vip.source.recharge / purchase / signin / invite / task
vip.priv.discount / service / gift / protect  (.title / .desc)
```

---

## Notes

- 等级路横向滚动，`onMounted` 后自动 `scrollIntoView` 到当前激活节点
- 背景光球颜色随等级变化（`orbBg` 字段，`transition: background 0.8s`）
- 满级时进度条 100%，隐藏"距下一级"提示，显示 `vip.maxLevel`
