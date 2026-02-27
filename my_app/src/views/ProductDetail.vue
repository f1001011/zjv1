<template>
  <div class="detail-root">
    <div class="bg-canvas">
      <div class="orb orb-red"></div>
      <div class="orb orb-cyan"></div>
    </div>

    <!-- 顶部导航 -->
    <div class="nav-bar">
      <button class="back-btn" @click="router.back()">
        <ChevronLeft :size="22" />
      </button>
      <span class="nav-title">{{ t('detail.title') }}</span>
      <div class="nav-placeholder"></div>
    </div>

    <!-- 骨架屏 -->
    <template v-if="loading">
      <div class="hero-skeleton"></div>
      <div class="content-wrap">
        <div class="sk-block sk-h28 sk-w60"></div>
        <div class="sk-block sk-h16 sk-w40" style="margin-top:8px"></div>
        <div class="sk-row" style="margin-top:20px">
          <div class="sk-stat" v-for="i in 3" :key="i"></div>
        </div>
      </div>
    </template>

    <!-- 内容 -->
    <template v-else-if="goods">
      <!-- 封面图 -->
      <div class="hero-wrap">
        <img v-if="goods.head_img" :src="goods.head_img" class="hero-img" />
        <div v-else class="hero-placeholder">
          <TrendingUp :size="56" />
        </div>
        <div class="hero-overlay"></div>
        <span v-if="goods.is_examine === 1" class="hero-badge badge-new">{{ t('detail.badgeNew') }}</span>
        <span v-else-if="goods.status === 0" class="hero-badge badge-off">{{ t('detail.soldOut') }}</span>
      </div>

      <!-- 主内容 -->
      <div class="content-wrap">
        <!-- 名称 + 分类 -->
        <div class="goods-name">{{ goods.goods_name }}</div>

        <!-- 核心数据卡片 -->
        <div class="stats-card glass-card">
          <div class="stat-col">
            <span class="stat-label">{{ t('detail.minInvest') }}</span>
            <span class="stat-val accent-red">¥{{ goods.goods_money }}</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-col">
            <span class="stat-label">{{ t('detail.dailyReturn') }}</span>
            <span class="stat-val accent-green">¥{{ goods.day_red }}</span>
          </div>
          <div class="stat-divider"></div>
          <div class="stat-col">
            <span class="stat-label">{{ t('detail.period') }}</span>
            <span class="stat-val">{{ goods.period }}<em>{{ t('detail.days') }}</em></span>
          </div>
        </div>

        <!-- 进度 -->
        <div class="section-card glass-card">
          <div class="section-row">
            <span class="section-label">{{ t('detail.progress') }}</span>
            <span class="section-val accent-red">{{ calcDetailProgress(goods) }}%</span>
          </div>
          <div class="progress-bar">
            <div class="progress-fill" :style="{ width: calcDetailProgress(goods) + '%' }"></div>
          </div>
        </div>

        <!-- 项目规模 -->
        <div class="section-card glass-card">
          <div class="section-row">
            <span class="section-label">{{ t('detail.scale') }}</span>
            <span class="section-val">¥{{ goods.project_scale?.toLocaleString() }}</span>
          </div>
          <div class="section-row" style="margin-top:12px">
            <span class="section-label">{{ t('detail.buyLimit') }}</span>
            <span class="section-val">{{ goods.buy_num === 0 ? t('detail.unlimited') : goods.buy_num + t('detail.times') }}</span>
          </div>
          <div class="section-row" style="margin-top:12px">
            <span class="section-label">{{ t('detail.levelReq') }}</span>
            <span class="section-val">{{ goods.level_vip === 0 ? t('detail.noLimit') : 'VIP ' + goods.level_vip }}</span>
          </div>
        </div>

        <!-- 收益说明 -->
        <div class="income-card glass-card">
          <div class="income-title">
            <BarChart2 :size="15" class="income-icon" />
            {{ t('detail.incomeTitle') }}
          </div>
          <div class="income-row">
            <span>{{ t('detail.dailyIncome') }}</span>
            <span class="accent-green">¥{{ goods.day_red }}</span>
          </div>
          <div class="income-row">
            <span>{{ t('detail.totalIncome') }}</span>
            <span class="accent-green">¥{{ (goods.day_red * goods.period).toFixed(2) }}</span>
          </div>
          <div class="income-row">
            <span>{{ t('detail.principal') }}</span>
            <span class="accent-red">¥{{ goods.goods_money }}</span>
          </div>
        </div>
      </div>
    </template>

    <!-- 错误状态 -->
    <div v-else class="empty-state">
      <PackageOpen :size="44" class="empty-icon" />
      <p>{{ t('detail.notFound') }}</p>
    </div>

    <!-- 底部购买栏 -->
    <div v-if="goods" class="buy-bar">
      <div class="buy-bar-inner">
        <div class="buy-price-wrap">
          <span class="buy-label">{{ t('detail.minInvestLabel') }}</span>
          <span class="buy-price">¥{{ goods.goods_money }}</span>
        </div>
        <button
          class="buy-btn"
          :disabled="goods.status === 0"
          @click="handleBuy">
          {{ goods.status === 0 ? t('detail.soldOut') : t('detail.invest') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useI18n } from 'vue-i18n'
import { ChevronLeft, TrendingUp, PackageOpen, BarChart2 } from 'lucide-vue-next'
import { fetchGoodsOne } from '@/api/product'
import type { GoodsItem } from '@/types/product'

const route  = useRoute()
const router = useRouter()
const { t }  = useI18n()

const goods   = ref<GoodsItem | null>(null)
const loading = ref(true)

async function loadGoods() {
  const id = Number(route.params.id)
  if (!id) { loading.value = false; return }
  try {
    goods.value = (await fetchGoodsOne(id)) as GoodsItem
  } catch {
    goods.value = null
  } finally {
    loading.value = false
  }
}

function calcDetailProgress(item: GoodsItem): string {
  if (!item.project_scale) return '0.0'
  return Math.min((Number(item.progress_rate) / item.project_scale) * 100, 100).toFixed(1)
}

function handleBuy() {
  console.log('buy', goods.value?.id)
}

onMounted(() => loadGoods())
</script>

<style scoped>
* { box-sizing: border-box; margin: 0; padding: 0; }

.detail-root {
  min-height: 100vh; background: var(--bg-base);
  font-family: 'Inter','PingFang SC','Noto Sans SC',sans-serif;
  -webkit-font-smoothing: antialiased;
  padding-bottom: 90px;
}

.bg-canvas { position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.orb { position: absolute; border-radius: 50%; filter: blur(90px); }
.orb-red  { width:360px; height:360px; top:-80px; left:-60px; background:var(--orb-red); animation:drift 18s ease-in-out infinite; }
.orb-cyan { width:300px; height:300px; bottom:80px; right:-40px; background:var(--orb-cyan); animation:drift 22s ease-in-out infinite reverse; }
@keyframes drift {
  0%,100% { transform:translate(0,0) scale(1); }
  40%     { transform:translate(16px,-12px) scale(1.04); }
  70%     { transform:translate(-10px,10px) scale(0.97); }
}

/* ── 导航栏 ── */
.nav-bar {
  position: fixed; top: 0; left: 0; right: 0; z-index: 20;
  display: flex; align-items: center; justify-content: space-between;
  padding: 48px 16px 12px;
  background: rgba(8,12,24,0.6);
  backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px);
}
.back-btn {
  width: 36px; height: 36px; border-radius: 50%; border: none;
  background: rgba(255,255,255,0.08);
  color: rgba(255,255,255,0.8);
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; transition: background 0.2s;
}
.back-btn:hover { background: rgba(255,255,255,0.14); }
.nav-title { font-size: 16px; font-weight: 700; color: rgba(255,255,255,0.9); }
.nav-placeholder { width: 36px; }

/* ── 封面图 ── */
.hero-wrap {
  position: relative; width: 100%; height: 260px;
  margin-top: 96px; overflow: hidden;
  background: rgba(255,255,255,0.04);
}
.hero-img { width: 100%; height: 100%; object-fit: cover; }
.hero-placeholder {
  width: 100%; height: 100%;
  display: flex; align-items: center; justify-content: center;
  color: rgba(255,77,77,0.4);
}
.hero-overlay {
  position: absolute; inset: 0;
  background: linear-gradient(to bottom, transparent 40%, var(--bg-base) 100%);
}
.hero-badge {
  position: absolute; top: 14px; left: 14px;
  font-size: 11px; font-weight: 700; padding: 4px 10px; border-radius: 8px;
}
.badge-new { background: rgba(255,184,0,0.9); color: #000; }
.badge-off { background: rgba(80,80,80,0.85); color: rgba(255,255,255,0.7); }

/* ── 主内容 ── */
.content-wrap { position: relative; z-index: 2; padding: 0 16px; margin-top: -20px; display: flex; flex-direction: column; gap: 14px; }

.goods-name { font-size: 20px; font-weight: 800; color: rgba(255,255,255,0.95); letter-spacing: -0.3px; line-height: 1.3; }

/* ── 玻璃卡片 ── */
.glass-card {
  background: var(--bg-card);
  backdrop-filter: blur(24px) saturate(150%); -webkit-backdrop-filter: blur(24px) saturate(150%);
  border: 1px solid var(--border); border-radius: 18px;
}

/* ── 核心数据 ── */
.stats-card { display: flex; align-items: center; padding: 18px 0; }
.stat-col { flex: 1; display: flex; flex-direction: column; align-items: center; gap: 6px; }
.stat-divider { width: 1px; height: 36px; background: rgba(255,255,255,0.08); }
.stat-label { font-size: 11px; color: rgba(255,255,255,0.35); letter-spacing: 0.3px; }
.stat-val { font-size: 18px; font-weight: 800; color: rgba(255,255,255,0.9); }
.stat-val em { font-size: 12px; font-style: normal; font-weight: 500; color: rgba(255,255,255,0.5); margin-left: 2px; }
.accent-red   { color: #ff6b6b; }
.accent-green { color: #69ff47; }

/* ── 通用 section 卡片 ── */
.section-card { padding: 16px 18px; }
.section-row { display: flex; justify-content: space-between; align-items: center; }
.section-label { font-size: 13px; color: rgba(255,255,255,0.4); }
.section-val { font-size: 14px; font-weight: 600; color: rgba(255,255,255,0.85); }

/* ── 进度条 ── */
.progress-bar { margin-top: 10px; height: 6px; border-radius: 3px; background: rgba(255,255,255,0.08); overflow: hidden; }
.progress-fill { height: 100%; border-radius: 3px; background: linear-gradient(90deg,#ff4d4d,#ffb800); transition: width 0.5s ease; }

/* ── 收益说明 ── */
.income-card { padding: 16px 18px; display: flex; flex-direction: column; gap: 12px; }
.income-title { display: flex; align-items: center; gap: 6px; font-size: 13px; font-weight: 700; color: rgba(255,255,255,0.7); }
.income-icon { color: #ff6b6b; }
.income-row { display: flex; justify-content: space-between; font-size: 13px; color: rgba(255,255,255,0.5); }
.income-row span:last-child { font-weight: 600; }

/* ── 骨架屏 ── */
.hero-skeleton { width: 100%; height: 260px; margin-top: 96px; background: rgba(255,255,255,0.05); animation: shimmer 1.4s infinite; }
.sk-block { border-radius: 8px; background: rgba(255,255,255,0.06); animation: shimmer 1.4s infinite; }
.sk-h28 { height: 28px; } .sk-h16 { height: 16px; }
.sk-w60 { width: 60%; } .sk-w40 { width: 40%; }
.sk-row { display: flex; gap: 12px; }
.sk-stat { flex: 1; height: 60px; border-radius: 12px; background: rgba(255,255,255,0.06); animation: shimmer 1.4s infinite; }
@keyframes shimmer { 0%,100% { opacity: 0.5; } 50% { opacity: 1; } }

/* ── 空状态 ── */
.empty-state { display: flex; flex-direction: column; align-items: center; gap: 12px; padding: 120px 0; color: rgba(255,255,255,0.25); font-size: 13px; }
.empty-icon { opacity: 0.3; }

/* ── 底部购买栏 ── */
.buy-bar {
  position: fixed; bottom: 0; left: 0; right: 0; z-index: 20;
  padding: 12px 16px calc(12px + env(safe-area-inset-bottom));
  background: rgba(8,12,24,0.85);
  backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
  border-top: 1px solid rgba(255,255,255,0.06);
}
.buy-bar-inner { display: flex; align-items: center; justify-content: space-between; gap: 16px; }
.buy-price-wrap { display: flex; flex-direction: column; gap: 2px; }
.buy-label { font-size: 11px; color: rgba(255,255,255,0.35); }
.buy-price { font-size: 22px; font-weight: 800; color: #ff6b6b; }
.buy-btn {
  flex-shrink: 0; padding: 14px 36px; border-radius: 14px; border: none;
  background: linear-gradient(135deg,#ff4d4d,#ff1744);
  color: #fff; font-size: 15px; font-weight: 700;
  cursor: pointer; font-family: inherit;
  box-shadow: 0 4px 20px rgba(255,77,77,0.4);
  transition: transform 0.15s, opacity 0.15s;
}
.buy-btn:hover:not(:disabled) { transform: translateY(-2px); }
.buy-btn:disabled { opacity: 0.4; cursor: not-allowed; background: rgba(255,255,255,0.1); box-shadow: none; }
</style>