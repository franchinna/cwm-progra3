<template>
  <div>
    <h2>Eventos</h2>
    <div v-if="eventos.lenght === 0 " class="box-sh p-2 border text-center alert alert-info" role="alert">
      <p class="m-0 p-0 f-14">Quiero participar de un evento</p>
    </div>
    <EventosMiniatura
      v-else
      v-for="evento in eventos"
      :key="evento.id_evento"
      :evento="evento"/>
    <hr />
  </div>
</template>

<script>
import EventosMiniatura from "@/components/EventosMiniatura";
import store from "@/store";

export default {
  name: "ListadoEventos",
  components: {
    EventosMiniatura
  },
  props: {
    eventos: {
      type: Array,
      required: true
    }
  },
  data: function(){
    return {
      store,
    }
  }
}
</script>
