import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

// Seed demo users in localStorage if not present
function seedUsers() {
  if (!localStorage.getItem('flowtask_users')) {
    localStorage.setItem('flowtask_users', JSON.stringify([
      { id: 1, username: 'student', email: 'student@taskbuddy.edu', password: '123', role: 'student' },
      { id: 2, username: 'parent', email: 'parent@taskbuddy.home', password: '123', role: 'parent' },
    ]))
  }
}

export const useAuthStore = defineStore('auth', () => {
  const user = ref(JSON.parse(localStorage.getItem('flowtask_current_user')) || null)
  const isAuthenticated = computed(() => !!user.value)

  seedUsers()

  function login(email, password) {
    const users = JSON.parse(localStorage.getItem('flowtask_users') || '[]')
    const found = users.find(u => u.email === email && u.password === password)
    if (found) {
      user.value = found
      localStorage.setItem('flowtask_current_user', JSON.stringify(found))
      return true
    }
    return false
  }

  function logout() {
    user.value = null
    localStorage.removeItem('flowtask_current_user')
  }

  function register(username, email, password) {
    const users = JSON.parse(localStorage.getItem('flowtask_users') || '[]')
    if (users.find(u => u.email === email)) {
      throw new Error('An account with this email already exists.')
    }
    const newUser = { id: Date.now(), username, email, password, role: 'student' }
    users.push(newUser)
    localStorage.setItem('flowtask_users', JSON.stringify(users))
    return login(email, password)
  }

  return { user, isAuthenticated, login, logout, register }
})
