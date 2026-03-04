<script setup>
import { ref, onMounted } from 'vue'

const isDark = ref(false)

onMounted(() => {
  isDark.value = document.documentElement.classList.contains('dark')
})

function toggle() {
  isDark.value = !isDark.value
  document.documentElement.classList.toggle('dark', isDark.value)
  localStorage.setItem('task-buddy-theme', isDark.value ? 'dark' : 'light')
}
</script>

<template>
  <button
    @click="toggle"
    class="relative flex items-center justify-center w-10 h-10 rounded-full
           bg-slate-200 dark:bg-slate-700
           hover:bg-slate-300 dark:hover:bg-slate-600
           transition-colors duration-200 cursor-pointer"
    :aria-label="isDark ? 'Switch to light mode' : 'Switch to dark mode'"
  >
    <!-- Sun icon (shown in dark mode) -->
    <svg
      v-if="isDark"
      xmlns="http://www.w3.org/2000/svg"
      class="w-5 h-5 text-amber-400"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      stroke-width="2"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M12 3v1m0 16v1m8.66-13.66l-.71.71M4.05 19.95l-.71.71M21 12h-1M4 12H3m16.66 7.66l-.71-.71M4.05 4.05l-.71-.71M16 12a4 4 0 11-8 0 4 4 0 018 0z"
      />
    </svg>

    <!-- Moon icon (shown in light mode) -->
    <svg
      v-else
      xmlns="http://www.w3.org/2000/svg"
      class="w-5 h-5 text-indigo-600"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
      stroke-width="2"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M21 12.79A9 9 0 1111.21 3a7 7 0 009.79 9.79z"
      />
    </svg>
  </button>
</template>
