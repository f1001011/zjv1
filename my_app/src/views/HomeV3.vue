<template>
  <div class="h3-root">

    <!-- ── Background ─────────────────────────────────────────────────────── -->
    <div class="bg-canvas">
      <div class="orb orb-r"></div>
      <div class="orb orb-c"></div>
      <div class="orb orb-a"></div>
      <div class="orb orb-l"></div>
    </div>
    <div class="bg-grid"></div>

    <div class="page-wrap">

      <!-- ── Header ─────────────────────────────────────────────────────── -->
      <header class="h3-header"
        v-motion :initial="{ opacity:0, y:-24 }"
        :enter="{ opacity:1, y:0, transition:{ delay:50 } }">
        <div class="logo-wrap">
          <div class="logo-icon"><Zap :size="15"/></div>
          <span class="logo-text">NEXUS</span>
          <span class="logo-badge">PRO</span>
        </div>
        <!-- Logged in header right -->
        <div v-if="isLoggedIn" class="header-right">
          <button class="glass-btn" @click="router.push('/balance')">
            <Bell :size="14"/>
            <span class="notif-dot"></span>
          </button>
        </div>
        <!-- Guest header right -->
        <div v-else class="header-right">
          <button class="glass-btn lang-btn" @click="toggleLang">
            <Globe :size="14"/>
            <span>{{ locale === 'zh' ? 'EN' : '中' }}</span>
          </button>
          <button class="glass-btn login-btn" @click="router.push('/login')">
            <LogIn :size="14"/>
            <span>{{ t('login.title') }}</span>
          </button>
        </div>
      </header>

      <!-- ── Hero Card ───────────────────────────────────────────────────── -->
      <div class="hero-card"
        v-motion :initial="{ opacity:0, y:44, scale:0.91 }"
        :enter="{ opacity:1, y:0, scale:1, transition:{ delay:110, type:'spring', stiffness:170, damping:19 } }">
        <div class="hero-border-el" aria-hidden="true"></div>
        <div class="hero-inner">
          <div class="hero-scan" aria-hidden="true"></div>
          <div class="hero-shimmer" aria-hidden="true"></div>

          <!-- ── Logged-in: balance card ── -->
          <template v-if="isLoggedIn">
            <div class="hero-label-row">
              <span class="hero-live-dot"></span>
              <span class="hero-status-txt">{{ t('home.balanceLabel') }}</span>
              <div class="hero-vip-chip"><Crown :size="9"/><span>VIP</span></div>
            </div>
            <div class="hero-balance-row">
              <span class="hero-currency">¥</span>
              <div class="hero-digits">
                <template v-for="(ch, ci) in integerChars" :key="ci">
                  <span v-if="ch === ','" class="digit-sep">{{ ch }}</span>
                  <div v-else class="digit-col">
                    <div class="digit-strip" :style="{ transform: `translateY(-${Number(ch) * 10}%)` }">
                      <span v-for="n in 10" :key="n">{{ n - 1 }}</span>
                    </div>
                  </div>
                </template>
                <span class="digit-dot">.</span>
                <span class="digit-dec">{{ decimalPart }}</span>
              </div>
            </div>
            <div class="hero-sub-row">
              <div class="hero-sub-item">
                <TrendingUp :size="11" class="sub-ic cyan"/>
                <span class="sub-txt">{{ t('home.todayEarnings') }}</span>
                <span class="sub-val cyan">+¥18.50</span>
              </div>
              <div class="hero-sep-line"></div>
              <div class="hero-sub-item">
                <Lock :size="11" class="sub-ic amber"/>
                <span class="sub-txt">{{ t('home.frozen') }}</span>
                <span class="sub-val amber">¥0.00</span>
              </div>
            </div>
            <div class="hero-actions">
              <button v-for="(act, ai) in heroActions" :key="act.key"
                class="hero-act-btn" :style="{ '--hac': act.color, '--hac-g': act.glow, '--had': `${ai * 0.3}s` }"
                @click="act.onClick">
                <div class="hero-act-icon">
                  <div class="hero-act-ring"></div>
                  <component :is="act.icon" :size="15"/>
                </div>
                <span class="hero-act-label">{{ act.label }}</span>
              </button>
            </div>
          </template>

          <!-- ── Guest: platform intro ── -->
          <template v-else>
            <div class="hero-status-row">
              <span class="hero-live-dot"></span>
              <span class="hero-status-txt">SYSTEM ONLINE</span>
              <div class="hero-version-chip">v3.0</div>
            </div>
            <div class="hero-title">
              <span class="hero-title-main">{{ t('home.heroTitle') }}</span>
              <span class="hero-title-sub">{{ t('home.heroSub') }}</span>
            </div>
            <div class="hero-stats">
              <div v-for="stat in heroStats" :key="stat.key" class="stat-item" :style="{ '--sc': stat.color }">
                <div class="stat-val">{{ stat.display }}<span class="stat-unit">{{ stat.unit }}</span></div>
                <div class="stat-label">{{ stat.label }}</div>
              </div>
            </div>
            <div class="hero-ctas">
              <button class="cta-primary" @click="router.push(isLoggedIn ? '/balance' : '/register')">
                <UserPlus :size="14"/>{{ isLoggedIn ? t('home.balanceCenter') : t('auth.toRegister') }}
              </button>
              <button class="cta-secondary" @click="router.push('/products')">
                <ShoppingBag :size="14"/>{{ t('home.browseProducts') }}
              </button>
            </div>
          </template>

        </div>
      </div>

      <!-- ── Notice Bar ──────────────────────────────────────────────────── -->
      <div class="notice-bar"
        v-motion :initial="{ opacity:0, y:10 }" :enter="{ opacity:1, y:0, transition:{ delay:230 } }">
        <div class="notice-icon-wrap"><Volume2 :size="11"/></div>
        <div class="notice-track-outer">
          <div class="notice-track">
            <span v-for="(msg, mi) in [...noticeList, ...noticeList]" :key="mi" class="notice-item">{{ msg }}</span>
          </div>
        </div>
        <div class="notice-fade-r"></div>
      </div>

      <!-- ── Promo Cards ─────────────────────────────────────────────────── -->
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

      <!-- ── Hot Products ────────────────────────────────────────────────── -->
      <div class="section-header"
        v-motion :initial="{ opacity:0 }" :enter="{ opacity:1, transition:{ delay:410 } }">
        <div class="section-title">
          <div class="section-ic-wrap flame-wrap"><Flame :size="12"/></div>
          {{ t('home.hotProducts') }}
        </div>
        <button class="view-all-btn" @click="router.push('/products')">
          {{ t('home.viewAll') }} <ChevronRight :size="11"/>
        </button>
      </div>

      <div class="hot-scroll"
        v-motion :initial="{ opacity:0, x:28 }" :enter="{ opacity:1, x:0, transition:{ delay:450 } }">
        <div v-if="hotProducts.length === 0" class="hot-empty">
          <Package :size="26"/><span>{{ t('home.noProducts') }}</span>
        </div>
        <div v-for="product in hotProducts" :key="product.id"
          class="hot-card"
          :style="{ '--hbg': product.gradient, '--hgl': product.glow }"
          @click="router.push(`/products/${product.id}`)">
          <div class="hot-img-area">
            <div class="hot-img-glow" aria-hidden="true"></div>
            <img v-if="product.imageUrl" :src="product.imageUrl" class="hot-img-pic"/>
            <div v-else class="hot-icon-3d"><component :is="product.icon" :size="24"/></div>
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

      <!-- ── All Products ────────────────────────────────────────────────── -->
      <div class="section-header" style="margin-top:6px"
        v-motion :initial="{ opacity:0 }" :enter="{ opacity:1, transition:{ delay:490 } }">
        <div class="section-title">
          <div class="section-ic-wrap grid-wrap"><LayoutGrid :size="12"/></div>
          {{ t('home.allProducts') }}
        </div>
      </div>

      <div class="category-row"
        v-motion :initial="{ opacity:0 }" :enter="{ opacity:1, transition:{ delay:530 } }">
        <button v-for="cat in displayCategories" :key="cat.key"
          :class="['cat-btn', { active: activeCategory === cat.key }]"
          :style="activeCategory === cat.key ? { '--ac': cat.color, borderColor: cat.color+'55' } : {}"
          @click="activeCategory = cat.key">
          <component :is="cat.icon" :size="11"/>
          {{ catLabel(cat) }}
        </button>
      </div>

      <div class="product-grid">
        <!-- skeleton -->
        <template v-if="isLoading && displayProducts.length === 0">
          <div v-for="n in 6" :key="'sk'+n" class="product-card glass-card product-skeleton">
            <div class="sk-img"></div>
            <div class="sk-info">
              <div class="sk-line sk-name"></div>
              <div class="sk-line sk-price"></div>
            </div>
          </div>
        </template>
        <!-- empty -->
        <div v-else-if="!isLoading && displayProducts.length === 0" class="products-empty">
          <Package :size="32"/><span>{{ t('home.noProducts') }}</span>
        </div>
        <div v-for="(product, i) in displayProducts" :key="product.id"
          class="product-card glass-card"
          v-motion
          :initial="{ opacity:0, y:26, scale:0.91 }"
          :enter="{ opacity:1, y:0, scale:1, transition:{ delay: Math.min(560 + i * 42, 1000), type:'spring', stiffness:260, damping:20 } }"
          @click="router.push(`/products/${product.id}`)">
          <div class="product-img" :style="{ background: product.gradient }">
            <div class="product-img-glow" :style="{ background: product.glow }"></div>
            <img v-if="product.imageUrl" class="product-img-pic" :src="product.imageUrl"/>
            <div v-else class="product-icon-3d"><component :is="product.icon" :size="26"/></div>
            <span v-if="product.tag" class="product-tag-badge"
              :style="{ color: product.tagColor, borderColor: product.tagColor+'44', background: product.tagColor+'1a' }">
              {{ product.tag }}
            </span>
          </div>
          <div class="product-info">
            <div class="product-name">{{ product.name }}</div>
            <div class="product-price" :style="{ color: product.priceColor }">¥{{ product.price }}</div>
            <div v-if="product.maxPurchase > 0" class="product-stock"><ShoppingBag :size="9"/>{{ t('home.purchasable', { n: product.maxPurchase }) }}</div>
          </div>
        </div>
      </div>

      <div ref="sentinel" class="sentinel"></div>
      <div v-if="isLoading" class="load-tip">{{ t('home.loadingMore') }}</div>
      <div v-else-if="!hasMore && displayProducts.length > 0" class="load-tip">{{ t('home.noMore') }}</div>
      <div style="height:80px"></div>

    </div>

    <!-- ── Intro Popup ─────────────────────────────────────────────────── -->
    <IntroPopup />

  </div>
</template>

<script lang="ts" setup>
import { ref, computed, onMounted, onUnmounted, watch, nextTick } from 'vue'
import type { Component } from 'vue'
import { colors } from '@/config/colors'
import { useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { setLocale } from '@/i18n'
import {
  Zap, Globe, LogIn, UserPlus, Volume2, X,
  Flame, ChevronRight, Package, LayoutGrid,
  ShoppingBag, Crown, Gift, User, Bell, TrendingUp, Lock,
  ArrowDownCircle, ArrowUpCircle, ArrowLeftRight, ClipboardList,
  Wifi, Phone, Gamepad2, Coffee, Star, ShoppingCart,
  CreditCard, Music, Signal, Sword, Gem, Car, Shield,
} from 'lucide-vue-next'
import { fetchGoodsTypes, fetchGoodsList } from '@/api/product'
import type { GoodsType, GoodsItem } from '@/types/product'
import { fetchUserInfo } from '@/api/auth'
import { userBalance, setUserBalance } from '@/stores/user'
import IntroPopup from '@/components/IntroPopup.vue'

const router = useRouter()
const { t, tm, locale } = useI18n()

const isLoggedIn = computed(() => !!localStorage.getItem('token'))

function toggleLang() {
  setLocale(locale.value === 'zh' ? 'en' : 'zh')
}

// ── Balance digit roller ───────────────────────────────────────────────────
const animatedBalance = ref(0)
let rollRaf: number | null = null
function startRoll(target: number) {
  if (rollRaf) cancelAnimationFrame(rollRaf)
  const dur = 2200, delay = 600, startAt = Date.now() + delay
  function ease(t: number) { return 1 - Math.pow(1 - t, 4) }
  function tick() {
    const now = Date.now()
    if (now < startAt) { rollRaf = requestAnimationFrame(tick); return }
    const p = Math.min((now - startAt) / dur, 1)
    animatedBalance.value = target * ease(p)
    if (p < 1) rollRaf = requestAnimationFrame(tick)
    else animatedBalance.value = target
  }
  rollRaf = requestAnimationFrame(tick)
}
const integerChars = computed(() => Math.floor(animatedBalance.value).toLocaleString('zh-CN').split(''))
const decimalPart  = computed(() => (animatedBalance.value % 1).toFixed(2).slice(2))
watch(userBalance, v => startRoll(v))

async function loadBalance() {
  if (!localStorage.getItem('token')) return
  try { const info = await fetchUserInfo(); setUserBalance(Number(info.money_balance) || 0) } catch { /* silent */ }
}

const heroActions = computed(() => [
  { key:'deposit',  label:t('home.deposit'),  icon:ArrowDownCircle, color:colors.red,   glow:colors.redGlow,   onClick:()=>router.push('/balance') },
  { key:'withdraw', label:t('home.withdraw'), icon:ArrowUpCircle,   color:colors.cyan,  glow:colors.cyanGlow,  onClick:()=>router.push('/balance') },
  { key:'transfer', label:t('home.transfer'), icon:ArrowLeftRight,  color:colors.amber, glow:colors.amberGlow, onClick:()=>router.push('/balance') },
  { key:'history',  label:t('home.history'),  icon:ClipboardList,   color:colors.lime,  glow:colors.limeGlow,  onClick:()=>router.push('/balance') },
])

// ── Hero stats counter ─────────────────────────────────────────────────────
const statValues = ref([0, 0, 0])
const STAT_TARGETS = [12800, 500, 99]

function animateStat(idx: number, target: number) {
  const dur = 1800, delay = 400 + idx * 200
  const start = Date.now() + delay
  function ease(t: number) { return 1 - Math.pow(1 - t, 3) }
  function tick() {
    const now = Date.now()
    if (now < start) { requestAnimationFrame(tick); return }
    const p = Math.min((now - start) / dur, 1)
    statValues.value[idx] = Math.round(target * ease(p))
    if (p < 1) requestAnimationFrame(tick)
  }
  requestAnimationFrame(tick)
}

const heroStats = computed(() => [
  { key: 'users',    label: t('home.statUsers'),    display: statValues.value[0].toLocaleString(), unit: '+', color: colors.cyan  },
  { key: 'products', label: t('home.statProducts'), display: statValues.value[1].toLocaleString(), unit: '+', color: colors.amber },
  { key: 'rating',   label: t('home.statRating'),   display: statValues.value[2],                  unit: '%', color: colors.lime  },
])

// ── Notice ─────────────────────────────────────────────────────────────────
const noticeList = computed(() => tm('home.notices') as string[])

// ── Quick features ─────────────────────────────────────────────────────────
const quickFeatures = computed((): Array<{ key:string; label:string; icon:Component; color:string; glow:string; onClick:()=>void }> => [
  { key:'data',   label:t('home.feat.data'),   icon:Wifi,         color:colors.cyan,  glow:colors.cyanGlow,  onClick:()=>router.push('/products') },
  { key:'phone',  label:t('home.feat.phone'),  icon:Phone,        color:colors.amber, glow:colors.amberGlow, onClick:()=>router.push('/products') },
  { key:'member', label:t('home.feat.member'), icon:Crown,        color:colors.red,   glow:colors.redGlow,   onClick:()=>router.push('/vip') },
  { key:'game',   label:t('home.feat.game'),   icon:Gamepad2,     color:colors.lime,  glow:colors.limeGlow,  onClick:()=>router.push('/products') },
  { key:'vip',    label:'VIP',                 icon:Star,         color:colors.amber, glow:colors.amberGlow, onClick:()=>router.push('/vip') },
  { key:'shop',   label:t('home.feat.shop'),   icon:ShoppingCart, color:colors.red,   glow:colors.redGlow,   onClick:()=>router.push('/products') },
  { key:'coffee', label:t('home.feat.life'),   icon:Coffee,       color:colors.cyan,  glow:colors.cyanGlow,  onClick:()=>router.push('/products') },
  { key:'more',   label:t('home.feat.more'),   icon:LayoutGrid,   color:'rgba(255,255,255,0.45)', glow:'rgba(255,255,255,0.15)', onClick:()=>{} },
])

// ── Promo cards ────────────────────────────────────────────────────────────
const promoCards = computed(() => [
  {
    tag:t('home.promo1.tag'), title:t('home.promo1.title'), sub:t('home.promo1.sub'),
    bg:'linear-gradient(135deg,rgba(255,77,77,0.22),rgba(255,23,68,0.12))',
    glow:'radial-gradient(circle at 20% 50%,rgba(255,77,77,0.4),transparent 65%)',
    tagColor:colors.red, icon:Gift, onClick:()=>router.push(isLoggedIn.value ? '/balance' : '/register'),
  },
  {
    tag:t('home.promo2.tag'), title:t('home.promo2.title'), sub:t('home.promo2.sub'),
    bg:'linear-gradient(135deg,rgba(255,184,0,0.20),rgba(255,109,0,0.10))',
    glow:'radial-gradient(circle at 20% 50%,rgba(255,184,0,0.38),transparent 65%)',
    tagColor:colors.amber, icon:Crown, onClick:()=>router.push('/vip'),
  },
])

// ── Icon / visual maps ─────────────────────────────────────────────────────
const ICON_MAP: Record<string,Component> = {
  layoutgrid:LayoutGrid, wifi:Wifi, phone:Phone, crown:Crown,
  gamepad2:Gamepad2, coffee:Coffee, signal:Signal, creditcard:CreditCard,
  music:Music, star:Star, sword:Sword, gem:Gem, shoppingcart:ShoppingCart, car:Car,
}
const COLOR_MAP: Record<string,string> = {
  red:colors.red, cyan:colors.cyan, amber:colors.amber, green:colors.lime,
}
const VISUAL_LIST = [
  { gradient:'linear-gradient(160deg,rgba(0,229,255,0.15),rgba(0,176,255,0.07))',  glow:'radial-gradient(circle at 60% 40%,rgba(0,229,255,0.28),transparent 65%)',  priceColor:'#00e5ff' },
  { gradient:'linear-gradient(160deg,rgba(255,184,0,0.15),rgba(255,109,0,0.07))',  glow:'radial-gradient(circle at 60% 40%,rgba(255,184,0,0.28),transparent 65%)',  priceColor:'#ffb800' },
  { gradient:'linear-gradient(160deg,rgba(105,255,71,0.13),rgba(0,230,118,0.07))', glow:'radial-gradient(circle at 60% 40%,rgba(105,255,71,0.24),transparent 65%)', priceColor:'#69ff47' },
  { gradient:'linear-gradient(160deg,rgba(255,77,77,0.15),rgba(255,23,68,0.07))',  glow:'radial-gradient(circle at 60% 40%,rgba(255,77,77,0.28),transparent 65%)',  priceColor:'#ff4d4d' },
  { gradient:'linear-gradient(160deg,rgba(0,229,255,0.13),rgba(0,176,255,0.07))',  glow:'radial-gradient(circle at 60% 40%,rgba(0,229,255,0.24),transparent 65%)',  priceColor:'#00e5ff' },
]
const ICON_LIST  = Object.values(ICON_MAP)
const COLOR_LIST = Object.values(COLOR_MAP)
const TAG_COLOR: Record<string,string> = {
  '热门':colors.red, '推荐':colors.lime, '爆款':colors.amber, '超值':colors.amber, '精选':colors.lime,
}

// ── Categories ─────────────────────────────────────────────────────────────
const activeCategory = ref(0)
const categoriesRaw  = ref<GoodsType[]>([])

const displayCategories = computed(() => [
  { key:0, labelZh:t('home.allCategory'), labelEn:t('home.allCategory'), icon:LayoutGrid, color:'#ff4d4d' },
  ...categoriesRaw.value.map((cat, i) => ({
    key:cat.id, labelZh:cat.type_name, labelEn:cat.type_name,
    icon:ICON_LIST[i % ICON_LIST.length] ?? LayoutGrid,
    color:COLOR_LIST[i % COLOR_LIST.length] ?? '#ff4d4d',
  })),
])

function catLabel(cat: { labelZh:string; labelEn:string }) {
  return locale.value === 'zh' ? cat.labelZh : cat.labelEn
}

// ── Products ───────────────────────────────────────────────────────────────
const productList = ref<GoodsItem[]>([])
const page        = ref(1)
const hasMore     = ref(true)
const isLoading   = ref(false)
const PAGE_SIZE   = 10

const displayProducts = computed(() =>
  productList.value.map((p, i) => {
    const v = VISUAL_LIST[i % VISUAL_LIST.length]
    return {
      id: p.id, name: p.goods_name, price: p.goods_money,
      maxPurchase: p.buy_num, imageUrl: p.head_img ?? undefined,
      tag: p.is_examine === 1 ? '新手' : '',
      icon: Wifi, gradient: v.gradient, glow: v.glow, priceColor: v.priceColor,
      tagColor: p.is_examine === 1 ? (TAG_COLOR['推荐'] ?? '') : '',
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
  } catch { hasMore.value = false }
  finally { isLoading.value = false }
}

const sentinel = ref<HTMLElement | null>(null)
let observer: IntersectionObserver | null = null

function setupObserver() {
  if (observer) observer.disconnect()
  observer = new IntersectionObserver(
    entries => { if (entries[0].isIntersecting && hasMore.value && !isLoading.value) loadProducts() },
    { rootMargin: '120px' }
  )
  if (sentinel.value) observer.observe(sentinel.value)
}

watch(activeCategory, () => loadProducts(true).then(() => nextTick(setupObserver)))

onMounted(async () => {
  STAT_TARGETS.forEach((t, i) => animateStat(i, t))
  await Promise.all([
    fetchGoodsTypes().then(r => { categoriesRaw.value = r }).catch(() => {}),
    loadProducts(true),
    loadBalance(),
  ])
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

.h3-root {
  min-height: 100vh;
  background: var(--bg-base);
  position: relative;
  overflow: hidden;
  font-family: 'Inter','SF Pro Text',-apple-system,BlinkMacSystemFont,'PingFang SC','Noto Sans SC',sans-serif;
  -webkit-font-smoothing: antialiased;
}

/* ── Background ─────────────────────────────────────────────────────────── */
.bg-canvas { position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.orb { position: absolute; border-radius: 50%; filter: blur(88px); will-change: transform; }
.orb-r { width:500px; height:500px; top:-120px;  left:-100px;  background:var(--orb-red);   animation:drift 16s ease-in-out infinite; }
.orb-c { width:420px; height:420px; top:28%;     right:-70px;  background:var(--orb-cyan);  animation:drift 21s ease-in-out infinite reverse 2s; }
.orb-a { width:360px; height:360px; bottom:8%;   left:10%;     background:var(--orb-amber); animation:drift 25s ease-in-out infinite 6s; }
.orb-l { width:280px; height:280px; bottom:30%;  right:-40px;  background:rgba(105,255,71,0.18); animation:drift 19s ease-in-out infinite reverse 4s; }

@keyframes drift {
  0%,100% { transform:translate(0,0) scale(1); }
  33%     { transform:translate(22px,-16px) scale(1.04); }
  66%     { transform:translate(-14px,12px) scale(0.97); }
}

.bg-grid {
  position: fixed; inset: 0; pointer-events: none; z-index: 0;
  background-image: radial-gradient(circle, rgba(255,255,255,0.055) 1px, transparent 1px);
  background-size: 28px 28px;
  mask-image: radial-gradient(ellipse 80% 80% at 50% 50%, black 40%, transparent 100%);
}

/* ── Page wrap ──────────────────────────────────────────────────────────── */
.page-wrap {
  position: relative; z-index: 1;
  max-width: 460px; margin: 0 auto;
  padding: 0 14px;
}

/* ── Header ─────────────────────────────────────────────────────────────── */
.h3-header {
  display: flex; align-items: center; justify-content: space-between;
  padding: 14px 0 10px;
}
.logo-wrap { display: flex; align-items: center; gap: 7px; }
.logo-icon {
  width: 28px; height: 28px; border-radius: 8px;
  background: linear-gradient(135deg, #ff4d4d, #ff1744);
  display: flex; align-items: center; justify-content: center;
  color: #fff;
  box-shadow: 0 0 12px rgba(255,77,77,0.5);
}
.logo-text { font-size: 17px; font-weight: 800; letter-spacing: 2px; color: #fff; }
.logo-badge {
  font-size: 9px; font-weight: 700; letter-spacing: 1px;
  padding: 2px 5px; border-radius: 4px;
  background: linear-gradient(135deg, #ffb800, #ff6d00);
  color: #fff;
}
.header-right { display: flex; gap: 8px; }
.glass-btn {
  display: flex; align-items: center; gap: 5px;
  padding: 6px 11px; border-radius: 20px; border: none; cursor: pointer;
  background: rgba(255,255,255,0.08);
  backdrop-filter: blur(12px);
  border: 1px solid rgba(255,255,255,0.13);
  color: rgba(255,255,255,0.85); font-size: 12px;
  transition: background 0.2s;
}
.glass-btn:hover { background: rgba(255,255,255,0.14); }
.login-btn { background: rgba(255,77,77,0.18); border-color: rgba(255,77,77,0.35); color: #ff6b6b; }
.login-btn:hover { background: rgba(255,77,77,0.28); }

/* ── Hero Card ──────────────────────────────────────────────────────────── */
.hero-card {
  position: relative; border-radius: 22px; margin: 6px 0 14px;
  overflow: hidden;
}
.hero-border-el {
  position: absolute; inset: -100%; border-radius: inherit;
  background: conic-gradient(from 0deg, #ff4d4d, #ffb800, #00e5ff, #69ff47, #ff4d4d);
  animation: border-spin 5s linear infinite;
  z-index: 0;
}
@keyframes border-spin { to { transform: rotate(360deg); } }

.hero-inner {
  position: relative; z-index: 1; margin: 2px; border-radius: 20px;
  background: rgba(8,12,24,0.82);
  backdrop-filter: blur(28px);
  border: 1px solid rgba(255,255,255,0.08);
  padding: 20px 18px 18px;
  overflow: hidden;
}
.hero-scan {
  position: absolute; left: 0; right: 0; height: 2px;
  background: linear-gradient(90deg, transparent, rgba(0,229,255,0.7), transparent);
  animation: scan-line 3.5s linear infinite;
  pointer-events: none;
}
@keyframes scan-line {
  0%   { top: -2px; opacity: 0; }
  10%  { opacity: 1; }
  90%  { opacity: 1; }
  100% { top: 100%; opacity: 0; }
}
.hero-shimmer {
  position: absolute; top: 0; bottom: 0; width: 60%;
  background: linear-gradient(105deg, transparent 30%, rgba(255,255,255,0.04) 50%, transparent 70%);
  animation: hero-shim 5s ease-in-out infinite;
  pointer-events: none;
}
@keyframes hero-shim {
  0%,100% { left: -60%; }
  50%     { left: 100%; }
}

.hero-status-row { display: flex; align-items: center; gap: 7px; margin-bottom: 14px; }
.hero-live-dot {
  width: 7px; height: 7px; border-radius: 50%;
  background: #69ff47;
  box-shadow: 0 0 8px rgba(105,255,71,0.8);
  animation: live-pulse 1.4s ease-in-out infinite;
}
@keyframes live-pulse {
  0%,100% { transform: scale(1); opacity: 1; }
  50%     { transform: scale(1.35); opacity: 0.7; }
}
.hero-status-txt { font-size: 10px; font-weight: 700; letter-spacing: 2px; color: rgba(105,255,71,0.9); }
.hero-version-chip {
  margin-left: auto; font-size: 9px; font-weight: 700; letter-spacing: 1px;
  padding: 2px 7px; border-radius: 10px;
  background: rgba(0,229,255,0.12); border: 1px solid rgba(0,229,255,0.25);
  color: #00e5ff;
}

.hero-title { margin-bottom: 18px; }
.hero-title-main {
  display: block; font-size: 22px; font-weight: 800; letter-spacing: 0.5px;
  color: #fff; line-height: 1.2; margin-bottom: 5px;
}
.hero-title-sub { font-size: 12px; color: rgba(255,255,255,0.45); }

/* Stats */
.hero-stats {
  display: flex; gap: 0; margin-bottom: 18px;
  border: 1px solid rgba(255,255,255,0.08); border-radius: 14px;
  overflow: hidden;
}
.stat-item {
  flex: 1; padding: 12px 8px; text-align: center;
  border-right: 1px solid rgba(255,255,255,0.07);
  position: relative;
}
.stat-item:last-child { border-right: none; }
.stat-val {
  font-size: 18px; font-weight: 800; color: var(--sc);
  text-shadow: 0 0 12px var(--sc);
  line-height: 1;
}
.stat-unit { font-size: 11px; font-weight: 600; }
.stat-label { font-size: 10px; color: rgba(255,255,255,0.4); margin-top: 4px; }

/* CTA */
.hero-ctas { display: flex; gap: 10px; }
.cta-primary {
  flex: 1; display: flex; align-items: center; justify-content: center; gap: 6px;
  padding: 11px; border-radius: 12px; border: none; cursor: pointer;
  background: linear-gradient(135deg, #ff4d4d, #ff1744);
  color: #fff; font-size: 13px; font-weight: 700;
  box-shadow: 0 4px 16px rgba(255,77,77,0.4);
  transition: transform 0.15s, box-shadow 0.15s;
}
.cta-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(255,77,77,0.55); }
.cta-secondary {
  flex: 1; display: flex; align-items: center; justify-content: center; gap: 6px;
  padding: 11px; border-radius: 12px; cursor: pointer;
  background: rgba(255,255,255,0.07);
  border: 1px solid rgba(255,255,255,0.15);
  color: rgba(255,255,255,0.8); font-size: 13px; font-weight: 600;
  transition: background 0.15s;
}
.cta-secondary:hover { background: rgba(255,255,255,0.12); }

/* ── Notice Bar ─────────────────────────────────────────────────────────── */
.notice-bar {
  display: flex; align-items: center; gap: 8px;
  background: rgba(255,255,255,0.05);
  border: 1px solid rgba(255,255,255,0.09);
  border-radius: 10px; padding: 7px 10px;
  margin-bottom: 14px; overflow: hidden; position: relative;
}
.notice-icon-wrap { color: #ffb800; flex-shrink: 0; }
.notice-track-outer { flex: 1; overflow: hidden; }
.notice-track {
  display: flex; gap: 40px; white-space: nowrap;
  animation: marquee 28s linear infinite;
}
.notice-item { font-size: 11px; color: rgba(255,255,255,0.55); flex-shrink: 0; }
@keyframes marquee { 0% { transform: translateX(0); } 100% { transform: translateX(-50%); } }
.notice-fade-r {
  position: absolute; right: 0; top: 0; bottom: 0; width: 40px;
  background: linear-gradient(to left, rgba(8,12,24,0.9), transparent);
  pointer-events: none;
}

/* ── Quick Features ─────────────────────────────────────────────────────── */
.quick-section { margin-bottom: 14px; }
.quick-grid { display: grid; grid-template-columns: repeat(4,1fr); gap: 8px; }
.quick-btn {
  display: flex; flex-direction: column; align-items: center; gap: 6px;
  background: none; border: none; cursor: pointer; padding: 8px 4px;
}
.quick-icon-outer {
  position: relative; width: 46px; height: 46px;
  display: flex; align-items: center; justify-content: center;
}
.quick-ring {
  position: absolute; inset: 0; border-radius: 50%;
  border: 1.5px solid var(--qc);
  opacity: 0; transform: scale(0.75);
  animation: quick-ring-out 2.2s ease-out infinite;
  animation-delay: var(--qd);
}
@keyframes quick-ring-out {
  0%   { transform: scale(0.75); opacity: 0.7; }
  100% { transform: scale(1.25); opacity: 0; }
}
.quick-icon-inner {
  width: 42px; height: 42px; border-radius: 14px;
  background: rgba(255,255,255,0.06);
  border: 1px solid rgba(255,255,255,0.1);
  display: flex; align-items: center; justify-content: center;
  color: var(--qc);
  box-shadow: 0 0 10px var(--qg);
  transition: transform 0.18s, box-shadow 0.18s;
}
.quick-btn:hover .quick-icon-inner { transform: translateY(-3px); box-shadow: 0 4px 16px var(--qg); }
.quick-label { font-size: 11px; color: rgba(255,255,255,0.6); }

/* ── Promo Cards ────────────────────────────────────────────────────────── */
.promo-row { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 14px; }
.promo-card {
  position: relative; border-radius: 16px; padding: 14px 12px;
  background: var(--pb); overflow: hidden; cursor: pointer;
  border: 1px solid rgba(255,255,255,0.09);
  transition: transform 0.18s;
}
.promo-card:hover { transform: translateY(-3px); }
.promo-glow-el {
  position: absolute; inset: 0; background: var(--pg); pointer-events: none;
}
.promo-shimmer-el {
  position: absolute; top: 0; bottom: 0; width: 50%;
  background: linear-gradient(105deg, transparent 30%, rgba(255,255,255,0.06) 50%, transparent 70%);
  animation: promo-shim 4s ease-in-out infinite;
  pointer-events: none;
}
@keyframes promo-shim { 0%,100% { left:-50%; } 50% { left:100%; } }
.promo-content { position: relative; z-index: 1; }
.promo-tag { font-size: 9px; font-weight: 700; color: var(--ptc); margin-bottom: 5px; letter-spacing: 0.5px; }
.promo-title { font-size: 13px; font-weight: 700; color: #fff; margin-bottom: 3px; }
.promo-sub { font-size: 10px; color: rgba(255,255,255,0.45); }
.promo-icon-wrap {
  position: absolute; right: 8px; bottom: 8px;
  color: rgba(255,255,255,0.15);
  animation: icon-float 3.5s ease-in-out infinite;
}
@keyframes icon-float {
  0%,100% { transform: translateY(0) rotate(0deg); }
  50%     { transform: translateY(-5px) rotate(4deg); }
}

/* ── Section header ─────────────────────────────────────────────────────── */
.section-header {
  display: flex; align-items: center; justify-content: space-between;
  margin-bottom: 10px;
}
.section-title {
  display: flex; align-items: center; gap: 6px;
  font-size: 13px; font-weight: 700; color: rgba(255,255,255,0.88);
}
.section-ic-wrap {
  width: 22px; height: 22px; border-radius: 7px;
  display: flex; align-items: center; justify-content: center;
}
.flame-wrap { background: rgba(255,77,77,0.2); color: #ff4d4d; animation: flame-flicker 1.2s ease-in-out infinite; }
@keyframes flame-flicker { 0%,100% { opacity:1; } 50% { opacity:0.6; } }
.grid-wrap { background: rgba(0,229,255,0.15); color: #00e5ff; }
.view-all-btn {
  display: flex; align-items: center; gap: 2px;
  font-size: 11px; color: rgba(255,255,255,0.4);
  background: none; border: none; cursor: pointer;
  transition: color 0.15s;
}
.view-all-btn:hover { color: rgba(255,255,255,0.7); }

/* ── Hot scroll ─────────────────────────────────────────────────────────── */
.hot-scroll {
  display: flex; gap: 10px; overflow-x: auto; padding-bottom: 6px; margin-bottom: 14px;
  scrollbar-width: none;
}
.hot-scroll::-webkit-scrollbar { display: none; }
.hot-empty { display: flex; flex-direction: column; align-items: center; gap: 6px; padding: 20px; color: rgba(255,255,255,0.3); font-size: 12px; }
.hot-card {
  flex-shrink: 0; width: 110px; border-radius: 14px; overflow: hidden; cursor: pointer;
  background: var(--hbg); border: 1px solid rgba(255,255,255,0.08);
  transition: transform 0.18s;
}
.hot-card:hover { transform: translateY(-3px); }
.hot-img-area { position: relative; height: 80px; display: flex; align-items: center; justify-content: center; overflow: hidden; }
.hot-img-glow { position: absolute; inset: 0; background: var(--hgl); pointer-events: none; }
.hot-img-pic { width: 100%; height: 100%; object-fit: cover; }
.hot-icon-3d {
  color: rgba(255,255,255,0.7);
  transform: perspective(100px) rotateX(8deg) rotateY(-6deg);
  filter: drop-shadow(2px 3px 0 rgba(0,0,0,0.3));
}
.hot-tag {
  position: absolute; top: 5px; right: 5px;
  font-size: 9px; font-weight: 700; padding: 2px 5px; border-radius: 5px;
  border: 1px solid;
}
.hot-info { padding: 7px 8px; }
.hot-name { font-size: 11px; color: rgba(255,255,255,0.8); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin-bottom: 3px; }
.hot-price { font-size: 12px; font-weight: 700; }

/* ── Category row ───────────────────────────────────────────────────────── */
.category-row { display: flex; gap: 7px; overflow-x: auto; padding-bottom: 4px; margin-bottom: 12px; scrollbar-width: none; }
.category-row::-webkit-scrollbar { display: none; }
.cat-btn {
  flex-shrink: 0; display: flex; align-items: center; gap: 4px;
  padding: 5px 11px; border-radius: 20px; font-size: 11px; cursor: pointer;
  background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.1);
  color: rgba(255,255,255,0.55); transition: all 0.18s;
}
.cat-btn.active { background: rgba(var(--ac-rgb,255,77,77),0.15); color: var(--ac,#ff4d4d); font-weight: 600; }

/* ── Product grid ───────────────────────────────────────────────────────── */
.product-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
.products-empty { grid-column: 1/-1; display: flex; flex-direction: column; align-items: center; gap: 8px; padding: 40px 0; color: rgba(255,255,255,0.25); font-size: 12px; }
.product-skeleton { pointer-events: none; }
.sk-img { height: 110px; border-radius: 12px; background: rgba(255,255,255,0.06); overflow: hidden; position: relative; }
.sk-info { padding: 10px; display: flex; flex-direction: column; gap: 6px; }
.sk-line { border-radius: 6px; background: rgba(255,255,255,0.06); overflow: hidden; position: relative; }
.sk-name { height: 12px; width: 80%; }
.sk-price { height: 11px; width: 45%; }
.sk-img::after, .sk-line::after {
  content: ''; position: absolute; inset: 0;
  background: linear-gradient(90deg, transparent 0%, rgba(255,255,255,0.07) 50%, transparent 100%);
  animation: sk-shimmer 1.4s infinite;
}
@keyframes sk-shimmer { 0% { transform: translateX(-100%); } 100% { transform: translateX(100%); } }
.product-card {
  border-radius: 16px; overflow: hidden; cursor: pointer;
  background: var(--bg-card);
  backdrop-filter: blur(20px);
  border: 1px solid var(--border);
  transition: transform 0.18s, box-shadow 0.18s;
}
.product-card:hover { transform: translateY(-3px); box-shadow: 0 8px 24px rgba(0,0,0,0.3); }
.product-img { position: relative; height: 100px; display: flex; align-items: center; justify-content: center; overflow: hidden; }
.product-img-glow { position: absolute; inset: 0; pointer-events: none; }
.product-img-pic { width: 100%; height: 100%; object-fit: cover; }
.product-icon-3d {
  color: rgba(255,255,255,0.75);
  transform: perspective(100px) rotateX(10deg) rotateY(-7deg);
  box-shadow: 3px 4px 0 rgba(0,0,0,0.32), 6px 8px 0 rgba(0,0,0,0.16);
}
.product-tag-badge {
  position: absolute; top: 6px; right: 6px;
  font-size: 9px; font-weight: 700; padding: 2px 5px; border-radius: 5px; border: 1px solid;
}
.product-info { padding: 9px 10px; }
.product-name { font-size: 12px; color: rgba(255,255,255,0.82); margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.product-price { font-size: 14px; font-weight: 700; margin-bottom: 4px; }
.product-stock { display: flex; align-items: center; gap: 3px; font-size: 10px; color: rgba(255,255,255,0.35); }

.sentinel { height: 1px; }
.load-tip { text-align: center; font-size: 11px; color: rgba(255,255,255,0.3); padding: 12px 0; }

/* ── Balance card (logged-in hero) ──────────────────────────────────────── */
.hero-label-row { display: flex; align-items: center; gap: 7px; margin-bottom: 10px; }
.hero-vip-chip {
  margin-left: auto; display: flex; align-items: center; gap: 3px;
  font-size: 9px; font-weight: 700; padding: 2px 7px; border-radius: 10px;
  background: rgba(255,184,0,0.15); border: 1px solid rgba(255,184,0,0.3); color: #ffb800;
}
.hero-balance-row { display: flex; align-items: baseline; gap: 4px; margin-bottom: 12px; }
.hero-currency { font-size: 18px; font-weight: 700; color: rgba(255,255,255,0.7); }
.hero-digits { display: flex; align-items: baseline; gap: 1px; }
.digit-col { width: 22px; height: 32px; overflow: hidden; }
.digit-strip {
  display: flex; flex-direction: column;
  transition: transform 0.8s cubic-bezier(0.34,1.45,0.64,1);
}
.digit-strip span { height: 32px; line-height: 32px; font-size: 26px; font-weight: 800; color: #fff; text-align: center; }
.digit-sep { font-size: 22px; font-weight: 700; color: rgba(255,255,255,0.5); padding: 0 1px; }
.digit-dot { font-size: 20px; font-weight: 700; color: rgba(255,255,255,0.5); padding: 0 1px; }
.digit-dec { font-size: 18px; font-weight: 600; color: rgba(255,255,255,0.6); }
.hero-sub-row { display: flex; align-items: center; gap: 10px; margin-bottom: 14px; padding: 8px 10px; background: rgba(255,255,255,0.04); border-radius: 10px; }
.hero-sub-item { display: flex; align-items: center; gap: 4px; flex: 1; }
.sub-ic { flex-shrink: 0; }
.sub-ic.cyan { color: #00e5ff; }
.sub-ic.amber { color: #ffb800; }
.sub-txt { font-size: 10px; color: rgba(255,255,255,0.4); }
.sub-val { font-size: 11px; font-weight: 700; margin-left: auto; }
.sub-val.cyan { color: #00e5ff; }
.sub-val.amber { color: #ffb800; }
.hero-sep-line { width: 1px; height: 24px; background: rgba(255,255,255,0.1); }
.hero-actions { display: flex; gap: 8px; }
.hero-act-btn {
  flex: 1; display: flex; flex-direction: column; align-items: center; gap: 5px;
  padding: 9px 4px; border-radius: 12px; border: none; cursor: pointer;
  background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.1);
  transition: transform 0.15s;
}
.hero-act-btn:hover { transform: translateY(-2px); }
.hero-act-icon {
  position: relative;
  width: 32px; height: 32px; border-radius: 10px; display: flex; align-items: center; justify-content: center;
  background: rgba(255,255,255,0.08); color: var(--hac);
  box-shadow: 0 0 10px var(--hac-g);
}
.hero-act-ring {
  position: absolute; inset: -5px; border-radius: 14px;
  border: 1.5px solid var(--hac); opacity: 0; transform: scale(0.8);
  animation: hero-act-ring-out 2.4s ease-out infinite;
  animation-delay: var(--had);
}
@keyframes hero-act-ring-out {
  0%   { transform: scale(0.8); opacity: 0.65; }
  100% { transform: scale(1.4); opacity: 0; }
}
.hero-act-label { font-size: 10px; color: rgba(255,255,255,0.6); }

/* ── Notification dot ───────────────────────────────────────────────────── */
.notif-btn { position: relative; }
.notif-dot {
  position: absolute; top: 4px; right: 4px; width: 6px; height: 6px; border-radius: 50%;
  background: #ff4d4d; box-shadow: 0 0 6px rgba(255,77,77,0.8);
  animation: notif-pulse 1.8s ease-in-out infinite;
}
@keyframes notif-pulse { 0%,100% { transform:scale(1); opacity:1; } 50% { transform:scale(1.4); opacity:0.6; } }

/* ── Intro Popup ────────────────────────────────────────────────────────── */
.intro-overlay {
  position: fixed; inset: 0; z-index: 100;
  background: rgba(0,0,0,0.65);
  backdrop-filter: blur(8px);
  display: flex; align-items: center; justify-content: center;
  padding: 20px;
}
.intro-modal { position: relative; width: 100%; max-width: 340px; border-radius: 24px; overflow: hidden; }
.intro-border-el {
  position: absolute; inset: -100%; border-radius: inherit;
  background: conic-gradient(from 0deg, #ff4d4d, #ffb800, #00e5ff, #69ff47, #ff4d4d);
  animation: border-spin 5s linear infinite; z-index: 0;
}
.intro-inner {
  position: relative; z-index: 1; margin: 2px; border-radius: 22px;
  background: rgba(8,12,24,0.95);
  backdrop-filter: blur(32px);
  padding: 24px 20px 20px;
}
.intro-close {
  position: absolute; top: 14px; right: 14px;
  width: 28px; height: 28px; border-radius: 50%; border: none; cursor: pointer;
  background: rgba(255,255,255,0.08); color: rgba(255,255,255,0.5);
  display: flex; align-items: center; justify-content: center;
  transition: background 0.15s;
}
.intro-close:hover { background: rgba(255,255,255,0.15); }
.intro-logo { display: flex; align-items: center; gap: 10px; margin-bottom: 6px; }
.intro-logo-icon {
  width: 40px; height: 40px; border-radius: 12px;
  background: linear-gradient(135deg, #ff4d4d, #ff1744);
  display: flex; align-items: center; justify-content: center; color: #fff;
  box-shadow: 0 0 16px rgba(255,77,77,0.5);
}
.intro-logo-name { font-size: 20px; font-weight: 800; letter-spacing: 2px; color: #fff; }
.intro-tagline { font-size: 11px; color: rgba(255,255,255,0.4); margin-bottom: 20px; }
.intro-features { display: flex; flex-direction: column; gap: 12px; margin-bottom: 20px; }
.intro-feat {
  display: flex; align-items: center; gap: 12px;
  padding: 10px 12px; border-radius: 12px;
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.07);
}
.intro-feat-icon {
  width: 36px; height: 36px; border-radius: 10px; flex-shrink: 0;
  display: flex; align-items: center; justify-content: center;
  background: rgba(255,255,255,0.06); color: var(--fc);
  box-shadow: 0 0 10px color-mix(in srgb, var(--fc) 40%, transparent);
}
.intro-feat-title { font-size: 13px; font-weight: 700; color: #fff; margin-bottom: 2px; }
.intro-feat-sub { font-size: 11px; color: rgba(255,255,255,0.4); }
.intro-start-btn {
  width: 100%; display: flex; align-items: center; justify-content: center; gap: 7px;
  padding: 13px; border-radius: 14px; border: none; cursor: pointer;
  background: linear-gradient(135deg, #ff4d4d, #ff1744);
  color: #fff; font-size: 14px; font-weight: 700;
  box-shadow: 0 4px 20px rgba(255,77,77,0.45);
  transition: transform 0.15s, box-shadow 0.15s;
}
.intro-start-btn:hover { transform: translateY(-2px); box-shadow: 0 6px 24px rgba(255,77,77,0.6); }

/* ── Fade transition ────────────────────────────────────────────────────── */
.fade-enter-active, .fade-leave-active { transition: opacity 0.25s; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>
