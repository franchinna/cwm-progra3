<template>
  <div class="d-flex flex-wrap gap-8 justify-content-between scroll-250 align-content-start">
    <AmigosListadoPendientesCard
      v-for="noamigo in listadoPendientes"
      :key="noamigo.id_amigo"
      :noamigo="noamigo"
      @aceptar-amigo="$emit('aceptar-amigo', noamigo.id_amigo, noamigo.username)"
      @eliminar-amigo="$emit('eliminar-amigo', noamigo.id_amigo, noamigo.username)"
    />
  </div>
</template>

<script>
import AmigosListadoPendientesCard from "@/components/amigos/AmigosListadoPendientesCard";

export default {
  name: "AmigosPendientesListado",
  components: {
    AmigosListadoPendientesCard,
  },
  props: {
    listadoPendientes: {
      type: Array,
      required: true,
    },
  },
  data: function () {
    return {};
  },
};
</script>
