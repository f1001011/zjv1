import { ref } from 'vue'

export const userBalance = ref(0)

export function setUserBalance(val: number) {
  userBalance.value = val
}

export function clearUserBalance() {
  userBalance.value = 0
}
