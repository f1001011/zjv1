<template>
  <div class="products-root">
    <div class="bg-canvas">
      <div class="orb orb-red"></div>
      <div class="orb orb-cyan"></div>
    </div>

    <!-- 顶部标题 -->
    <div class="page-header">
      <span class="page-title">{{ t('nav.products') }}</span>
    </div>

    <!-- 分类 Tab -->
    <div class="cat-bar-wrap">
      <div class="cat-bar">
        <button
          v-for="cat in categories" :key="cat.id"
          class="cat-btn" :class="{ active: activeCat === cat.id }"
          @click="selectCat(cat.id)">
          {{ cat.type_name }}
        </button>
      </div>
    </div>

    <!-- 商品列表 -->
    <div class="list-body">
      <!-- 骨架屏 -->
      <template v-if="loading && list.length === 0">
        <div class="card-skeleton glass-card" v-for="i in 3" :key="i">
          <div class="sk-img"></div>
          <div class="sk-lines">
            <div class="sk-line sk-w70"></div>
            <div class="sk-line sk-w50"></div>
            <div class="sk-line sk-w90"></div>
          </div>
        </div>
      </template>

      <!-- 空状态 -->
      <div v-else-if="!loading && list.length === 0" class="empty-state">
        <PackageOpen :size="44" class="empty-icon" />
        <p>暂无商品</p>
      </div>

      <!-- 商品卡片 -->
      <div
        v-for="item in list" :key="item.id"
        class="goods-card glass-card">

        <!-- 封面图 -->
        <div class="card-img-wrap">
          <img v-if="item.head_img" :src="item.head_img" class="card-img" />
          <div v-else class="card-img-placeholder"><TrendingUp :size="26" /></div>
          <span v-if="item.is_examine === 1" class="badge badge-new">新手</span>
          <span v-else-if="item.status === 0" class="badge badge-off">已下架</span>
        </div>

        <!-- 内容 -->
        <div class="card-body">
          <div class="card-name">{{ item.goods_name }}</div>

          <div class="card-stats">
            <div class="stat-item">
              <span class="stat-label">起投</span>
              <span class="stat-val accent-red">¥{{ item.goods_money }}</span>
            </div>
            <div class="stat-item">
              <span class="stat-label">日收益</span>
              <span class="stat-val accent-green">¥{{ item.day_red }}</span>
            </div>
            <div class="stat-item">
              <span class="stat-label">周期</span>
              <span class="stat-val">{{ item.period }}天</span>
            </div>
          </div>

          <!-- 进度条 -->
          <div class="progress-wrap">
            <div class="progress-bar">
              <div class="progress-fill" :style="{ width: Math.min(item.progress_rate, 100) + '%' }"></div>
            </div>
            <span class="progress-text">{{ item.progress_rate }}%</span>
          </div>

          <button class="buy-btn" :disabled="item.status === 0" @click="handleBuy(item)">
            {{ item.status === 0 ? '已下架' : '立即投资' }}
          </button>
        </div>
      </div>

      <!-- 加载更多 -->
      <div v-if="list.length > 0" class="load-more-row">
        <button v-if="hasMore" class="load-more-btn" :disabled="loadingMore" @click="loadMore">
          <Loader2 v-if="loadingMore" :size="15" class="spinner" />
          <span v-else>加载更多</span>
        </button>
        <p v-else class="no-more">{{ t('home.noMore') }}</p>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue'
import { useI18n } from 'vue-i18n'
import { useRouter } from 'vue-router'
import { TrendingUp, PackageOpen, Loader2 } from 'lucide-vue-next'
import { fetchGoodsTypes, fetchGoodsList } from '@/api/product'
import type { GoodsType, GoodsItem } from '@/types/product'

const { t } = useI18n()
const router = useRouter()

const categories  = ref<GoodsType[]>([])
const activeCat   = ref(0)
const list        = ref<GoodsItem[]>([])
const page        = ref(1)
const hasMore     = ref(true)
const loading     = ref(false)
const loadingMore = ref(false)

async function loadCategories() {
  try {
    const res = await fetchGoodsTypes()
    categories.value = res as GoodsType[]
    if (categories.value.length > 0) {
      activeCat.value = categories.value[0].id
      await loadList(true)
    }
  } catch {}
}

async function loadList(reset = false) {
  if (reset) {
    page.value = 1
    list.value = []
    hasMore.value = true
    loading.value = true
  } else {
    loadingMore.value = true
  }
  try {
    const res = (await fetchGoodsList(activeCat.value, page.value, 10)) as GoodsItem[]
    if (reset) list.value = res
    else list.value.push(...res)
    hasMore.value = res.length === 10
    if (hasMore.value) page.value++
  } catch {
    hasMore.value = false
  } finally {
    loading.value = false
    loadingMore.value = false
  }
}

function selectCat(id: number) {
  if (activeCat.value === id) return
  activeCat.value = id
  loadList(true)
}

function loadMore() {
  if (!hasMore.value || loadingMore.value) return
  loadList(false)
}

function handleBuy(item: GoodsItem) {
  router.push({ name: 'ProductDetail', params: { id: item.id } })
}

onMounted(() => loadCategories())
</script>

<style scoped>
* { box-sizing: border-box; margin: 0; padding: 0; }

.products-root {
  min-height: 100vh; background: var(--bg-base);
  font-family: 'Inter','PingFang SC','Noto Sans SC',sans-serif;
  -webkit-font-smoothing: antialiased;
  padding-bottom: 80px;
}

.bg-canvas { position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.orb { position: absolute; border-radius: 50%; filter: blur(90px); }
.orb-red  { width:360px; height:360px; top:-80px; left:-60px;   background:var(--orb-red);  animation:drift 18s ease-in-out infinite; }
.orb-cyan { width:300px; height:300px; bottom:-40px; right:-40px; background:var(--orb-cyan); animation:drift 22s ease-in-out infinite reverse; }
@keyframes drift {
  0%,100% { transform:translate(0,0) scale(1); }
  40%     { transform:translate(16px,-12px) scale(1.04); }
  70%     { transform:translate(-10px,10px) scale(0.97); }
}

.page-header { position: relative; z-index: 2; padding: 56px 20px 16px; }
.page-title  { font-size: 22px; font-weight: 800; color: rgba(255,255,255,0.92); letter-spacing: -0.3px; }

.cat-bar-wrap {
  position: sticky; top: 0; z-index: 10;
  background: rgba(8,12,24,0.7);
  backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px);
  border-bottom: 1px solid rgba(255,255,255,0.06);
  padding: 0 16px;
}
.cat-bar { display: flex; gap: 6px; overflow-x: auto; padding: 10px 0; scrollbar-width: none; }
.cat-bar::-webkit-scrollbar { display: none; }
.cat-btn {
  flex-shrink: 0; padding: 6px 16px; border-radius: 20px;
  border: 1px solid rgba(255,255,255,0.1);
  background: rgba(255,255,255,0.04);
  color: rgba(255,255,255,0.45); font-size: 13px; font-weight: 500;
  cursor: pointer; font-family: inherit; transition: all 0.2s; white-space: nowrap;
}
.cat-btn.active {
  background: linear-gradient(135deg,#ff4d4d,#ff1744);
  border-color: transparent; color: #fff;
  box-shadow: 0 2px 12px rgba(255,77,77,0.4);
}

.list-body { position: relative; z-index: 1; padding: 16px 16px 0; display: flex; flex-direction: column; gap: 14px; }

.card-skeleton { display: flex; gap: 14px; padding: 16px; border-radius: 18px; }
.sk-img { width: 80px; height: 80px; border-radius: 12px; flex-shrink: 0; background: rgba(255,255,255,0.06); animation: shimmer 1.4s infinite; }
.sk-lines { flex: 1; display: flex; flex-direction: column; gap: 10px; justify-content: center; }
.sk-line { height: 12px; border-radius: 6px; background: rgba(255,255,255,0.06); animation: shimmer 1.4s infinite; }
.sk-w70 { width: 70%; } .sk-w50 { width: 50%; } .sk-w90 { width: 90%; }
@keyframes shimmer { 0%,100% { opacity: 0.5; } 50% { opacity: 1; } }

.empty-state { display: flex; flex-direction: column; align-items: center; gap: 12px; padding: 60px 0; color: rgba(255,255,255,0.25); font-size: 13px; }
.empty-icon { opacity: 0.3; }

.glass-card {
  background: var(--bg-card);
  backdrop-filter: blur(24px) saturate(150%); -webkit-backdrop-filter: blur(24px) saturate(150%);
  border: 1px solid var(--border); border-radius: 18px;
}
.goods-card { display: flex; gap: 14px; padding: 16px; }

.card-img-wrap { position: relative; flex-shrink: 0; width: 84px; height: 84px; border-radius: 12px; overflow: hidden; background: rgba(255,255,255,0.05); }
.card-img { width: 100%; height: 100%; object-fit: cover; }
.card-img-placeholder { width: 100%; height: 100%; display: flex; align-items: center; justify-content: center; color: rgba(255,77,77,0.6); }
.badge { position: absolute; top: 5px; left: 5px; font-size: 10px; font-weight: 600; padding: 2px 6px; border-radius: 6px; }
.badge-new { background: rgba(255,184,0,0.9); color: #000; }
.badge-off { background: rgba(100,100,100,0.8); color: rgba(255,255,255,0.7); }

.card-body { flex: 1; display: flex; flex-direction: column; gap: 8px; min-width: 0; }
.card-name { font-size: 15px; font-weight: 700; color: rgba(255,255,255,0.9); letter-spacing: -0.2px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }

.card-stats { display: flex; gap: 12px; }
.stat-item { display: flex; flex-direction: column; gap: 2px; }
.stat-label { font-size: 10px; color: rgba(255,255,255,0.3); letter-spacing: 0.3px; }
.stat-val { font-size: 13px; font-weight: 600; color: rgba(255,255,255,0.8); }
.accent-red   { color: #ff6b6b; }
.accent-green { color: #69ff47; }

.progress-wrap { display: flex; align-items: center; gap: 8px; }
.progress-bar { flex: 1; height: 4px; border-radius: 2px; background: rgba(255,255,255,0.08); }
.progress-fill { height: 100%; border-radius: 2px; background: linear-gradient(90deg,#ff4d4d,#ffb800); transition: width 0.4s ease; }
.progress-text { font-size: 10px; color: rgba(255,255,255,0.35); flex-shrink: 0; }

.buy-btn {
  align-self: flex-start; padding: 6px 18px; border-radius: 10px; border: none;
  background: linear-gradient(135deg,#ff4d4d,#ff1744);
  color: #fff; font-size: 12px; font-weight: 600;
  cursor: pointer; font-family: inherit;
  box-shadow: 0 2px 10px rgba(255,77,77,0.35);
  transition: transform 0.15s, opacity 0.15s;
}
.buy-btn:hover:not(:disabled) { transform: translateY(-1px); }
.buy-btn:disabled { opacity: 0.4; cursor: not-allowed; background: rgba(255,255,255,0.1); box-shadow: none; }

.load-more-row { display: flex; justify-content: center; padding: 16px 0; }
.load-more-btn {
  padding: 8px 28px; border-radius: 20px;
  border: 1px solid rgba(255,255,255,0.12);
  background: rgba(255,255,255,0.05);
  color: rgba(255,255,255,0.5); font-size: 13px;
  cursor: pointer; font-family: inherit;
  display: flex; align-items: center; gap: 6px;
  transition: background 0.2s;
}
.load-more-btn:hover:not(:disabled) { background: rgba(255,255,255,0.08); }
.load-more-btn:disabled { opacity: 0.5; cursor: not-allowed; }
.spinner { animation: spin 0.8s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }
.no-more { font-size: 12px; color: rgba(255,255,255,0.2); }
</style>
