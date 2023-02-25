<template>
  <router-link :to="`/eventos/${evento.id_evento}`" class="text-decoration-none">
    <div class="d-flex align-items-center bg-light rounded p-2 border box-sh mb-2">
      <div>
        <img 
          :src="imagenPath" 
          :alt="'Imagen del evento de: ' + evento.localizacion" 
          class="img-fluid rounded" />
      </div>
      <div class="col-9">
        <h3 class="m-0 p-0">{{evento.titulo}}</h3>
        <p class="text-secondary p-0 m-0 f-14">
          <i class="bi bi-geo text-danger"></i> {{evento.localizacion}}
        </p>
      </div>
    </div>
  </router-link>
</template>

<script>
import store from "@/store";
import { PATH_IMGS } from "@/constants";

export default {
  name: "EventosMiniatura",
  props: ["evento"],
  data: function () {
    return {
      store,
    };
  },
 computed: {
     /**
      * @return {String}
      */
     imagenPath() {
       return `${PATH_IMGS}/eventos/${this.evento.imagen}`;
     },

     /**
      *
      * @return {boolean}
      */
     tieneImagen() {
       return this.evento.imagen !== null && this.evento.imagen !== "";
     },
  },
  methods: {
  },
};
</script>
