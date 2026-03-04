<script setup>
import { onMounted } from 'vue'

onMounted(() => {
  const saved = localStorage.getItem('task-buddy-theme')
  if (saved === 'dark') {
    document.documentElement.classList.add('dark')
  } else {
    document.documentElement.classList.remove('dark')
  }
})
</script>

<template>
  <RouterView />
</template>