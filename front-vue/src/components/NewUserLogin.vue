<template>

  <form action="#"
        @submit.prevent="grabar(usuario)"
        method="post">

    <div class="form-group">
      <label for="email"
             class="sr-only">Ingresá tu correo
      </label>
      <input
          type="email"
          class="form-control"
          id="email"
          placeholder="Ingresá tu correo"
          v-model="usuario.email"
          :aria-describedby="errores.email != null ? 'email-error' : ''">
      <div
          id="email-error"
          class="invalid-feedback"
          v-if="errores.email != null"
          :style="errores.email != null ? 'display: block' : 'display: none'"
      >
        {{ errores.email[0] }}
      </div>
    </div>

    <div class="form-group">
      <label for="verificarEmail"
             class="sr-only">Ingresá nuevamente tu correo
      </label>
      <input
          type="email"
          class="form-control"
          id="verificarEmail"
          placeholder="Ingresá nuevamente tu correo"
          v-model="usuario.verificarEmail"
          :aria-describedby="errores.verificarEmail != null ? 'verificarEmail-error' : ''">
      <div
          id="verificarEmail-error"
          class="invalid-feedback"
          v-if="errores.verificarEmail != null"
          :style="errores.verificarEmail != null ? 'display: block' : 'display: none'"
      >
        {{ errores.verificarEmail[0] }}
      </div>
    </div>
    <div class="form-group">
      <label for="password"
             class="sr-only">Ingrese su password
      </label>
      <input
          type="password"
          class="form-control"
          id="password"
          placeholder="Ingresá tu password"
          v-model="usuario.password"
          :aria-describedby="errores.password != null ? 'password-error' : ''">
      <div
          id="password-error"
          class="invalid-feedback"
          v-if="errores.password != null"
          :style="errores.password != null ? 'display: block' : 'display: none'"
      >
        {{ errores.password[0] }}
      </div>
    </div>
    <div class="form-group">
      <label for="passwordConfirm"
             class="sr-only">Ingresá nuevamente tu password
      </label>
      <input
          type="password"
          class="form-control"
          id="passwordConfirm"
          placeholder="Ingresá nuevamente tu password"

          v-model="usuario.verificarPassword"
          :aria-describedby="errores.verificarPassword != null ? 'verificarPassword-error' : ''">
      <div
          id="verificarPassword-error"
          class="invalid-feedback"
          v-if="errores.verificarPassword != null"
          :style="errores.verificarPassword != null ? 'display: block' : 'display: none'"
      >
        {{ errores.verificarPassword[0] }}
      </div>
    </div>
    <div class="button">
      <button
          type="submit"
          class="btn btn-outline-primary">Crear usuario
      </button>
    </div>
  </form>
</template>

<script>
import UsersService from "./../services/users";
import store from './../store';

export default {
  name: "NewUserLogin",
  components: {},

  data: function () {
    return {
      store,
      usuario: {
        email: null,
        password: null,
        verificarEmail: null,
        verificarPassword: null
      },
      errores: {
        email: null,
        verificarEmail: null,
        password: null,
        verificarPassword: null
      },
      status: {
        titulo: null,
        mensaje: null,
        tipo: 'info'
      }
    }
  },
  computed: {},
  methods: {
    grabar: function (usuario) {
      UsersService
          .create(usuario)
          .then(response => {
            if (response.success) {
              this.usuario = {
                id: null,
                usuario: null,
                email: null
              };
              this.errores = {
                email: null,
                verificarEmail: null,
                password: null,
                verificarPassword: null,
              };
              this.store.setStatus({
                titulo: "Éxito",
                mensaje: "El usuario se creó exitosamente.",
                tipo: "success",
              });
              this.$router.push('/login')
            } else {
              this.errores = response.errores;
              this.status.titulo = "Error";
              this.status.mensaje = "Ocurrió un error al tratar de grabar el usuario.";
              this.status.tipo = "danger";
            }
          });
    }
  }
}
</script>

<style scoped>

</style>