<template>
  <div class="h2-root">

    <!-- ── Animated Background ───────────────────────────────────────────── -->
    <div class="bg-canvas">
      <div class="orb orb-r"></div>
      <div class="orb orb-c"></div>
      <div class="orb orb-a"></div>
      <div class="orb orb-l"></div>
    </div>
    <div class="bg-grid"></div>

    <div class="page-wrap">

      <!-- ── Header ───────────────────────────────────────────────────────── -->
      <header class="h2-header"
        v-motion :initial="{ opacity:0, y:-24 }"
        :enter="{ opacity:1, y:0, transition:{ delay:50 } }">
        <div class="header-left">
          <div class="avatar-wrap">
            <div class="avatar-ring r1"></div>
            <div class="avatar-ring r2"></div>
            <div class="h2-avatar"><User :size="16"/></div>
          </div>
          <div class="header-info">
            <span class="h2-greet">{{ timeGreeting }}</span>
            <span class="h2-name">{{ t('home.welcome') }}</span>
          </div>
        </div>
        <div class="header-right">
          <button class="glass-btn notif-btn" @click="router.push('/balance')">
            <Bell :size="17"/>
            <span class="notif-dot"></span>
          </button>
        </div>
      </header>

      <!-- ── Hero Balance Card ─────────────────────────────────────────────── -->
      <div class="hero-card"
        v-motion :initial="{ opacity:0, y:44, scale:0.91 }"
        :enter="{ opacity:1, y:0, scale:1, transition:{ delay:110, type:'spring', stiffness:170, damping:19 } }">
        <!-- Rotating gradient border -->
        <div class="hero-border-el" aria-hidden="true"></div>
        <!-- Glass inner -->
        <div class="hero-inner">
          <!-- Scan line -->
          <div class="hero-scan" aria-hidden="true"></div>
          <!-- Shimmer sweep -->
          <div class="hero-shimmer" aria-hidden="true"></div>

          <!-- Label row -->
          <div class="hero-label-row">
            <div class="hero-label-left">
              <span class="hero-live-dot"></span>
              <span class="hero-label">{{ t('home.balanceLabel') }}</span>
            </div>
            <div class="hero-vip-chip">
              <Crown :size="9"/>
              <span>VIP 会员</span>
            </div>
          </div>

          <!-- Digit Roller Balance -->
          <div class="hero-balance-row">
            <span class="hero-currency">¥</span>
            <div class="hero-digits">
              <template v-for="(ch, ci) in integerChars" :key="ci">
                <span v-if="ch === ','" class="digit-sep">{{ ch }}</span>
                <div v-else class="digit-col">
                  <div class="digit-strip"
                    :style="{ transform: `translateY(-${Number(ch) * 10}%)` }">
                    <span v-for="n in 10" :key="n">{{ n - 1 }}</span>
                  </div>
                </div>
              </template>
              <span class="digit-dot">.</span>
              <span class="digit-dec">{{ decimalPart }}</span>
            </div>
          </div>

          <!-- Sub info -->
          <div class="hero-sub-row">
            <div class="hero-sub-item">
              <TrendingUp :size="11" class="sub-ic cyan"/>
              <span class="sub-txt">今日收益</span>
              <span class="sub-val cyan">+¥18.50</span>
            </div>
            <div class="hero-sep-line"></div>
            <div class="hero-sub-item">
              <Lock :size="11" class="sub-ic amber"/>
              <span class="sub-txt">冻结</span>
              <span class="sub-val amber">¥0.00</span>
            </div>
          </div>

          <!-- Action buttons -->
          <div class="hero-actions">
            <button v-for="act in heroActions" :key="act.key"
              class="hero-act-btn"
              :style="{ '--hac': act.color, '--hac-g': act.glow }"
              @click="act.onClick">
              <div class="hero-act-icon">
                <component :is="act.icon" :size="15"/>
              </div>
              <span class="hero-act-label">{{ act.label }}</span>
            </button>
          </div>
        </div>
      </div>

      <!-- ── Notice / Marquee Bar ───────────────────────────────────────────── -->
      <div class="notice-bar"
        v-motion :initial="{ opacity:0, y:10 }" :enter="{ opacity:1, y:0, transition:{ delay:230 } }">
        <div class="notice-icon-wrap">
          <Volume2 :size="11"/>
        </div>
        <div class="notice-track-outer">
          <div class="notice-track">
            <span v-for="(msg, mi) in [...noticeList, ...noticeList]" :key="mi" class="notice-item">
              {{ msg }}
            </span>
          </div>
        </div>
        <div class="notice-fade-r"></div>
      </div>

      <!-- ── Quick Features 4×2 Grid ──────────────────────────────────────── -->
      <div class="quick-section"
        v-motion :initial="{ opacity:0, y:22 }" :enter="{ opacity:1, y:0, transition:{ delay:290 } }">
        <div class="quick-grid">
          <button v-for="(feat, fi) in quickFeatures" :key="feat.key"
            class="quick-btn"
            :style="{ '--qc': feat.color, '--qg': feat.glow, '--qd': `${fi * 0.18}s` }"
            @click="feat.onClick">
            <div class="quick-icon-outer">
              <div class="quick-ring"></div>
              <div class="quick-icon-inner">
                <component :is="feat.icon" :size="19"/>
              </div>
            </div>
            <span class="quick-label">{{ feat.label }}</span>
          </button>
        </div>
      </div>

      <!-- ── Promo Cards ────────────────────────────────────────────────────── -->
      <div class="promo-row"
        v-motion :initial="{ opacity:0, y:20 }" :enter="{ opacity:1, y:0, transition:{ delay:350 } }">
        <div v-for="(promo, pi) in promoCards" :key="pi"
          class="promo-card"
          :style="{ '--pb': promo.bg, '--pg': promo.glow, '--ptc': promo.tagColor }"
          @click="promo.onClick">
          <div class="promo-glow-el" aria-hidden="true"></div>
          <div class="promo-shimmer-el" aria-hidden="true"></div>
          <div class="promo-content">
            <div class="promo-tag">{{ promo.tag }}</div>
            <div class="promo-title">{{ promo.title }}</div>
            <div class="promo-sub">{{ promo.sub }}</div>
          </div>
          <div class="promo-icon-wrap">
            <component :is="promo.icon" :size="38" class="promo-icon"/>
          </div>
        </div>
      </div>

      <!-- ── Hot Products Horizontal ──────────────────────────────────────── -->
      <div class="section-header"
        v-motion :initial="{ opacity:0 }" :enter="{ opacity:1, transition:{ delay:410 } }">
        <div class="section-title">
          <div class="section-ic-wrap flame-wrap">
            <Flame :size="12"/>
          </div>
          热门商品
        </div>
        <button class="view-all-btn" @click="router.push('/products')">
          全部 <ChevronRight :size="11"/>
        </button>
      </div>

      <div class="hot-scroll"
        v-motion :initial="{ opacity:0, x:28 }" :enter="{ opacity:1, x:0, transition:{ delay:450 } }">
        <div v-if="hotProducts.length === 0" class="hot-empty">
          <Package :size="26"/>
          <span>暂无商品</span>
        </div>
        <div v-for="(product, hi) in hotProducts" :key="product.id"
          class="hot-card"
          :style="{ '--hbg': product.gradient, '--hgl': product.glow }"
          @click="router.push(`/products/${product.id}`)">
          <div class="hot-img-area">
            <div class="hot-img-glow" aria-hidden="true"></div>
            <img v-if="product.imageUrl" :src="product.imageUrl" class="hot-img-pic"/>
            <div v-else class="hot-icon-3d">
              <component :is="product.icon" :size="24"/>
            </div>
            <span v-if="product.tag" class="hot-tag"
              :style="{ color: product.tagColor, borderColor: product.tagColor+'44', background: product.tagColor+'1a' }">
              {{ product.tag }}
            </span>
          </div>
          <div class="hot-info">
            <div class="hot-name">{{ product.name }}</div>
            <div class="hot-price" :style="{ color: product.priceColor }">¥{{ product.price }}</div>
          </div>
        </div>
      </div>

      <!-- ── All Products ───────────────────────────────────────────────────── -->
      <div class="section-header" style="margin-top:6px"
        v-motion :initial="{ opacity:0 }" :enter="{ opacity:1, transition:{ delay:490 } }">
        <div class="section-title">
          <div class="section-ic-wrap grid-wrap">
            <LayoutGrid :size="12"/>
          </div>
          全部商品
        </div>
      </div>

      <!-- Category Filter -->
      <div class="category-row"
        v-motion :initial="{ opacity:0 }" :enter="{ opacity:1, transition:{ delay:530 } }">
        <button v-for="cat in displayCategories" :key="cat.key"
          :class="['cat-btn', { active: activeCategory === cat.key }]"
          :style="activeCategory === cat.key
            ? { '--ac': cat.color, borderColor: cat.color + '55' } : {}"
          @click="activeCategory = cat.key">
          <component :is="cat.icon" :size="11"/>
          {{ catLabel(cat) }}
        </button>
      </div>

      <!-- Product Grid -->
      <div class="product-grid">
        <div v-for="(product, i) in displayProducts" :key="product.id"
          class="product-card glass-card"
          v-motion
          :initial="{ opacity:0, y:26, scale:0.91 }"
          :enter="{ opacity:1, y:0, scale:1, transition:{
            delay: Math.min(560 + i * 42, 1000),
            type: 'spring', stiffness:260, damping:20
          } }"
          @click="router.push(`/products/${product.id}`)">
          <div class="product-img" :style="{ background: product.gradient }">
            <div class="product-img-glow" :style="{ background: product.glow }"></div>
            <img v-if="product.imageUrl" class="product-img-pic" :src="product.imageUrl"/>
            <div v-else class="product-icon-3d">
              <component :is="product.icon" :size="26"/>
            </div>
            <span v-if="product.tag" class="product-tag-badge"
              :style="{
                color: product.tagColor,
                borderColor: product.tagColor + '44',
                background: product.tagColor + '1a'
              }">
              {{ product.tag }}
            </span>
          </div>
          <div class="product-info">
            <div class="product-name">{{ product.name }}</div>
            <div class="product-price" :style="{ color: product.priceColor }">¥{{ product.price }}</div>
            <div class="product-stock">
              <ShoppingBag :size="9"/>{{ t('home.purchasable', { n: product.maxPurchase }) }}
            </div>
          </div>
        </div>
      </div>

      <div ref="sentinel" class="sentinel"></div>
      <div v-if="isLoading" class="load-tip">{{ t('home.loadingMore') }}</div>
      <div v-else-if="!hasMore && displayProducts.length > 0" class="load-tip">{{ t('home.noMore') }}</div>
      <div style="height:44px"></div>

    </div><!-- end page-wrap -->
  </div>
</template>

<script lang="ts" setup>
import { ref, computed, onMounted, onUnmounted, watch, nextTick } from 'vue'
import type { Component } from 'vue'
import { colors } from '@/config/colors'
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import {
  User, Bell, Crown, Volume2,
  Flame, ChevronRight, Package, LayoutGrid,
  ArrowDownCircle, ArrowUpCircle, ArrowLeftRight, ClipboardList,
  ShoppingBag, TrendingUp, Lock,
  Wifi, Phone, Gamepad2, Coffee, Star, ShoppingCart, Gift, Zap,
  CreditCard, Music, Signal, Sword, Gem, Car,
} from 'lucide-vue-next'
import { fetchGoodsTypes, fetchGoodsList } from '@/api/product'
import type { GoodsType, GoodsItem } from '@/types/product'
import { fetchUserInfo } from '@/api/auth'
import { userBalance, setUserBalance } from '@/stores/user'

const router = useRouter()
const { t, locale } = useI18n()

// ── Time greeting ─────────────────────────────────────────────────────────────
const timeGreeting = computed(() => {
  const h = new Date().getHours()
  if (h < 6)  return '夜深了'
  if (h < 12) return '早上好'
  if (h < 14) return '中午好'
  if (h < 18) return '下午好'
  return '晚上好'
})

// ── Digit roller ──────────────────────────────────────────────────────────────
const animatedBalance = ref(0)
let rollRaf: number | null = null

function startRoll(target: number) {
  if (rollRaf) cancelAnimationFrame(rollRaf)
  const DURATION = 2200
  const DELAY    = 600
  const startAt  = Date.now() + DELAY
  const from     = 0
  function ease(t: number) { return 1 - Math.pow(1 - t, 4) } // easeOutQuart
  function tick() {
    const now     = Date.now()
    if (now < startAt) { rollRaf = requestAnimationFrame(tick); return }
    const elapsed = now - startAt
    const p       = Math.min(elapsed / DURATION, 1)
    animatedBalance.value = from + (target - from) * ease(p)
    if (p < 1) rollRaf = requestAnimationFrame(tick)
    else        animatedBalance.value = target
  }
  rollRaf = requestAnimationFrame(tick)
}

const integerChars = computed(() =>
  Math.floor(animatedBalance.value).toLocaleString('zh-CN').split('')
)
const decimalPart = computed(() =>
  (animatedBalance.value % 1).toFixed(2).slice(2)
)

watch(userBalance, (v) => startRoll(v))

// ── Balance load ──────────────────────────────────────────────────────────────
async function loadHomeBalance() {
  if (!localStorage.getItem('token')) return
  try {
    const info = await fetchUserInfo()
    setUserBalance(Number(info.money_balance) || 0)
  } catch { /* silent */ }
}

// ── Hero actions ──────────────────────────────────────────────────────────────
const heroActions = computed(() => [
  { key: 'deposit',  label: '充值', icon: ArrowDownCircle, color: colors.red,   glow: colors.redGlow,   onClick: () => router.push('/balance') },
  { key: 'withdraw', label: '提现', icon: ArrowUpCircle,   color: colors.cyan,  glow: colors.cyanGlow,  onClick: () => router.push('/balance') },
  { key: 'transfer', label: '转账', icon: ArrowLeftRight,  color: colors.amber, glow: colors.amberGlow, onClick: () => router.push('/balance') },
  { key: 'history',  label: '明细', icon: ClipboardList,   color: colors.lime,  glow: colors.limeGlow,  onClick: () => router.push('/balance') },
])

// ── Notice bar ────────────────────────────────────────────────────────────────
const noticeList = [
  '🎉 限时活动：充值满100送20，立即体验！',
  '📢 新用户专享福利，首充立减50元',
  '⚡ 热门商品秒杀进行中，低至1折起',
  '🎁 VIP会员专属礼包，点击领取',
  '✅ 平台安全认证，资金100%有保障',
]

// ── Quick features ────────────────────────────────────────────────────────────
const quickFeatures: Array<{
  key: string; label: string; icon: Component;
  color: string; glow: string; onClick: () => void
}> = [
  { key: 'data',   label: '流量',  icon: Wifi,         color: colors.cyan,  glow: colors.cyanGlow,  onClick: () => router.push('/products') },
  { key: 'phone',  label: '话费',  icon: Phone,        color: colors.amber, glow: colors.amberGlow, onClick: () => router.push('/products') },
  { key: 'member', label: '会员',  icon: Crown,        color: colors.red,   glow: colors.redGlow,   onClick: () => router.push('/vip') },
  { key: 'game',   label: '游戏',  icon: Gamepad2,     color: colors.lime,  glow: colors.limeGlow,  onClick: () => router.push('/products') },
  { key: 'vip',    label: 'VIP',   icon: Star,         color: colors.amber, glow: colors.amberGlow, onClick: () => router.push('/vip') },
  { key: 'shop',   label: '商品',  icon: ShoppingCart, color: colors.red,   glow: colors.redGlow,   onClick: () => router.push('/products') },
  { key: 'coffee', label: '生活',  icon: Coffee,       color: colors.cyan,  glow: colors.cyanGlow,  onClick: () => router.push('/products') },
  { key: 'more',   label: '更多',  icon: LayoutGrid,   color: 'rgba(255,255,255,0.45)', glow: 'rgba(255,255,255,0.15)', onClick: () => {} },
]

// ── Promo cards ───────────────────────────────────────────────────────────────
const promoCards = computed(() => [
  {
    tag: '新用户专享', title: '首充赠 50 元', sub: '注册立享 · 限时优惠',
    bg:   'linear-gradient(135deg, rgba(255,77,77,0.22) 0%, rgba(255,23,68,0.12) 100%)',
    glow: 'radial-gradient(circle at 20% 50%, rgba(255,77,77,0.4), transparent 65%)',
    tagColor: colors.red,
    icon: Gift, onClick: () => router.push('/balance'),
  },
  {
    tag: 'VIP 专属', title: '会员特权礼包', sub: '折扣 · 客服 · 专属礼包',
    bg:   'linear-gradient(135deg, rgba(255,184,0,0.20) 0%, rgba(255,109,0,0.10) 100%)',
    glow: 'radial-gradient(circle at 20% 50%, rgba(255,184,0,0.38), transparent 65%)',
    tagColor: colors.amber,
    icon: Crown, onClick: () => router.push('/vip'),
  },
])

// ── Icon & visual maps ────────────────────────────────────────────────────────
const ICON_MAP: Record<string, Component> = {
  layoutgrid: LayoutGrid, wifi: Wifi,     phone: Phone,   crown: Crown,
  gamepad2: Gamepad2,     coffee: Coffee, signal: Signal, creditcard: CreditCard,
  music: Music,           star: Star,     sword: Sword,   gem: Gem,
  shoppingcart: ShoppingCart, car: Car,
}
const COLOR_MAP: Record<string, string> = {
  red: colors.red, cyan: colors.cyan, amber: colors.amber, green: colors.lime,
}
const VISUAL_LIST = [
  { gradient:'linear-gradient(160deg,rgba(0,229,255,0.15),rgba(0,176,255,0.07))',   glow:'radial-gradient(circle at 60% 40%,rgba(0,229,255,0.28),transparent 65%)',   priceColor:'#00e5ff' },
  { gradient:'linear-gradient(160deg,rgba(255,184,0,0.15),rgba(255,109,0,0.07))',   glow:'radial-gradient(circle at 60% 40%,rgba(255,184,0,0.28),transparent 65%)',   priceColor:'#ffb800' },
  { gradient:'linear-gradient(160deg,rgba(105,255,71,0.13),rgba(0,230,118,0.07))',  glow:'radial-gradient(circle at 60% 40%,rgba(105,255,71,0.24),transparent 65%)',  priceColor:'#69ff47' },
  { gradient:'linear-gradient(160deg,rgba(255,77,77,0.15),rgba(255,23,68,0.07))',   glow:'radial-gradient(circle at 60% 40%,rgba(255,77,77,0.28),transparent 65%)',   priceColor:'#ff4d4d' },
  { gradient:'linear-gradient(160deg,rgba(0,229,255,0.13),rgba(0,176,255,0.07))',   glow:'radial-gradient(circle at 60% 40%,rgba(0,229,255,0.24),transparent 65%)',   priceColor:'#00e5ff' },
]
const ICON_LIST   = Object.values(ICON_MAP)
const COLOR_LIST  = Object.values(COLOR_MAP)
const TAG_COLOR: Record<string, string> = {
  '热门': colors.red, '推荐': colors.lime, '爆款': colors.amber,
  '超值': colors.amber, '精选': colors.lime, '新手': colors.lime,
}

// ── Categories ────────────────────────────────────────────────────────────────
const activeCategory  = ref(0)
const categoriesRaw   = ref<GoodsType[]>([])

const displayCategories = computed(() => [
  { key: 0, labelZh: t('home.allCategory'), labelEn: t('home.allCategory'), icon: LayoutGrid, color: '#ff4d4d' },
  ...categoriesRaw.value.map((cat, i) => ({
    key:     cat.id,
    labelZh: cat.type_name,
    labelEn: cat.type_name,
    icon:    ICON_LIST[i % ICON_LIST.length] ?? LayoutGrid,
    color:   COLOR_LIST[i % COLOR_LIST.length] ?? '#ff4d4d',
  })),
])

function catLabel(cat: { labelZh: string; labelEn: string }) {
  return locale.value === 'zh' ? cat.labelZh : cat.labelEn
}

async function loadCategories() {
  try { categoriesRaw.value = await fetchGoodsTypes() } catch { /* silent */ }
}

// ── Products ──────────────────────────────────────────────────────────────────
const productList = ref<GoodsItem[]>([])
const page        = ref(1)
const hasMore     = ref(true)
const isLoading   = ref(false)
const PAGE_SIZE   = 10

const displayProducts = computed(() =>
  productList.value.map((p, i) => {
    const v = VISUAL_LIST[i % VISUAL_LIST.length]
    return {
      id:          p.id,
      name:        p.goods_name,
      price:       p.goods_money,
      maxPurchase: p.buy_num,
      imageUrl:    p.head_img ?? undefined,
      tag:         p.is_examine === 1 ? '新手' : '',
      icon:        Wifi,
      gradient:    v.gradient,
      glow:        v.glow,
      priceColor:  v.priceColor,
      tagColor:    p.is_examine === 1 ? (TAG_COLOR['推荐'] ?? '') : '',
    }
  })
)

const hotProducts = computed(() => displayProducts.value.slice(0, 8))

async function loadProducts(reset = false) {
  if (isLoading.value) return
  if (!reset && !hasMore.value) return
  isLoading.value = true
  if (reset) { page.value = 1; productList.value = []; hasMore.value = true }
  try {
    const result = await fetchGoodsList(activeCategory.value, page.value, PAGE_SIZE)
    productList.value = reset ? result.data : [...productList.value, ...result.data]
    hasMore.value = result.current_page < result.last_page
    page.value++
  } catch {
    hasMore.value = false
  } finally {
    isLoading.value = false
  }
}

// ── Infinite scroll ───────────────────────────────────────────────────────────
const sentinel = ref<HTMLElement | null>(null)
let observer: IntersectionObserver | null = null

function setupObserver() {
  if (observer) observer.disconnect()
  observer = new IntersectionObserver(
    entries => {
      if (entries[0].isIntersecting && hasMore.value && !isLoading.value) loadProducts()
    },
    { rootMargin: '120px' }
  )
  if (sentinel.value) observer.observe(sentinel.value)
}

watch(activeCategory, () => {
  loadProducts(true).then(() => nextTick(setupObserver))
})

onMounted(async () => {
  await Promise.all([loadCategories(), loadProducts(true), loadHomeBalance()])
  await nextTick()
  setupObserver()
})

onUnmounted(() => {
  if (rollRaf) cancelAnimationFrame(rollRaf)
  if (observer) observer.disconnect()
})
</script>

<style scoped>
* { box-sizing: border-box; margin: 0; padding: 0; }

/* ── Root ────────────────────────────────────────────────────────────────────── */
.h2-root {
  min-height: 100vh;
  background: var(--bg-base);
  position: relative;
  overflow: hidden;
  font-family: 'Inter','SF Pro Text',-apple-system,BlinkMacSystemFont,'PingFang SC','Noto Sans SC',sans-serif;
  -webkit-font-smoothing: antialiased;
}

/* ── Background Canvas ───────────────────────────────────────────────────────── */
.bg-canvas { position: fixed; inset: 0; pointer-events: none; z-index: 0; }

.orb {
  position: absolute;
  border-radius: 50%;
  filter: blur(88px);
  will-change: transform;
}
.orb-r { width: 500px; height: 500px; top: -120px; left: -100px; background: var(--orb-red);   animation: drift 16s ease-in-out infinite; }
.orb-c { width: 420px; height: 420px; top: 28%;    right: -70px; background: var(--orb-cyan);  animation: drift 21s ease-in-out infinite reverse 2s; }
.orb-a { width: 360px; height: 360px; bottom: 8%;  left: 10%;   background: var(--orb-amber); animation: drift 25s ease-in-out infinite 6s; }
.orb-l { width: 280px; height: 280px; bottom: 30%; right: -40px; background: rgba(105,255,71,0.18); animation: drift 19s ease-in-out infinite reverse 4s; }

@keyframes drift {
  0%,100% { transform: translate(0,0)       scale(1);    }
  33%     { transform: translate(22px,-16px) scale(1.04); }
  66%     { transform: translate(-14px,12px) scale(0.97); }
}

/* Dot grid overlay */
.bg-grid {
  position: fixed;
  inset: 0;
  pointer-events: none;
  z-index: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,0.045) 1px, transparent 1px);
  background-size: 28px 28px;
  mask-image: radial-gradient(ellipse 80% 80% at 50% 50%, black 40%, transparent 100%);
  -webkit-mask-image: radial-gradient(ellipse 80% 80% at 50% 50%, black 40%, transparent 100%);
}

/* ── Page wrap ───────────────────────────────────────────────────────────────── */
.page-wrap {
  position: relative;
  z-index: 1;
  max-width: 460px;
  margin: 0 auto;
  padding: 0 16px 80px;
}

/* ── Glass card base ─────────────────────────────────────────────────────────── */
.glass-card {
  background: var(--bg-card);
  backdrop-filter: blur(28px) saturate(160%);
  -webkit-backdrop-filter: blur(28px) saturate(160%);
  border: 1px solid var(--border);
  border-radius: 20px;
}

/* ── Header ──────────────────────────────────────────────────────────────────── */
.h2-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 54px 2px 18px;
}
.header-left  { display: flex; align-items: center; gap: 12px; }
.header-right { display: flex; align-items: center; gap: 10px; }

/* Avatar with pulsing rings */
.avatar-wrap {
  position: relative;
  width: 40px; height: 40px;
  display: flex; align-items: center; justify-content: center;
}
.avatar-ring {
  position: absolute;
  border-radius: 50%;
  border: 1.5px solid rgba(255,77,77,0.5);
  animation: avatar-ring 2.4s ease-out infinite;
}
.avatar-ring.r1 { inset: -4px; animation-delay: 0s; }
.avatar-ring.r2 { inset: -9px; animation-delay: 0.8s; }
@keyframes avatar-ring {
  0%   { transform: scale(0.7); opacity: 0.8; }
  100% { transform: scale(1.0); opacity: 0;   }
}
.h2-avatar {
  width: 40px; height: 40px; border-radius: 13px;
  background: linear-gradient(135deg, #ff4d4d, #ff1744);
  display: flex; align-items: center; justify-content: center;
  color: #fff;
  box-shadow: 0 0 16px rgba(255,77,77,0.45);
  position: relative; z-index: 1;
}

.header-info { display: flex; flex-direction: column; gap: 1px; }
.h2-greet { font-size: 10.5px; color: rgba(255,255,255,0.36); letter-spacing: 0.4px; }
.h2-name  { font-size: 14px; font-weight: 600; color: rgba(255,255,255,0.9); }

.glass-btn {
  width: 38px; height: 38px; border-radius: 11px;
  background: rgba(255,255,255,0.06);
  border: 1px solid rgba(255,255,255,0.09);
  color: rgba(255,255,255,0.6);
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; transition: background 0.2s, transform 0.15s;
  position: relative;
}
.glass-btn:hover  { background: rgba(255,255,255,0.11); }
.glass-btn:active { transform: scale(0.9); }

/* Notification dot */
.notif-dot {
  position: absolute;
  top: 7px; right: 7px;
  width: 7px; height: 7px;
  border-radius: 50%;
  background: #ff4d4d;
  border: 1.5px solid var(--bg-base);
  animation: notif-pulse 1.8s ease-in-out infinite;
}
@keyframes notif-pulse {
  0%,100% { box-shadow: 0 0 0 0 rgba(255,77,77,0.6); }
  50%     { box-shadow: 0 0 0 5px rgba(255,77,77,0);  }
}

/* ── Hero Card ────────────────────────────────────────────────────────────────── */
.hero-card {
  position: relative;
  border-radius: 26px;
  overflow: hidden;
  margin-bottom: 12px;
}

/* Rotating gradient border element */
.hero-border-el {
  position: absolute;
  inset: -100%;
  background: conic-gradient(#ff4d4d, #00e5ff, #ffb800, #69ff47, #ff4d4d);
  animation: border-spin 5s linear infinite;
}
@keyframes border-spin {
  to { transform: rotate(360deg); }
}

.hero-inner {
  position: relative;
  z-index: 1;
  margin: 2px;
  border-radius: 24px;
  background: rgba(8, 12, 24, 0.86);
  backdrop-filter: blur(32px) saturate(170%);
  -webkit-backdrop-filter: blur(32px) saturate(170%);
  padding: 20px 18px 18px;
  overflow: hidden;
}

/* Scan line */
.hero-scan {
  position: absolute;
  left: 0; right: 0;
  height: 1.5px;
  background: linear-gradient(90deg, transparent, rgba(0,229,255,0.5), transparent);
  animation: scan-line 3.5s linear infinite;
}
@keyframes scan-line {
  0%   { top: -5px;   opacity: 1; }
  90%  { opacity: 0.8; }
  100% { top: 105%;   opacity: 0; }
}

/* Shimmer sweep */
.hero-shimmer {
  position: absolute;
  top: 0; left: -120%;
  width: 70%; height: 100%;
  background: linear-gradient(105deg, transparent, rgba(255,255,255,0.055), transparent);
  transform: skewX(-18deg);
  animation: hero-shim 5s ease-in-out infinite;
}
@keyframes hero-shim {
  0%,35%  { left: -120%; }
  65%,100%{ left: 140%;  }
}

/* Label row */
.hero-label-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
}
.hero-label-left {
  display: flex;
  align-items: center;
  gap: 6px;
}
.hero-live-dot {
  width: 7px; height: 7px; border-radius: 50%;
  background: #69ff47;
  box-shadow: 0 0 8px rgba(105,255,71,0.8);
  animation: live-pulse 1.4s ease-in-out infinite;
}
@keyframes live-pulse {
  0%,100% { transform: scale(1);    opacity: 1;   }
  50%     { transform: scale(1.35); opacity: 0.65; }
}
.hero-label {
  font-size: 10.5px;
  font-weight: 500;
  letter-spacing: 1px;
  color: rgba(255,255,255,0.38);
  text-transform: uppercase;
}
.hero-vip-chip {
  display: flex;
  align-items: center;
  gap: 4px;
  padding: 3px 9px;
  border-radius: 20px;
  background: rgba(255,184,0,0.12);
  border: 1px solid rgba(255,184,0,0.3);
  color: #ffb800;
  font-size: 10px;
  font-weight: 600;
}

/* Digit Roller */
.hero-balance-row {
  display: flex;
  align-items: flex-end;
  gap: 2px;
  margin-bottom: 14px;
}
.hero-currency {
  font-size: 20px;
  font-weight: 700;
  color: rgba(255,255,255,0.55);
  padding-bottom: 5px;
  margin-right: 1px;
}
.hero-digits {
  display: flex;
  align-items: flex-end;
  height: 46px;
  overflow: hidden;
  gap: 0;
}
.digit-sep {
  font-size: 28px;
  font-weight: 800;
  color: rgba(255,255,255,0.4);
  line-height: 46px;
  padding: 0 1px;
}
.digit-dot {
  font-size: 28px;
  font-weight: 800;
  color: rgba(255,255,255,0.5);
  line-height: 46px;
}
.digit-dec {
  font-size: 18px;
  font-weight: 700;
  color: rgba(255,255,255,0.55);
  padding-bottom: 3px;
}
.digit-col {
  height: 46px;
  overflow: hidden;
  width: 26px;
}
.digit-strip {
  display: flex;
  flex-direction: column;
  transition: transform 0.55s cubic-bezier(0.34, 1.45, 0.64, 1);
}
.digit-strip span {
  height: 46px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 32px;
  font-weight: 800;
  color: #fff;
  line-height: 1;
  text-shadow: 0 0 20px rgba(255,255,255,0.25);
}

/* Sub row */
.hero-sub-row {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 12px;
  border-radius: 12px;
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.07);
  margin-bottom: 16px;
}
.hero-sub-item {
  display: flex;
  align-items: center;
  gap: 5px;
  flex: 1;
}
.sub-ic { flex-shrink: 0; }
.sub-ic.cyan  { color: #00e5ff; }
.sub-ic.amber { color: #ffb800; }
.sub-txt {
  font-size: 10.5px;
  color: rgba(255,255,255,0.36);
  flex: 1;
}
.sub-val { font-size: 12px; font-weight: 600; }
.sub-val.cyan  { color: #00e5ff; }
.sub-val.amber { color: #ffb800; }
.hero-sep-line {
  width: 1px; height: 22px;
  background: rgba(255,255,255,0.1);
}

/* Hero action buttons */
.hero-actions {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 8px;
}
.hero-act-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  background: none;
  border: none;
  cursor: pointer;
  -webkit-tap-highlight-color: transparent;
  transition: transform 0.2s;
}
.hero-act-btn:active { transform: scale(0.88); }
.hero-act-icon {
  width: 44px; height: 44px;
  border-radius: 14px;
  background: color-mix(in srgb, var(--hac) 13%, transparent);
  border: 1px solid color-mix(in srgb, var(--hac) 35%, transparent);
  display: flex; align-items: center; justify-content: center;
  color: var(--hac);
  box-shadow: 0 0 14px var(--hac-g), inset 0 1px 0 rgba(255,255,255,0.08);
  transform: perspective(80px) rotateX(8deg) rotateY(-5deg);
  transition: transform 0.22s cubic-bezier(0.34,1.56,0.64,1), box-shadow 0.22s;
}
.hero-act-btn:hover .hero-act-icon {
  transform: perspective(80px) rotateX(4deg) rotateY(-2deg) translateY(-3px);
  box-shadow: 0 0 22px var(--hac-g), inset 0 1px 0 rgba(255,255,255,0.1);
}
.hero-act-label {
  font-size: 11px;
  font-weight: 500;
  color: rgba(255,255,255,0.62);
  font-family: inherit;
}

/* ── Notice Bar ───────────────────────────────────────────────────────────────── */
.notice-bar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 9px 12px;
  border-radius: 12px;
  background: rgba(255,184,0,0.07);
  border: 1px solid rgba(255,184,0,0.18);
  margin-bottom: 16px;
  overflow: hidden;
  position: relative;
}
.notice-icon-wrap {
  flex-shrink: 0;
  color: #ffb800;
  display: flex;
  align-items: center;
}
.notice-track-outer {
  flex: 1;
  overflow: hidden;
}
.notice-track {
  display: flex;
  width: max-content;
  animation: marquee 28s linear infinite;
}
.notice-item {
  font-size: 11.5px;
  color: rgba(255,255,255,0.58);
  white-space: nowrap;
  padding-right: 48px;
}
@keyframes marquee {
  0%   { transform: translateX(0); }
  100% { transform: translateX(-50%); }
}
/* right fade */
.notice-fade-r {
  position: absolute;
  right: 0; top: 0; bottom: 0;
  width: 32px;
  background: linear-gradient(to right, transparent, rgba(8,12,24,0.85));
  pointer-events: none;
}

/* ── Quick Features ───────────────────────────────────────────────────────────── */
.quick-section {
  background: var(--bg-card);
  backdrop-filter: blur(24px);
  -webkit-backdrop-filter: blur(24px);
  border: 1px solid var(--border);
  border-radius: 20px;
  padding: 16px 12px 14px;
  margin-bottom: 14px;
}
.quick-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 6px 4px;
}
.quick-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  background: none;
  border: none;
  cursor: pointer;
  padding: 4px 2px;
  -webkit-tap-highlight-color: transparent;
  transition: transform 0.18s;
}
.quick-btn:active { transform: scale(0.87); }

.quick-icon-outer {
  position: relative;
  width: 48px; height: 48px;
  display: flex; align-items: center; justify-content: center;
}
.quick-ring {
  position: absolute;
  inset: -2px;
  border-radius: 50%;
  border: 1.5px solid var(--qc);
  opacity: 0;
  animation: quick-ring-out 2.2s ease-out infinite var(--qd, 0s);
}
@keyframes quick-ring-out {
  0%   { transform: scale(0.75); opacity: 0.7; }
  100% { transform: scale(1.25); opacity: 0;   }
}
.quick-icon-inner {
  width: 48px; height: 48px;
  border-radius: 16px;
  background: color-mix(in srgb, var(--qc) 12%, transparent);
  border: 1px solid color-mix(in srgb, var(--qc) 28%, transparent);
  display: flex; align-items: center; justify-content: center;
  color: var(--qc);
  transition: box-shadow 0.2s, transform 0.2s;
  position: relative; z-index: 1;
}
.quick-btn:hover .quick-icon-inner {
  box-shadow: 0 0 16px var(--qg);
  transform: translateY(-2px);
}
.quick-label {
  font-size: 11px;
  font-weight: 500;
  color: rgba(255,255,255,0.56);
  font-family: inherit;
  letter-spacing: 0.2px;
}

/* ── Promo Cards ──────────────────────────────────────────────────────────────── */
.promo-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 10px;
  margin-bottom: 18px;
}
.promo-card {
  position: relative;
  height: 98px;
  border-radius: 18px;
  overflow: hidden;
  background: var(--pb);
  border: 1px solid rgba(255,255,255,0.10);
  display: flex;
  align-items: center;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  padding: 14px 12px;
  gap: 8px;
}
.promo-card:hover  { transform: translateY(-3px); box-shadow: 0 10px 28px rgba(0,0,0,0.3); }
.promo-card:active { transform: scale(0.96); }

.promo-glow-el {
  position: absolute;
  inset: 0;
  background: var(--pg);
  pointer-events: none;
}
.promo-shimmer-el {
  position: absolute;
  top: 0; left: -100%; bottom: 0;
  width: 55%;
  background: linear-gradient(105deg, transparent, rgba(255,255,255,0.06), transparent);
  transform: skewX(-16deg);
  animation: promo-shim 4s ease-in-out infinite;
}
@keyframes promo-shim {
  0%,30%  { left: -100%; }
  70%,100%{ left: 130%;  }
}

.promo-content {
  position: relative;
  z-index: 1;
  flex: 1;
  min-width: 0;
}
.promo-tag {
  display: inline-block;
  font-size: 9px;
  font-weight: 700;
  letter-spacing: 0.5px;
  color: var(--ptc);
  background: color-mix(in srgb, var(--ptc) 15%, transparent);
  border: 1px solid color-mix(in srgb, var(--ptc) 35%, transparent);
  border-radius: 20px;
  padding: 2px 7px;
  margin-bottom: 6px;
}
.promo-title {
  font-size: 14px;
  font-weight: 700;
  color: #fff;
  letter-spacing: -0.3px;
  margin-bottom: 3px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.promo-sub {
  font-size: 10px;
  color: rgba(255,255,255,0.45);
  letter-spacing: 0.2px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.promo-icon-wrap {
  position: relative;
  z-index: 1;
  flex-shrink: 0;
  opacity: 0.28;
  animation: icon-float 3.5s ease-in-out infinite;
}
@keyframes icon-float {
  0%,100% { transform: translateY(0) rotate(-6deg); }
  50%     { transform: translateY(-5px) rotate(-2deg); }
}

/* ── Section Headers ──────────────────────────────────────────────────────────── */
.section-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 12px;
  padding: 0 2px;
}
.section-title {
  display: flex;
  align-items: center;
  gap: 7px;
  font-size: 14px;
  font-weight: 700;
  color: rgba(255,255,255,0.9);
  letter-spacing: -0.2px;
}
.section-ic-wrap {
  width: 24px; height: 24px;
  border-radius: 8px;
  display: flex; align-items: center; justify-content: center;
}
.flame-wrap {
  background: rgba(255,77,77,0.15);
  color: #ff4d4d;
  animation: flame-flicker 1.2s ease-in-out infinite;
}
@keyframes flame-flicker {
  0%,100% { box-shadow: 0 0 6px rgba(255,77,77,0.4); }
  50%     { box-shadow: 0 0 14px rgba(255,77,77,0.7); }
}
.grid-wrap {
  background: rgba(0,229,255,0.12);
  color: #00e5ff;
}
.view-all-btn {
  display: flex;
  align-items: center;
  gap: 2px;
  font-size: 11.5px;
  color: rgba(255,255,255,0.36);
  background: none;
  border: none;
  cursor: pointer;
  font-family: inherit;
  transition: color 0.18s;
}
.view-all-btn:hover { color: rgba(255,255,255,0.65); }

/* ── Hot Products Horizontal ──────────────────────────────────────────────────── */
.hot-scroll {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  padding-bottom: 4px;
  margin-bottom: 18px;
  scrollbar-width: none;
  -webkit-overflow-scrolling: touch;
}
.hot-scroll::-webkit-scrollbar { display: none; }

.hot-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  color: rgba(255,255,255,0.18);
  font-size: 12px;
  padding: 20px 0;
  width: 100%;
}

.hot-card {
  flex-shrink: 0;
  width: 120px;
  border-radius: 16px;
  background: var(--bg-card);
  border: 1px solid var(--border);
  overflow: hidden;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}
.hot-card:hover  { transform: translateY(-4px); box-shadow: 0 10px 28px rgba(0,0,0,0.35); }
.hot-card:active { transform: scale(0.95); }

.hot-img-area {
  position: relative;
  height: 100px;
  background: var(--hbg);
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}
.hot-img-glow {
  position: absolute;
  inset: 0;
  background: var(--hgl);
  pointer-events: none;
}
.hot-img-pic {
  width: 64px; height: 64px;
  object-fit: cover;
  border-radius: 12px;
  position: relative; z-index: 1;
}
.hot-icon-3d {
  position: relative; z-index: 1;
  width: 48px; height: 48px;
  border-radius: 14px;
  background: rgba(255,255,255,0.08);
  border: 1px solid rgba(255,255,255,0.12);
  display: flex; align-items: center; justify-content: center;
  color: rgba(255,255,255,0.85);
  transform: perspective(80px) rotateX(9deg) rotateY(-6deg);
  box-shadow: 2.5px 3.5px 0 rgba(0,0,0,0.28), 5px 7px 0 rgba(0,0,0,0.14);
  transition: transform 0.22s cubic-bezier(0.34,1.56,0.64,1);
}
.hot-card:hover .hot-icon-3d {
  transform: perspective(80px) rotateX(4deg) rotateY(-2deg) translateY(-3px);
}
.hot-tag {
  position: absolute;
  top: 7px; right: 7px;
  font-size: 8.5px;
  font-weight: 600;
  padding: 2px 6px;
  border-radius: 20px;
  border: 1px solid;
}

.hot-info {
  padding: 9px 10px 10px;
}
.hot-name {
  font-size: 11px;
  font-weight: 500;
  color: rgba(255,255,255,0.82);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-bottom: 4px;
}
.hot-price {
  font-size: 14px;
  font-weight: 700;
  letter-spacing: -0.2px;
}

/* ── Category Row ─────────────────────────────────────────────────────────────── */
.category-row {
  display: flex;
  gap: 7px;
  overflow-x: auto;
  padding-bottom: 4px;
  margin-bottom: 14px;
  scrollbar-width: none;
}
.category-row::-webkit-scrollbar { display: none; }
.cat-btn {
  display: flex;
  align-items: center;
  gap: 5px;
  padding: 6px 13px;
  border-radius: 20px;
  white-space: nowrap;
  background: rgba(255,255,255,0.05);
  border: 1px solid rgba(255,255,255,0.08);
  color: rgba(255,255,255,0.44);
  font-size: 11.5px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  font-family: inherit;
  flex-shrink: 0;
}
.cat-btn:hover { background: rgba(255,255,255,0.09); color: rgba(255,255,255,0.72); }
.cat-btn.active {
  background: color-mix(in srgb, var(--ac) 14%, transparent);
  border-color: var(--ac);
  color: var(--ac);
}

/* ── Product Grid ─────────────────────────────────────────────────────────────── */
.product-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 11px;
}
.product-card {
  overflow: hidden;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
}
.product-card:hover  { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(0,0,0,0.35); }
.product-card:active { transform: scale(0.97); }

.product-img {
  position: relative;
  height: 110px;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
}
.product-img-glow { position: absolute; inset: 0; pointer-events: none; }
.product-img-pic {
  position: relative; z-index: 1;
  width: 72px; height: 72px;
  object-fit: cover;
  border-radius: 14px;
}
.product-icon-3d {
  position: relative; z-index: 1;
  width: 52px; height: 52px;
  border-radius: 16px;
  background: rgba(255,255,255,0.08);
  border: 1px solid rgba(255,255,255,0.12);
  display: flex; align-items: center; justify-content: center;
  color: rgba(255,255,255,0.85);
  transform: perspective(100px) rotateX(10deg) rotateY(-7deg);
  box-shadow: 3px 4px 0 rgba(0,0,0,0.3), 6px 8px 0 rgba(0,0,0,0.15);
  transition: transform 0.25s cubic-bezier(0.34,1.56,0.64,1), box-shadow 0.25s;
}
.product-card:hover .product-icon-3d {
  transform: perspective(100px) rotateX(5deg) rotateY(-3deg) translateY(-4px);
  box-shadow: 5px 7px 0 rgba(0,0,0,0.3), 10px 14px 0 rgba(0,0,0,0.15);
}
.product-tag-badge {
  position: absolute;
  top: 8px; right: 8px;
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.4px;
  padding: 2px 7px;
  border-radius: 20px;
  border: 1px solid;
}

.product-info { padding: 11px 12px 13px; }
.product-name {
  font-size: 12px;
  font-weight: 500;
  color: rgba(255,255,255,0.82);
  margin-bottom: 5px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
.product-price  { font-size: 17px; font-weight: 700; margin-bottom: 5px; letter-spacing: -0.3px; }
.product-stock  {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 10px;
  color: rgba(255,255,255,0.27);
}

/* ── Misc ─────────────────────────────────────────────────────────────────────── */
.sentinel { height: 1px; }
.load-tip {
  text-align: center;
  padding: 16px 0;
  font-size: 12px;
  color: rgba(255,255,255,0.24);
  letter-spacing: 0.3px;
}
</style>
