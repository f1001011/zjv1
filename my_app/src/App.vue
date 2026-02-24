<template>
  <router-view />
  <PopupModal v-model="state.visible" v-bind="state.options">
    <p class="popup-msg">{{ state.message }}</p>
  </PopupModal>
</template>

<script lang="ts" setup>
import PopupModal from '@/components/PopupModal.vue'
import { usePopup } from '@/composables/usePopup'

const { state } = usePopup()
</script>

<style>
.popup-msg {
  margin: 0;
  font-size: 15px;
  line-height: 1.7;
  text-align: center;
}
</style>
