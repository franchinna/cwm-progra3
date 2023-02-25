<template>
  <div class="d-flex flex-column text-center justify-items-center">
    <div class="w-100 bg-light p-3 rounded border">
      <BaseNotificacion
          :titulo="status.titulo"
          :mensaje="status.mensaje"
          :tipo="status.tipo"
          v-if="status.mensaje != null"
      />

      <SpinnerLoader v-if="estaCargando"/>

      <div class="col-12 col-md col-lg bg-light">
        <h3 class="bg-light">Edita tus datos personales</h3>
        <form action="#"
              id="form-login"
              method="POST"
              @submit.prevent="grabar(usuario)"
        >
          <div class="form-group">
            <label for="usuario"
                   class="sr-only">Modifica tu nombre de usuario
            </label>
            <input
                type="text"
                class="form-control"
                id="usuario"
                placeholder="Modifica tu nombre de usuario"
                v-model="usuario.usuario"
                :disabled="estaCargando"
                :aria-describedby="errores.usuario != null ? 'usuario-error' : ''">
            <div
                id="usuario-error"
                class="invalid-feedback"
                v-if="errores.usuario != null"
                :style="errores.usuario != null ? 'display: block' : 'display: none'"
            >
              {{ errores.usuario[0] }}
            </div>
          </div>
          <button
              type="submit"
              class="btn btn-primary float-right"
          >Confirmar edición
          </button>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import store from "@/store";
import BaseNotificacion from "@/components/BaseNotificacion";
import SpinnerLoader from "@/components/SpinnerLoader";
import UsersService from "@/services/users";

export default {
  name: "PerfilEditar",
  components: {BaseNotificacion, SpinnerLoader},
  data: function () {
    return {
      store,
      estaCargando: false,
      editarUser: false,
      usuarios: [],
      usuario: {
        usuario: null,
        imagen: null,
      },
      errores: {
        usuario: null,
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
      if (this.estaCargando) {
        return null;
      }
      this.estaCargando = true;

      UsersService
          .edit(usuario.id, usuario)
          .then(res => {
                if (res !== false) {
                  this.estaCargando = false;
                  this.errores = {
                    usuario: null,
                  };
                  this.store.setStatus({
                    titulo: "Éxito",
                    mensaje: "El usuario se editó exitosamente.",
                    tipo: "success",
                  });
                  this.store.auth = {
                    id: res.data.id,
                    email: res.data.email,
                    usuario: res.data.usuario,
                    imagen: res.data.imagen,
                  };
                  localStorage.setItem('user', JSON.stringify(this.store.auth));

                  this.$emit('click', this.editarUser);
                  this.store.clearStatus();
                } else {
                  if (typeof res.errores == 'object') {
                    this.errores = res.errores;
                  }
                  this.status.titulo = "Error";
                  this.status.mensaje = "Ocurrió un error al tratar de editar el usuario.";
                  this.status.tipo = "danger";
                }
              }
          );
    }
  },
  mounted() {
    const id = store.auth.id;
    UsersService
        .getByPk(id)
        .then(data => {
          this.usuario = data;
        });
  }
}
</script>

<style scoped>

</style>