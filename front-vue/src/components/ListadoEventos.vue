<template>
  <div>
    <div class="d-flex justify-content-between mb-2">
      <h2 class="d-inline-block p-0 m-0">Eventos</h2>
      <!--Proximamente crear eventos para usaurios-->
      <router-link
        to="/EventoNuevo"
        class="btn btn-light mr-3 d-none"
        title="Crear evento"
        v-if="store.auth.id !== null"
      >
        <i class="bi bi-calendar2-plus m-0 p-0"></i>
      </router-link>
    </div>
    <div
      class="d-flex flex-wrap justify-content-between scroll align-content-start py-2"
    >
      <EventosMiniatura
        v-for="evento in eventos"
        :key="evento.id_evento"
        :evento="evento"
      />
    </div>
  </div>
</template>

<script>
import EventosMiniatura from "@/components/EventosMiniatura";
import store from "@/store";

export default {
  name: "ListadoEventos",
  components: {
    EventosMiniatura,
  },
  props: {
    eventos: {
      type: Array,
      required: true,
    },
  },
  data: function () {
    return {
      store,
    };
  },
};
</script>
