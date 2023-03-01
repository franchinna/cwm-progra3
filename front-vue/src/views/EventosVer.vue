<template>
  <section class="container-fluid" id="evento">
    <div class="container">
      <div class="row justify-content-center">
        <Evento />
        <!--Proximamente comentar eventos-->
        <div class="col-12 col-md-6 d-none">
          <div class="text-right" v-if="store.auth.id !== null">
            <form action="#" method="post" @submit.prevent="grabar()">
              <BaseNotificacion
                :titulo="status.titulo"
                :mensaje="status.mensaje"
                :tipo="status.tipo"
                v-if="status.mensaje != null"
              />

              <button class="btn btn-primary mb-2">Comentar evento</button>

              <div class="form-group">
                <label for="cuerpo" class="sr-only"
                  >Escribe sobre el tema que quieres hablar
                </label>
                <textarea
                  class="form-control"
                  id="cuerpo"
                  name="textarea"
                  placeholder="Escribe sobre el tema que quieres hablar"
                  rows="3"
                  :disabled="estaCargando"
                  :aria-describedby="
                    errores.cuerpo != null ? 'cuerpo-error' : ''
                  "
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
            </form>
          </div>
          <div class="text-center bg-light" v-else>
            <p class="py-3">
              <router-link to="/login"><b>Inicia sesión</b></router-link> para
              comentar el evento.
            </p>
          </div>
          <div class="comentarios mb-3 bg-white">
            <p>comentario.cuerpo</p>
            <p class="f-14 text-secondary m-0">
              Creado el día "comentario.fecha" por "comentario.username"
            </p>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import store from "@/store";

import SpinnerLoader from "@/components/SpinnerLoader";
import Evento from "@/components/Evento";

export default {
  name: "EventosVer",
  components: {
    SpinnerLoader,
    Evento,
  },
  data: function () {
    return {
      store,
      estaCargando: false,
      comentarios: [],
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
  methods: {},
  mounted: function () {},
};
</script>
