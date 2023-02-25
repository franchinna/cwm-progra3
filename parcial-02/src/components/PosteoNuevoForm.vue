<template>
  <form action="#"
        method="post"
        @submit.prevent="grabar(posteo)">

    <BaseNotificacion
        :titulo="status.titulo"
        :mensaje="status.mensaje"
        :tipo="status.tipo"
        v-if="status.mensaje != null"
    />

    <div class="form-group">
      <label for="titulo" class="small">
        Título del posteo</label>
      <input
          type="text"
          class="form-control"
          id="titulo"
          placeholder="Tengo problemas con el auto"
          v-model="posteo.titulo"
          :disabled="estaCargando"
          :aria-describedby="errores.titulo != null ? 'titulo-error' : ''">
      <div
          id="titulo-error"
          class="invalid-feedback"
          v-if="errores.titulo != null"
          :style="errores.titulo != null ? 'display: block' : 'display: none'"
      >
        {{ errores.titulo[0] }}
      </div>
    </div>

    <div class="form-group">
      <label for="cuerpo"
             class="small">Escribe sobre el tema que quieres hablar
      </label>
      <textarea
          class="form-control"
          id="cuerpo"
          name="textarea"
          v-model="posteo.cuerpo"
          placeholder="Acá poné tu comentario"
          rows="6"
          :disabled="estaCargando"
          :aria-describedby="errores.cuerpo != null ? 'cuerpo-error' : ''">
      </textarea>
      <div
          id="cuerpo-error"
          class="invalid-feedback"
          v-if="errores.cuerpo != null"
          :style="errores.cuerpo != null ? 'display: block' : 'display: none'"
      >
        {{ errores.cuerpo[0] }}
      </div>
    </div>
    <SpinnerLoader v-if="estaCargando"/>

    <div v-else class="text-right">
      <button
          type="submit"
          class="btn btn-primary w-sm-100">Publicar tema
      </button>
    </div>
  </form>
</template>

<script>
import store from "@/store";
import BaseNotificacion from "@/components/BaseNotificacion";
import SpinnerLoader from "@/components/SpinnerLoader";
import posteosService from "@/services/posteos";
import router from "@/router";


export default {
  name: "PosteoNuevoForm",
  components: {SpinnerLoader, BaseNotificacion},
  props: {},
  data: function () {
    return {
      store,
      estaCargando: false,
      posteo: {
        titulo: null,
        cuerpo: null,
        fecha: null,
        email: store.auth.email,
        id_usuario: store.auth.id
      },
      errores: {
        titulo: null,
        cuerpo: null
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
    grabar: function (posteo) {
      if (this.estaCargando) {
        return null;
      }

      this.estaCargando = true;

      posteosService
          .create(posteo)
          .then(response => {
            this.estaCargando = false;
            if (response.success) {
              this.posteo = {
                titulo: null,
                cuerpo: null,
                fecha: null,
                email: null,
                id_usuario: null
              };
              this.errores = {
                titulo: null,
                cuerpo: null
              };
              this.store.setStatus({
                titulo: "Éxito",
                mensaje: "El posteo se creó exitosamente.",
                tipo: "success",
              });
              router.push('/');
            } else {
              this.errores = response.errores;
              this.status.titulo = "Error";
              this.status.mensaje = "Ocurrió un error al tratar de grabar el posteo.";
              this.status.tipo = "danger";
            }
          });
    }
  }
}
</script>

<style scoped>

</style>