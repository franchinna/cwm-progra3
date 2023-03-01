<template>
        <div-div class="col-2 col-lg-8">
          <h2>Completa el formulario para dejar el comentario</h2>

          <form action="#" method="post" @submit.prevent="grabar(comentario)">
            <BaseNotificacion
              :titulo="status.titulo"
              :mensaje="status.mensaje"
              :tipo="status.tipo"
              v-if="status.mensaje != null"
            />

            <div class="form-group">
              <label for="cuerpo"
                >Comenta sobre el tema que quieras (al menos 10
                caracteres.)
              </label>
              <textarea
                class="form-control"
                id="cuerpo"
                name="textarea"
                v-model="comentario.cuerpo"
                placeholder=""
                rows="6"
                :disabled="estaCargando"
                :aria-describedby="errores.cuerpo != null ? 'cuerpo-error' : ''"
              >
              </textarea>
              <div
                id="cuerpo-error"
                class="invalid-feedback"
                v-if="errores.cuerpo != null"
                :style="
                  errores.cuerpo != null ? 'display: block' : 'display: none'
                "
              >
                {{ errores.cuerpo[0] }}
              </div>
            </div>
            <SpinnerLoader v-if="estaCargando" />

            <div v-else class="button text-right">
              <router-link
                :to="`/posteos/${this.$route.params.id}`"
                class="btn btn-outline-secondary w-lg-25"
                type="button"
              >
                Volver al posteo
              </router-link>
              <button type="submit" class="btn btn-primary ml-lg-2 w-sm-100">
                Enviar Comentario
              </button>
            </div>
          </form>
        </div-div>
</template>

<script>
import store from "@/store";
import BaseNotificacion from "@/components/BaseNotificacion";
import SpinnerLoader from "@/components/SpinnerLoader";
import comentariosService from "@/services/comentarios";
import router from "@/router";

export default {
  name: "ComentarioNuevoForm",
  components: { SpinnerLoader, BaseNotificacion },
  props: {},
  data: function () {
    return {
      store,
      estaCargando: false,
      comentario: {
        cuerpo: null,
        fecha: null,
        id_usuario: store.auth.id,
      },
      errores: {
        cuerpo: null,
      },
      status: {
        titulo: null,
        mensaje: null,
        tipo: "info",
      },
    };
  },
  computed: {},
  methods: {
    grabar: function (comentario) {
      if (this.estaCargando) {
        return null;
      }
      this.estaCargando = true;
      const id = this.$route.params.id;
      comentariosService.create(id, comentario).then((response) => {
        this.estaCargando = false;
        if (response.success) {
          this.comentario = {
            cuerpo: null,
            fecha: null,
            id_usuario: null,
          };
          this.errores = {
            cuerpo: null,
          };
          this.store.setStatus({
            titulo: "Éxito",
            mensaje: "El comentario se creó exitosamente.",
            tipo: "success",
          });
          //:to="`/ComentarioNuevo/${this.$route.params.id}`"
          router.push("/");
        } else {
          this.errores = response.errores;
          this.status.titulo = "Error";
          this.status.mensaje =
            "Ocurrió un error al tratar de grabar el comentario.";
          this.status.tipo = "danger";
        }
      });
    },
  },
};
</script>

<style scoped></style>
