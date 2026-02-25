<template>
  <nav v-if="showNav" class="bottom-nav">
    <div class="nav-inner">
      <button
        v-for="item in navItems"
        :key="item.name"
        :class="['nav-item', { active: isActive(item) }]"
        :style="isActive(item) ? { '--nc': item.color } : {}"
        @click="router.push(item.path)"
      >
        <div class="nav-icon-wrap">
          <component :is="item.icon" :size="22" />
          <span v-if="isActive(item)" class="nav-dot"></span>
        </div>
      </button>
    </div>
  </nav>
</template>

<script lang="ts" setup>
import { computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { Home, Package, Crown, User } from 'lucide-vue-next'

const router = useRouter()
const route  = useRoute()

const navItems = [
  { name: 'Home',          path: '/',         icon: Home,    color: '#ff4d4d' },
  { name: 'Products',      path: '/products', icon: Package, color: '#00e5ff' },
  { name: 'Vip',           path: '/vip',      icon: Crown,   color: '#ffb800' },
  { name: 'BalanceCenter', path: '/balance',  icon: User,    color: '#69ff47' },
]

const showNav = computed(() => route.name !== 'Login')

function isActive(item: typeof navItems[0]) {
  return route.name === item.name
}
</script>

<style scoped>
.bottom-nav {
  position: fixed;
  bottom: 0; left: 0; right: 0;
  z-index: 100;
  display: flex;
  justify-content: center;
  align-items: stretch;
  height: 64px;
  padding-bottom: env(safe-area-inset-bottom, 0px);
  background: rgba(12, 12, 15, 0.82);
  backdrop-filter: blur(24px) saturate(160%);
  -webkit-backdrop-filter: blur(24px) saturate(160%);
}

.nav-inner {
  width: 100%;
  max-width: 460px;
  display: flex;
  align-items: center;
  border-top: 1px solid rgba(255, 255, 255, 0.07);
}

.nav-item {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  background: none;
  border: none;
  cursor: pointer;
  color: rgba(255, 255, 255, 0.28);
  transition: color 0.2s;
  -webkit-tap-highlight-color: transparent;
}

.nav-item:active { transform: scale(0.88); }

.nav-item.active {
  color: var(--nc);
  filter: drop-shadow(0 0 8px var(--nc));
}

.nav-icon-wrap {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}

.nav-dot {
  position: absolute;
  bottom: -6px;
  left: 50%;
  transform: translateX(-50%);
  width: 4px;
  height: 4px;
  border-radius: 50%;
  background: var(--nc);
}
</style>
