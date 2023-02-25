<template>
  <section id="iniciarSesion" class="container-fluid">
    <div class="container">
      <div class="row">
        <div class="logo col-12">
          <router-link to="/"><h2 class="logo">addcar app</h2></router-link>
        </div>
        <div class="form col-12">
          <h2>Inicia sesión en el foro</h2>
          <p>Para poder gestionar tu cuenta</p>
          <login-form/>
          <router-link to="/registro" class="btn btn-light w-100 mt-2" >¿No estás registrado?</router-link>
        </div>

        <div class="col-12 text-center">
          <hr>
          <router-link to="/" class="btn btn-login" >Volver a la página de inicio</router-link>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import LoginForm from "../components/LoginForm";
export default {
  name: "Login",
  components: {LoginForm},
  props: {},
  data: () => ({}),
  mounted: function () {
    if(localStorage.getItem('user') !== null){
      this.$router.push('/');
    }
  },
  computed: {},
  methods: {},

}
</script>
