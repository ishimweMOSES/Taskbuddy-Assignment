import { ref } from 'vue'
import { defineStore } from 'pinia'

export const useTasksStore = defineStore('tasks', () => {
    const tasks = ref([
        {
            id: 1,
            title: 'Design the landing page wireframe',
            description: 'Create high-fidelity wireframes for the new marketing landing page using Figma.',
            priority: 'high',
            dueDate: '2026-02-18',
            status: 'done',
        },
        {
            id: 2,
            title: 'Set up CI/CD pipeline',
            description: 'Configure GitHub Actions for automated testing and deployment to staging.',
            priority: 'high',
            dueDate: '2026-02-17',
            status: 'inprogress',
        },
        {
            id: 3,
            title: 'Write unit tests for auth module',
            description: 'Cover login, logout, and token refresh flows with at least 90% coverage.',
            priority: 'medium',
            dueDate: '2026-02-22',
            status: 'todo',
        },
        {
            id: 4,
            title: 'Refactor API error handling',
            description: 'Centralise error interceptors and add user-friendly toast notifications.',
            priority: 'low',
            dueDate: '2026-02-25',
            status: 'todo',
        },
        {
            id: 5,
            title: 'Create user onboarding flow',
            description: 'Build a 3-step onboarding wizard with progress indicator and skip option.',
            priority: 'medium',
            dueDate: '2026-02-19',
            status: 'inprogress',
        },
    ])

    function updateStatus(id, newStatus) {
        const task = tasks.value.find((t) => t.id === id)
        if (task) {
            task.status = newStatus
        }
    }

    function addTask(task) {
        tasks.value.push({
            id: Date.now(),
            title: task.title,
            description: task.description,
            priority: task.priority,
            dueDate: task.dueDate,
            category: task.category || '',
            status: 'todo',
        })
    }

    function deleteTask(id) {
        tasks.value = tasks.value.filter((t) => t.id !== id)
    }

    function clearCompleted() {
        tasks.value = tasks.value.filter((t) => t.status !== 'done')
    }

    return { tasks, updateStatus, addTask, deleteTask, clearCompleted }
})
