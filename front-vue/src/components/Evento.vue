<template>
  <div class="col-12 col-md-6">
    <SpinnerLoader v-if="estaCargando" />
    <div class="bg-white p-3 rounded box-sh" v-else>
      <div>
        <img
          :src="ImagenPath"
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
        <SpinnerLoader v-if="estaCargandoParticipantes" class="bg-white"/>
        <ListadoMisAmigos :amigos="ParticipantesOrdenados" class="mt-3" v-else/>
      </div>
      <div class="text-right" v-if="store.auth.id != null">
        <button
          class="btn btn-success mr-2"
          v-if="UsuarioParticipa"
          @click="quieroAsistir(participante)"
        >
          Quiero asistir
        </button>
        <button class="btn btn-outline-danger" v-else
          @click="quieroBajarme(participante)">
          Eliminar asistencia
        </button>
      </div>
      <div class="text-center bg-light" v-else>
        <p class="py-3 m-0">
          <router-link to="/login"><b>Inicia sesión</b></router-link> para asistir al evento
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import { PATH_IMGS } from "@/constants";
import store from "@/store";

import eventosService from "@/services/eventos";
import participantesService from "@/services/participantes";
import ListadoMisAmigos from "@/components/ListadoMisAmigos";
import SpinnerLoader from "@/components/SpinnerLoader";

export default {
  name: "Evento",
  props: {},
  components: {
    ListadoMisAmigos,
    SpinnerLoader,
  },

  data: function () {
    return {
      store,
      estaCargando: true,
      estaCargandoParticipantes: true,
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
      participante: {
        id_evento: null,
        id_usuario: null,
      },
    };
  },
  computed: {
    /**
     * @return {String}
     */
    ImagenPath() {
      return `${PATH_IMGS}/eventos/${this.evento.imagen}`;
    },

    ParticipantesOrdenados: function () {
      const participantes = this.participantes.slice();
      participantes.reverse();
      return participantes;
    },

    UsuarioParticipa: function () {
      const participante = this.participantes.find(
        (participante) => participante.id_usuario === this.store.auth.id
      );

      if (participante) {
        console.log("El usuario está en el evento");
        return false;
      } else {
        console.log("El usuario no está en el evento");
        return true;
      }
    },
  },
  methods: {
    quieroAsistir: function (participante) {
      this.participante.id_evento = this.$route.params.id;
      this.participante.id_usuario = store.auth.id;

      console.log("se ejecuta", this.participante);

      participantesService.create(participante).then((response) => {
        this.estaCargando = false;
        if (response.success) {
          this.participante = {
            id_evento: null,
            id_usuario: null,
          };
          this.store.setStatus({
            titulo: "Éxito",
            mensaje: "El registro para el evento se creó exitosamente.",
            tipo: "success",
          });

          const id = this.$route.params.id;

          participantesService.traerUsuariosPorEvento(id).then((data) => {
            this.participantes = data;
          });
        } else {
          this.store.setStatus({
            titulo: "Error",
            mensaje: "Ocurrió un error al tratar de registrar tu participación. Intentá de nuevo más tarde",
            tipo: "danger",
          });
        }
      });
    },

    quieroBajarme: function (participante) {
      this.participante.id_evento = this.$route.params.id;
      this.participante.id_usuario = store.auth.id;
      const id = this.$route.params.id;

      console.log("quieroBajarme se ejecuta", this.participante);

      participantesService
        .deleteItem(this.participante.id_evento, participante)
        .then((success) => {
          this.estaCargando = false;
          if (success) {
            this.participante = {
              id_evento: null,
              id_usuario: null,
            };
            this.store.setStatus({
              titulo: "Éxito",
              mensaje: "El registro para el evento se eliminó exitosamente.",
              tipo: "success",
            });
            participantesService.traerUsuariosPorEvento(id).then((data) => {
              this.participantes = data;
            });
          } else {
            this.store.setStatus({
              titulo: "Error",
              mensaje: "Ocurrió un error al tratar de registrar tu participación. Intentá de nuevo más tarde",
              tipo: "danger",
            });
          }
      });
    },
  },
  mounted() {
    const id = this.$route.params.id;

    eventosService.getByPk(id).then((data) => {
      this.estaCargando = false;
      this.evento = data;
    });

    participantesService.traerUsuariosPorEvento(id).then((data) => {
      this.estaCargandoParticipantes = false;
      this.participantes = data;
    });
  },
};
</script>
