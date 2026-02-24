<template>
  <div>
    <h2>{{ $t('home') }}</h2>
    <button @click="handleLogout">{{ $t('logout') }}</button>
  </div>
</template>

<script lang="ts" setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const handleLogout = () => {
  localStorage.removeItem('token')
  router.push({ name: 'Login' })
}
</script>
