import { createI18n } from 'vue-i18n'
import en from './locales/en.json'
import zh from './locales/zh.json'

const SUPPORTED = ['zh', 'en'] as const
export type Locale = typeof SUPPORTED[number]

export const i18n = createI18n({
    legacy: false,
    locale: 'zh',
    fallbackLocale: 'en',
    messages: { zh, en }
})

export function setLocale(lang: string) {
    const locale = SUPPORTED.includes(lang as Locale) ? (lang as Locale) : 'zh'
    i18n.global.locale.value = locale
}
