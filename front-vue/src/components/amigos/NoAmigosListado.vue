<template>
  <div class="d-flex flex-wrap gap-8 justify-content-between scroll-250 align-content-start">
    <NoAmigosListadoCard
      v-for="noamigo in listadoNoAmigos"
      :key="noamigo.id_amigo"
      :noamigo="noamigo"
      @agregar-amigo="$emit('agregar-amigo', noamigo.id_amigo, noamigo.username)"
    />
  </div>
</template>

<script>
import NoAmigosListadoCard from "@/components/amigos/NoAmigosListadoCard";

export default {
  name: "NoAmigosListado",
  components: {
    NoAmigosListadoCard,
  },
  props: {
    listadoNoAmigos: {
      type: Array,
      required: true,
    },
  },
  data: function () {
    return {};
  },
};
</script>
