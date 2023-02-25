<template>
  <div class="col-12 col-md-6">
    <SpinnerLoader v-if="estaCargando" />
    <div class="bg-white p-3 rounded box-sh" v-else>
      <div>
        <img
          :src="imagenPath"
          alt="Imagen del Evento"
          class="img-fluid rounded mb-3"
        />
        <h2 class="p-0 m-0">{{ evento.titulo }}</h2>
        <p class="f-14 text-secondary p-0 m-0">
          Organizado por:
          <span class="badge badge-dark">{{ evento.username }}</span>
        </p>
        <p class="mt-2">{{ evento.cuerpo }}</p>
        <p>
          <span class="f-14 text-secondary mr-2">
            <i class="bi bi-calendar2-event text-danger"></i>
            {{ evento.fecha }}</span
          >
          <span class="f-14 text-secondary">
            <i class="bi bi-geo text-danger"></i>
            {{ evento.localizacion }}</span
          >
        </p>
      </div>
      <div class="mb-3">
        <ListadoMisAmigos :amigos="ParticipantesOrdenados" class="mt-3"/>
      </div>
      <div class="text-right">
        <button class="btn btn-success mr-2">Quiero asistir</button>
        <button class="btn btn-outline-danger">Eliminar participación</button>
      </div>
    </div>
  </div>
</template>

<script>
import { PATH_IMGS } from "@/constants";
import eventosService from "@/services/eventos";
import participantesService from "@/services/participantes";
import ListadoMisAmigos from "@/components/ListadoMisAmigos";
import SpinnerLoader from "@/components/SpinnerLoader";

export default {
  name: "Evento",
  props: {},
  components:{
    ListadoMisAmigos,
    SpinnerLoader,
  },

  data: function () {
    return {
      evento: {
        id_evento: null,
        titulo: null,
        cuerpo: null,
        fecha: null,
        localizacion: null,
        imagen: null,
        id_usuario: null,
        userimg: null,
        username: null,
      },
      participantes: [],
      estaCargando: true,
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
      return this.evento.userimg !== null && this.evento.userimg !== "";
    },
    
    ParticipantesOrdenados: function () {
      const participantes = this.participantes.slice();
      participantes.reverse();
      return participantes;
    },
  },
  methods: {},
  mounted() {

    const id = this.$route.params.id;

    eventosService.getByPk(id).then((data) => {
      this.evento = data;
      this.estaCargando = false;
    });
    
    participantesService.traerUsuariosPorEvento(id).then((data) => {
      this.participantes = data;
    });
  },
};
</script>
