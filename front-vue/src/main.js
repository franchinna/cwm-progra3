import Vue from 'vue'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

import 'bootstrap/scss/bootstrap.scss';
import 'bootstrap/dist/js/bootstrap.bundle';
import 'jquery/src/jquery.js';
import './css/estilos.css';
import 'bootstrap-icons/font/bootstrap-icons.css'

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
