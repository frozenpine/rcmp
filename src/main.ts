import { createApp } from "vue";
import { createPinia } from "pinia";
import { createPlugin } from 'tauri-plugin-pinia';
import App from "./App.vue";

const pinia = createPinia();
pinia.use(createPlugin());

const app = createApp(App);

app.use(pinia);
app.mount("#app");
