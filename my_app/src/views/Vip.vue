<template>
  <div class="placeholder-root">
    <div class="bg-canvas">
      <div class="orb orb-amber"></div>
    </div>
    <div class="placeholder-body">
      <Crown :size="48" class="ph-icon" />
      <div class="ph-title">VIP 特权</div>
      <div class="ph-sub">敬请期待</div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { Crown } from 'lucide-vue-next'
</script>

<style scoped>
.placeholder-root {
  min-height: 100vh; background: var(--bg-base);
  display: flex; align-items: center; justify-content: center;
  font-family: 'Inter','PingFang SC',sans-serif;
  position: relative; overflow: hidden;
}
.bg-canvas { position: fixed; inset: 0; pointer-events: none; z-index: 0; }
.orb { position: absolute; border-radius: 50%; filter: blur(90px); }
.orb-amber { width:400px; height:400px; bottom:10%; left:10%; background:rgba(255,184,0,0.12); }
.placeholder-body {
  position: relative; z-index: 1;
  display: flex; flex-direction: column; align-items: center; gap: 12px;
}
.ph-icon { color: #ffb800; opacity: 0.5; }
.ph-title { font-size: 20px; font-weight: 700; color: rgba(255,255,255,0.7); }
.ph-sub   { font-size: 13px; color: rgba(255,255,255,0.25); }
</style>
