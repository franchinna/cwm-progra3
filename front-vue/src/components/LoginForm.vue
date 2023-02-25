<template>
  <form action="#"
        id="form-login"
        method="GET"
        @submit.prevent="login(credenciales)"
  >

    <div class="form-group">
      <label for="email" class="sr-only">Ingresa tu usuario</label>
      <input type="email"
             class="form-control"
             name="email"
             id="email"
             placeholder="Ingresa tu usuario"
             v-model="credenciales.email"
      >
    </div>
    <div class="form-group">
      <label for="password"
             class="sr-only">Ingresa tu password</label>
      <input type="password"
             class="form-control"
             name="password"
             id="password"
             placeholder="Ingresa tu password"
             v-model="credenciales.password"
      >
    </div>
    <div class="button">
      <button type="submit" class="btn btn-outline-primary">Ingresar al sitio</button>
    </div>
  </form>
</template>

<script>
import authService from "../services/auth";
import store from './../store';

export default {
name: "login-form",
  props:{},
  data: () => ({
    credenciales: {
      email: null,
      password: null
    },
    status:{
      titulo: null,
      mensaje: null,
      tipo: 'info'
    },
    store
  }),
  computed: {},
  methods: {
    login: function (credenciales){
      authService
      .login(credenciales)
      .then(res => {
        if(res !== false){
          this.status = {
            titulo: 'Éxito',
            mensaje: 'Bienvenido al Foro de ADDCAR!',
            status: 'success'
          };
          this.store.auth = {
            id: res.id,
            email: res.email,
            usuario: res.usuario,
            imagen: res.imagen,

          };
          // Guardamos el usuario en localStorage.
          localStorage.setItem('user', JSON.stringify(this.store.auth));
          this.$router.push('/perfil');
        }else{
          this.status = {
            titulo: 'Error',
            mensaje: 'Las credenciales son incorrectas. Intenta nuevamente.',
            tipo: 'danger.'
          }
        }
      })
    }
  }
}
</script>
