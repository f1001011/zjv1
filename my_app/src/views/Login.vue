<template>
  <div>
    <h2>{{ $t('login') }}</h2>
    <input v-model="username" :placeholder="$t('username')" />
    <input v-model="password" type="password" :placeholder="$t('password')" />
    <button @click="handleLogin">{{ $t('login') }}</button>
  </div>
</template>

<script lang="ts" setup>
import { ref } from 'vue'
import { useAuth } from '../hooks/useAuth'
import { usePopup } from '@/composables/usePopup'
import { useI18n } from 'vue-i18n'

const username = ref('')
const password = ref('')

const { login } = useAuth()
const { showPopup } = usePopup()
const { t } = useI18n()

const handleLogin = async () => {
  try {
    await login(username.value, password.value)
    showPopup(t('loginSuccess'), 'loginSuccess')
  } catch (err) {
    showPopup(t('loginFailed'), 'loginFailed')
    console.error(err)
  }
}
</script>
