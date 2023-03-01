<template>
  <div class="d-flex flex-wrap gap-8 justify-content-between scroll align-content-start">
    <AmigosListadoCard
      v-for="amigo in listadoAmigos"
      :key="amigo.id_amigo"
      :amigo="amigo"
      @eliminar-amigo="$emit('eliminar-amigo', amigo.id_amigo, amigo.username)"
    />
  </div>
</template>

<script>
import AmigosListadoCard from "@/components/amigos/AmigosListadoCard";

export default {
  name: "AmigosListado",
  components: {
    AmigosListadoCard,
  },
  props: {
    listadoAmigos: {
      type: Array,
      required: true,
    },
  },
  data: function () {
    return {};
  },
};
</script>
