<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useTasksStore } from '../stores/tasks'
import { useAuthStore } from '../stores/auth'
import TaskCard from '../components/tasks/TaskCard.vue'
import CreateTaskModal from '../components/ui/CreateTaskModal.vue'
import DarkModeToggle from '../components/ui/DarkModeToggle.vue'

const tasksStore = useTasksStore()
const authStore = useAuthStore()
const router = useRouter()
const route = useRoute()

const showModal = ref(false)

const filteredTasks = computed(() =>
  tasksStore.tasks.filter((t) => t.status === 'todo')
)

const today = new Date().toISOString().slice(0, 10)
const todaysTasks = computed(() => tasksStore.tasks.filter((t) => t.dueDate === today).length)
const upcomingTasks = computed(() => tasksStore.tasks.filter((t) => t.dueDate > today).length)
const overdueTasks = computed(() => tasksStore.tasks.filter((t) => t.dueDate < today && t.status !== 'done').length)
const completionPercent = computed(() => {
  if (tasksStore.tasks.length === 0) return 0
  return Math.round((tasksStore.tasks.filter((t) => t.status === 'done').length / tasksStore.tasks.length) * 100)
})

const navLinks = [
  { label: 'Dashboard', icon: '🏠', to: '/dashboard' },
  { label: 'To Do', icon: '📋', to: '/dashboard/todo' },
  { label: 'In Progress', icon: '⚡', to: '/dashboard/inprogress' },
  { label: 'Completed', icon: '✅', to: '/dashboard/done' },
]

const displayName = computed(() => authStore.user?.username || authStore.user?.name || 'User')
const avatarLetter = computed(() => displayName.value.charAt(0).toUpperCase())

function handleStatusChange({ id, status }) { tasksStore.updateStatus(id, status) }
function handleShare() { alert('Share link copied to clipboard!') }
function logout() { authStore.logout(); router.push('/login') }
</script>

<template>
  <div class="flex min-h-screen">
    <aside class="fixed top-0 left-0 z-40 flex h-screen w-56 flex-col bg-[#0E1F3D]">
      <div class="flex items-center gap-2.5 px-5 py-5 border-b border-white/10">
        <span class="text-xl">🚀</span>
        <span class="text-base font-bold text-white tracking-tight">TaskBuddy</span>
      </div>
      <nav class="flex-1 px-3 py-4 space-y-0.5">
        <router-link v-for="link in navLinks" :key="link.to" :to="link.to"
          class="flex items-center gap-2.5 rounded-lg px-3 py-2.5 text-sm font-medium transition-colors duration-150"
          :class="route.path === link.to
            ? 'bg-[#FF6900] text-white'
            : 'text-[#8FA8CC] hover:bg-white/10 hover:text-white'">
          <span>{{ link.icon }}</span> {{ link.label }}
        </router-link>
      </nav>
      <div class="border-t border-white/10 px-4 py-4">
        <p class="mb-2 text-xs font-semibold uppercase tracking-wider text-[#4A6A8A]">Account</p>
        <div class="flex items-center gap-3">
          <div class="flex h-9 w-9 items-center justify-center rounded-full bg-[#FF6900] text-sm font-bold text-white">{{ avatarLetter }}</div>
          <p class="flex-1 min-w-0 text-sm font-medium text-white truncate">{{ displayName }}</p>
          <DarkModeToggle />
        </div>
        <button @click="logout" class="mt-3 text-xs font-medium text-[#8FA8CC] hover:text-[#FF6900] transition-colors duration-150 cursor-pointer">Sign out →</button>
      </div>
    </aside>

    <main class="ml-56 flex-1 bg-[#F4F5F7] dark:bg-[#0a1628] px-6 py-8 lg:px-10">
      <!-- Stats -->
      <section class="mb-8 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4">
        <div class="flex items-center gap-4 rounded-xl bg-white dark:bg-[#1a2d4a] p-5 shadow-sm border border-slate-200/60 dark:border-slate-700">
          <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-[#FF6900]/10"><span class="text-xl">📅</span></div>
          <div><p class="text-xs font-medium text-slate-500 uppercase tracking-wide">Today</p><p class="text-2xl font-bold text-[#FF6900]">{{ todaysTasks }}</p></div>
        </div>
        <div class="flex items-center gap-4 rounded-xl bg-white dark:bg-[#1a2d4a] p-5 shadow-sm border border-slate-200/60 dark:border-slate-700">
          <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-[#3C67EA]/10"><span class="text-xl">⏳</span></div>
          <div><p class="text-xs font-medium text-slate-500 uppercase tracking-wide">Upcoming</p><p class="text-2xl font-bold text-[#3C67EA]">{{ upcomingTasks }}</p></div>
        </div>
        <div class="flex items-center gap-4 rounded-xl bg-white dark:bg-[#1a2d4a] p-5 shadow-sm border border-slate-200/60 dark:border-slate-700">
          <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-red-100 dark:bg-red-900/30"><span class="text-xl">🚨</span></div>
          <div><p class="text-xs font-medium text-slate-500 uppercase tracking-wide">Overdue</p><p class="text-2xl font-bold" :class="overdueTasks > 0 ? 'text-red-600' : 'text-[#0E1F3D] dark:text-white'">{{ overdueTasks }}</p></div>
        </div>
        <div class="flex items-center gap-4 rounded-xl bg-white dark:bg-[#1a2d4a] p-5 shadow-sm border border-slate-200/60 dark:border-slate-700">
          <div class="flex h-12 w-12 items-center justify-center rounded-xl bg-emerald-100 dark:bg-emerald-900/30"><span class="text-xl">📈</span></div>
          <div><p class="text-xs font-medium text-slate-500 uppercase tracking-wide">Done</p><p class="text-2xl font-bold text-emerald-600 dark:text-emerald-400">{{ completionPercent }}%</p></div>
        </div>
      </section>

      <div class="mb-6 flex items-end justify-between">
        <div>
          <h1 class="text-xl font-bold text-[#0E1F3D] dark:text-white">📋 To Do <span class="ml-1 text-base font-normal text-slate-400">({{ filteredTasks.length }})</span></h1>
          <p class="mt-0.5 text-sm text-slate-500 dark:text-slate-400">Tasks that haven't been started yet.</p>
        </div>
        <button @click="showModal = true" class="rounded-lg bg-[#FF6900] px-5 py-2.5 text-sm font-semibold text-white hover:bg-[#E05900] transition-colors duration-150 cursor-pointer shadow-sm">+ Create Task</button>
      </div>

      <section class="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
        <TaskCard v-for="task in filteredTasks" :key="task.id" :task="task" @status-change="handleStatusChange" @share="handleShare" />
      </section>
      <div v-if="filteredTasks.length === 0" class="mt-20 text-center">
        <p class="text-5xl mb-4">📋</p>
        <p class="text-lg font-semibold text-[#0E1F3D] dark:text-slate-300">No to-do tasks!</p>
        <p class="text-sm text-slate-400 mt-1">Everything's in progress or done. 🎉</p>
      </div>
    </main>

    <CreateTaskModal v-if="showModal" @close="showModal = false" />
  </div>
</template>
