<script setup lang="ts">
import {onBeforeMount} from 'vue'
import {useMessage, useNotification} from "naive-ui"

interface FeedbackProps {
  message?: boolean
  notification?: boolean
}

const {
  message,
  notification,
} = defineProps<FeedbackProps>()

// a naive-ui Message injection to window for global use
onBeforeMount(()=> {
  if (message) {(window as any).$message = useMessage()}
  if (notification) {(window as any).$notification = useNotification()}
})
</script>

<template>

</template>

<style scoped>

</style>