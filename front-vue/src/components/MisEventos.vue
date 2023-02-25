<template>
  <a href="#">
    <SpinnerLoader v-if="estaCargando" />
    <div class="d-flex align-items-center bg-white rounded p-2 border box-sh mb-2" v-for="evento in eventos" :key="evento.id_evento">
      <div>
        <img :src="imagenPath" alt="" class="img-fluid rounded" />
      </div>
      <div class="col-9">
        <h3 class="m-0 p-0">{{evento.titulo}}</h3>
        <p class="text-secondary p-0 m-0 f-14">
          <i class="bi bi-geo text-danger"></i> {{evento.localizacion}}
        </p>
      </div>
    </div>
  </a>
</template>

<script>
import SpinnerLoader from "@/components/SpinnerLoader";
import store from "../store";
import { PATH_IMGS } from "@/constants";
//import eventosService from "@/services/eventos";

export default {
  name: "ListadoEventos",
  components: {
      SpinnerLoader,
  },
  data: function () {
    return {
      estaCargando: true,
      eventos: [],
    };
  },
  computed: {
    /**
     * @return {String}
     */
    imagenPath() {
      return `${PATH_IMGS}/eventos/mendoza.jpg`;
    },

    /**
     *
     * @return {boolean}
     */
    tieneImagen() {
      return this.evento.userimg !== null && this.evento.userimg !== '';
    },

    eventosOrdenados: function () {
      const eventos = this.eventos.slice();
      eventos.reverse();
      return eventos;
    },
  },
  methods: {
    refrescarEventos() {
      this.estaCargando = true;
      eventosService.getAll().then((response) => {
        this.estaCargando = false;
        this.eventos = response;
      });
    },
  },
  mounted: function () {
    this.estaCargando = true;
    const id = store.auth.id;

    eventosService.getEventosDeUsuario(id).then((response) => {
      this.estaCargando = false;
      this.eventos = response;
    });
  },
};
</script>

<style></style>
