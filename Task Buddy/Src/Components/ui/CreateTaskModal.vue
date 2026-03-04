<script setup>
import { ref } from 'vue'
import { useTasksStore } from '../../stores/tasks'

const emit = defineEmits(['close'])
const tasksStore = useTasksStore()

const title = ref('')
const description = ref('')
const priority = ref('medium')
const dueDate = ref('')
const category = ref('')
const dateError = ref('')

function validateDate() {
  if (!dueDate.value) { dateError.value = ''; return true }
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  if (new Date(dueDate.value) < today) {
    dateError.value = 'Due date cannot be in the past.'
    return false
  }
  dateError.value = ''
  return true
}

function handleCreate() {
  if (!title.value.trim()) return
  if (!validateDate()) return
  tasksStore.addTask({
    title: title.value.trim(),
    description: description.value.trim(),
    priority: priority.value,
    dueDate: dueDate.value,
    category: category.value.trim(),
  })
  emit('close')
}

function handleCancel() { emit('close') }
</script>

<template>
  <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm"
       @click.self="handleCancel">
    <div class="w-full max-w-lg rounded-xl border border-slate-200/60 dark:border-slate-700
                bg-white dark:bg-[#1a2d4a] p-6 shadow-2xl mx-4">

      <!-- Header -->
      <div class="flex items-center justify-between mb-5 pb-4 border-b border-slate-100 dark:border-slate-700">
        <div class="flex items-center gap-2">
          <span class="flex h-7 w-7 items-center justify-center rounded bg-[#FF6900] text-white text-xs font-bold">+</span>
          <h2 class="text-base font-bold text-[#0E1F3D] dark:text-white">New Task</h2>
        </div>
        <button @click="handleCancel"
          class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors cursor-pointer text-lg leading-none">
          ✕
        </button>
      </div>

      <!-- Title -->
      <div class="mb-4">
        <label class="mb-1 block text-xs font-semibold text-slate-600 dark:text-slate-400 uppercase tracking-wide">Title *</label>
        <input
          v-model="title"
          type="text"
          placeholder="What needs to be done?"
          class="w-full rounded-lg border border-slate-200 dark:border-slate-600
                 bg-[#F4F5F7] dark:bg-[#0E1F3D]
                 px-4 py-2.5 text-sm text-[#0E1F3D] dark:text-slate-100
                 placeholder-slate-400 dark:placeholder-slate-500
                 focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
                 outline-none transition"
        />
      </div>

      <!-- Description -->
      <div class="mb-4">
        <label class="mb-1 block text-xs font-semibold text-slate-600 dark:text-slate-400 uppercase tracking-wide">Description</label>
        <textarea
          v-model="description"
          rows="3"
          placeholder="Add more details..."
          class="w-full rounded-lg border border-slate-200 dark:border-slate-600
                 bg-[#F4F5F7] dark:bg-[#0E1F3D]
                 px-4 py-2.5 text-sm text-[#0E1F3D] dark:text-slate-100
                 placeholder-slate-400 dark:placeholder-slate-500
                 focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
                 outline-none transition resize-none"
        ></textarea>
      </div>

      <!-- Category + Priority -->
      <div class="mb-4 grid grid-cols-2 gap-3">
        <div>
          <label class="mb-1 block text-xs font-semibold text-slate-600 dark:text-slate-400 uppercase tracking-wide">Category</label>
          <input
            v-model="category"
            type="text"
            placeholder="e.g. Study, Work"
            class="w-full rounded-lg border border-slate-200 dark:border-slate-600
                   bg-[#F4F5F7] dark:bg-[#0E1F3D]
                   px-4 py-2.5 text-sm text-[#0E1F3D] dark:text-slate-100
                   placeholder-slate-400 dark:placeholder-slate-500
                   focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
                   outline-none transition"
          />
        </div>
        <div>
          <label class="mb-1 block text-xs font-semibold text-slate-600 dark:text-slate-400 uppercase tracking-wide">Priority</label>
          <select
            v-model="priority"
            class="w-full rounded-lg border border-slate-200 dark:border-slate-600
                   bg-[#F4F5F7] dark:bg-[#0E1F3D]
                   px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200
                   focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
                   outline-none transition cursor-pointer"
          >
            <option value="low">🟢 Low</option>
            <option value="medium">🟡 Medium</option>
            <option value="high">🔴 High</option>
          </select>
        </div>
      </div>

      <!-- Due Date -->
      <div class="mb-6">
        <label class="mb-1 block text-xs font-semibold text-slate-600 dark:text-slate-400 uppercase tracking-wide">Due Date</label>
        <input
          v-model="dueDate"
          type="date"
          @change="validateDate"
          class="w-full rounded-lg border border-slate-200 dark:border-slate-600
                 bg-[#F4F5F7] dark:bg-[#0E1F3D]
                 px-4 py-2.5 text-sm text-[#0E1F3D] dark:text-slate-100
                 focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
                 outline-none transition"
        />
        <p v-if="dateError" class="mt-1 text-xs text-red-600 dark:text-red-400">{{ dateError }}</p>
      </div>

      <!-- Actions -->
      <div class="flex justify-end gap-3">
        <button
          @click="handleCancel"
          class="rounded-lg border border-slate-200 dark:border-slate-600
                 bg-white dark:bg-[#0E1F3D]
                 px-5 py-2.5 text-sm font-medium text-slate-600 dark:text-slate-300
                 hover:bg-slate-50 dark:hover:bg-slate-700
                 transition-colors duration-150 cursor-pointer"
        >
          Cancel
        </button>
        <button
          @click="handleCreate"
          class="rounded-lg bg-[#FF6900] px-5 py-2.5 text-sm font-semibold text-white
                 hover:bg-[#E05900] transition-colors duration-150 cursor-pointer shadow-sm"
        >
          Create Task
        </button>
      </div>
    </div>
  </div>
</template>
