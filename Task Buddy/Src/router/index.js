import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '../stores/auth'

import DashboardView from '../views/DashboardView.vue'
import TodoView from '../views/TodoView.vue'
import InProgressView from '../views/InProgressView.vue'
import CompletedView from '../views/CompletedView.vue'
import LoginView from '../views/LoginView.vue'
import RegisterView from '../views/RegisterView.vue'

const routes = [
  {
    path: '/',
    redirect: '/dashboard',
  },
  {
    path: '/dashboard',
    name: 'Dashboard',
    component: DashboardView,
    meta: { requiresAuth: true },
  },
  {
    path: '/dashboard/todo',
    name: 'Todo',
    component: TodoView,
    meta: { requiresAuth: true },
  },
  {
    path: '/dashboard/inprogress',
    name: 'InProgress',
    component: InProgressView,
    meta: { requiresAuth: true },
  },
  {
    path: '/dashboard/done',
    name: 'Completed',
    component: CompletedView,
    meta: { requiresAuth: true },
  },
  {
    path: '/login',
    name: 'Login',
    component: LoginView,
  },
  {
    path: '/register',
    name: 'Register',
    component: RegisterView,
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach((to) => {
  const authStore = useAuthStore()
  if (to.meta.requiresAuth && !authStore.isAuthenticated) {
    return { name: 'Login' }
  }
})

export default router
