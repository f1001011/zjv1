<template>
  <router-view />
  <BottomNav />
  <PopupModal v-model="state.visible" v-bind="state.options">
    <p class="popup-msg">{{ state.message }}</p>
  </PopupModal>
</template>

<script lang="ts" setup>
import PopupModal from '@/components/PopupModal.vue'
import BottomNav from '@/components/BottomNav.vue'
import { usePopup } from '@/composables/usePopup'
import { useTheme } from '@/composables/useTheme'

const { state } = usePopup()
useTheme()
</script>

<style>
* { box-sizing: border-box; }
html, body {
  margin: 0;
  padding: 0;
  width: 100%;
  overflow-x: hidden;
}
.popup-msg {
  margin: 0;
  font-size: 15px;
  line-height: 1.7;
  text-align: center;
  color: #fff;
}
</style>
