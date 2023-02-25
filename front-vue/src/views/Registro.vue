<template>
  <section id="registro" class="container-fluid">
    <div class="container">
      <div class="row">
        <div class="logo col-12">
          <router-link to="/">
            <h2 class="logo">addcar app</h2>
          </router-link>
        </div>
        <div class="redes col-12">
          <h2>Registra tu usuario</h2>
          <!-- TODO: Login con redes sociales.
          <p>Puedes utilizar las siguientes redes sociales para iniciar sesión</p>
          <ul>
            <li><a href="#" class="social fb"></a></li>
            <li><a href="#" class="social tw"></a></li>
            <li><a href="#" class="social ig"></a></li>
          </ul>

          <hr>
          -->
        </div>
        <div class="col-12">
          <p>Completando el siguiente formulario.</p>
          <NewUserLogin/>
        </div>
        <div class="col-12">
          <hr>
          <router-link to="/" class="btn">Volver a la página de incio</router-link>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import NewUserLogin from "@/components/NewUserLogin";

export default {
  name: "Registro",
  components: {
    NewUserLogin
  },
  props: {},
  data: function () {
    return {}
  },
  computed: {},
  methods: {}
}
</script>

<style scoped>

</style>