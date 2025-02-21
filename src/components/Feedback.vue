<script lang="ts">
import {defineComponent} from 'vue'
import {useMessage} from "naive-ui"

// a naive-ui Message injection to window for global use
export default defineComponent({
  setup() {
    (window as any).$message = useMessage()
  }
})
</script>

<template>

</template>

<style scoped>

</style>