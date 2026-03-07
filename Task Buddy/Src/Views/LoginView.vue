<script setup>
import { ref } from 'vue'
import { useAuthStore } from '../stores/auth'
import { useRouter } from 'vue-router'
import DarkModeToggle from '../components/ui/DarkModeToggle.vue'

const authStore = useAuthStore()
const router = useRouter()

const email = ref('')
const password = ref('')
const error = ref('')

function handleLogin() {
  error.value = ''
  if (email.value && password.value) {
    const ok = authStore.login(email.value, password.value)
    if (ok) {
      router.push('/dashboard')
    } else {
      error.value = 'Incorrect email or password.'
    }
  }
}
</script>

<template>
  <div class="flex min-h-screen">
    <!-- Left brand panel -->
    <div class="hidden lg:flex lg:w-2/5 flex-col justify-between
                bg-[#0E1F3D] px-12 py-16">
      <div>
        <div class="flex items-center gap-3 mb-12">
          <span class="text-3xl">🚀</span>
          <span class="text-2xl font-bold text-white tracking-tight">TaskBuddy</span>
        </div>
        <h2 class="text-4xl font-bold text-white leading-tight mb-4">
          Plan smarter.<br/>Flow better.
        </h2>
        <p class="text-[#8FA8CC] text-base leading-relaxed">
          Manage tasks and track progress with a clean, powerful workspace built for productivity.
        </p>
      </div>
      <!-- Feature pills -->
      <div class="space-y-3">
        <div class="flex items-center gap-3 text-[#8FA8CC] text-sm">
          <span class="h-1.5 w-1.5 rounded-full bg-[#FF6900]"></span>
          Real-time task tracking
        </div>
        <div class="flex items-center gap-3 text-[#8FA8CC] text-sm">
          <span class="h-1.5 w-1.5 rounded-full bg-[#FF6900]"></span>
          Priority-based workflow
        </div>
        <div class="flex items-center gap-3 text-[#8FA8CC] text-sm">
          <span class="h-1.5 w-1.5 rounded-full bg-[#FF6900]"></span>
          Dark & light mode support
        </div>
      </div>
    </div>

    <!-- Right login form -->
    <div class="flex flex-1 items-center justify-center px-6 py-12 bg-[#F4F5F7] dark:bg-[#0a1628]">
      <div class="w-full max-w-sm">
        <!-- Mobile logo -->
        <div class="flex items-center gap-2 mb-8 lg:hidden">
          <span class="text-2xl">🚀</span>
          <span class="text-xl font-bold text-[#0E1F3D] dark:text-white">TaskBuddy</span>
        </div>

        <div class="flex items-center justify-between mb-6">
          <div>
            <h1 class="text-2xl font-bold text-[#0E1F3D] dark:text-white">Sign in</h1>
            <p class="mt-1 text-sm text-slate-500 dark:text-slate-400">to your workspace</p>
          </div>
          <DarkModeToggle />
        </div>

        <!-- Error -->
        <div v-if="error" class="mb-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 px-4 py-3 text-sm text-red-600 dark:text-red-400">
          {{ error }}
        </div>

        <!-- Form -->
        <form @submit.prevent="handleLogin" class="space-y-4">
          <div>
            <label for="email" class="mb-1.5 block text-sm font-medium text-slate-700 dark:text-slate-300">Email</label>
            <input
              id="email"
              v-model="email"
              type="email"
              required
              placeholder="you@example.com"
              class="w-full rounded-lg border border-slate-300 dark:border-slate-600
                     bg-white dark:bg-[#1a2d4a]
                     px-4 py-2.5 text-sm text-slate-800 dark:text-slate-100
                     placeholder-slate-400 dark:placeholder-slate-500
                     focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
                     outline-none transition"
            />
          </div>
          <div>
            <label for="password" class="mb-1.5 block text-sm font-medium text-slate-700 dark:text-slate-300">Password</label>
            <input
              id="password"
              v-model="password"
              type="password"
              required
              placeholder="••••••••"
              class="w-full rounded-lg border border-slate-300 dark:border-slate-600
                     bg-white dark:bg-[#1a2d4a]
                     px-4 py-2.5 text-sm text-slate-800 dark:text-slate-100
                     placeholder-slate-400 dark:placeholder-slate-500
                     focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
                     outline-none transition"
            />
          </div>
          <button
            type="submit"
            class="w-full rounded-lg bg-[#FF6900] px-4 py-2.5 text-sm font-semibold text-white
                   hover:bg-[#E05900] focus:ring-2 focus:ring-[#FF6900]/40
                   transition-colors duration-150 cursor-pointer mt-2"
          >
            Sign In
          </button>
        </form>

        <p class="mt-5 text-center text-sm text-slate-500 dark:text-slate-400">
          Don't have an account?
          <router-link to="/register" class="font-medium text-[#FF6900] hover:underline">Register</router-link>
        </p>
      </div>
    </div>
  </div>
</template>
