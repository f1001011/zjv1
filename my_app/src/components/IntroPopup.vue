<template>
  <Transition name="fade">
    <div v-if="visible" class="intro-overlay" @click.self="close">
      <div class="intro-modal">
        <div class="intro-border-el" aria-hidden="true"></div>
        <div class="intro-inner">
          <button class="intro-close" @click="close"><X :size="16"/></button>
          <div class="intro-logo">
            <div class="intro-logo-icon"><Zap :size="20"/></div>
            <span class="intro-logo-name">NEXUS PRO</span>
          </div>
          <div class="intro-tagline">智能支付 · 安全可靠 · 全球通用</div>
          <div class="intro-features">
            <div v-for="f in features" :key="f.key" class="intro-feat" :style="{ '--fc': f.color }">
              <div class="intro-feat-icon"><component :is="f.icon" :size="18"/></div>
              <div>
                <div class="intro-feat-title">{{ f.title }}</div>
                <div class="intro-feat-sub">{{ f.sub }}</div>
              </div>
            </div>
          </div>
          <button class="intro-start-btn" @click="close">
            <Zap :size="14"/> 开始体验
          </button>
        </div>
      </div>
    </div>
  </Transition>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { Zap, X, Shield, Crown, Globe } from 'lucide-vue-next'
import { colors } from '@/config/colors'

const SESS_KEY = 'intro_shown'
const visible = ref(!sessionStorage.getItem(SESS_KEY))
if (visible.value) sessionStorage.setItem(SESS_KEY, '1')
function close() { visible.value = false }

const features = [
  { key:'secure', title:'银行级加密',  sub:'资金安全100%有保障', icon:Shield, color:colors.cyan  },
  { key:'fast',   title:'极速到账',    sub:'秒级到账，随时可用', icon:Zap,    color:colors.amber },
  { key:'vip',    title:'VIP特权体系', sub:'专属折扣与优先服务', icon:Crown,  color:colors.red   },
  { key:'global', title:'全球通用',    sub:'支持多种支付方式',   icon:Globe,  color:colors.lime  },
]
</script>

<style scoped>
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
@keyframes border-spin { to { transform: rotate(360deg); } }
.intro-inner {
  position: relative; z-index: 1; margin: 2px; border-radius: 22px;
  background: rgba(8,12,24,0.95); backdrop-filter: blur(32px);
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
  background: rgba(255,255,255,0.04); border: 1px solid rgba(255,255,255,0.07);
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
.fade-enter-active, .fade-leave-active { transition: opacity 0.25s; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>
