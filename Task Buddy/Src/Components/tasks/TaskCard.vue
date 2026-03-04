<script setup>
import { computed } from 'vue'

const props = defineProps({
  task: {
    type: Object,
    required: true,
  },
  showDelete: {
    type: Boolean,
    default: false,
  },
})

const emit = defineEmits(['status-change', 'share', 'delete'])

const priorityClasses = {
  low: 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-400',
  medium: 'bg-amber-100 text-amber-700 dark:bg-amber-900/40 dark:text-amber-400',
  high: 'bg-red-100 text-red-700 dark:bg-red-900/40 dark:text-red-400',
}

const isOverdue = computed(() => {
  const today = new Date()
  today.setHours(0, 0, 0, 0)
  return new Date(props.task.dueDate) < today && props.task.status !== 'done'
})

function onStatusChange(event) {
  emit('status-change', { id: props.task.id, status: event.target.value })
}

const leftBorderColor = {
  low: 'border-l-4 border-l-emerald-400',
  medium: 'border-l-4 border-l-amber-400',
  high: 'border-l-4 border-l-red-500',
}

const statusBadge = {
  todo: 'bg-slate-100 text-slate-600 dark:bg-slate-700 dark:text-slate-300',
  inprogress: 'bg-[#FF6900]/10 text-[#FF6900]',
  done: 'bg-emerald-100 text-emerald-700 dark:bg-emerald-900/40 dark:text-emerald-400',
}

const statusLabel = {
  todo: 'To Do',
  inprogress: 'In Progress',
  done: 'Done',
}
</script>

<template>
  <div
    @dblclick="emit('share')"
    class="group relative rounded-xl p-5 shadow-sm
           bg-white dark:bg-[#1a2d4a]
           border border-slate-200/60 dark:border-slate-700
           hover:shadow-md transition-all duration-200 hover:-translate-y-0.5 cursor-pointer"
    :class="[
      isOverdue ? '!border-red-400 dark:!border-red-500' : leftBorderColor[task.priority]
    ]"
  >
    <!-- Top row: priority + status -->
    <div class="flex items-center justify-between mb-3">
      <span
        class="inline-block rounded-md px-2.5 py-0.5 text-xs font-semibold uppercase tracking-wide"
        :class="priorityClasses[task.priority]"
      >
        {{ task.priority }}
      </span>
      <span
        class="inline-block rounded-md px-2.5 py-0.5 text-xs font-medium"
        :class="statusBadge[task.status]"
      >
        {{ statusLabel[task.status] || task.status }}
      </span>
    </div>

    <!-- Title -->
    <h3 class="text-sm font-bold text-[#0E1F3D] dark:text-slate-100">
      {{ task.title }}
    </h3>

    <!-- Description -->
    <p class="mt-1 text-xs text-slate-500 dark:text-slate-400 line-clamp-2">
      {{ task.description }}
    </p>

    <!-- Category -->
    <span
      v-if="task.category"
      class="mt-2 inline-block rounded bg-[#FF6900]/10
             px-2 py-0.5 text-xs font-medium text-[#FF6900]"
    >
      {{ task.category }}
    </span>

    <!-- Due date -->
    <div class="mt-3 flex items-center gap-1.5 text-xs"
      :class="isOverdue
        ? 'text-red-600 dark:text-red-400 font-medium'
        : 'text-slate-400 dark:text-slate-500'"
    >
      <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
           viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
        <path stroke-linecap="round" stroke-linejoin="round"
              d="M12 6v6l4 2m6-2a10 10 0 11-20 0 10 10 0 0120 0z" />
      </svg>
      <span v-if="isOverdue">Overdue · {{ task.dueDate }}</span>
      <span v-else>{{ task.dueDate || 'No due date' }}</span>
    </div>

    <!-- Status dropdown + delete -->
    <div class="mt-4 flex items-center justify-between gap-2">
      <button
        v-if="showDelete"
        @click.stop="emit('delete', task.id)"
        class="flex items-center gap-1 rounded-md border border-red-200 dark:border-red-800
               bg-red-50 dark:bg-red-900/20
               px-2.5 py-1.5 text-xs font-medium text-red-600 dark:text-red-400
               hover:bg-red-100 dark:hover:bg-red-900/40
               transition-colors duration-150 cursor-pointer"
      >
        <svg xmlns="http://www.w3.org/2000/svg" class="h-3.5 w-3.5" fill="none"
             viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round"
                d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
        </svg>
        Delete
      </button>
      <select
        :value="task.status"
        @change="onStatusChange"
        class="ml-auto rounded-lg border border-slate-200 dark:border-slate-600
               bg-slate-50 dark:bg-[#0E1F3D]
               px-3 py-1.5 text-xs text-slate-700 dark:text-slate-200
               focus:border-[#FF6900] focus:ring-2 focus:ring-[#FF6900]/20
               outline-none transition cursor-pointer"
      >
        <option value="todo">To Do</option>
        <option value="inprogress">In Progress</option>
        <option value="done">Done</option>
      </select>
    </div>
  </div>
</template>
