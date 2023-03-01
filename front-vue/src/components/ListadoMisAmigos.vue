<template>
    <div class="mb-1">
        <AmigosMiniatura
        v-for="amigo in amigos"
        :key="amigo.id_amigo"
        :amigo="amigo"
      />
      <p class="f-14 mt-2 text-secondary" v-if="this.$route.name === 'Perfil'">Tenés {{ amigos.length }} amigos</p>
      <p class="f-14 mt-2 text-secondary" v-if="this.$route.name === 'EventosVer'"><b>{{ amigos.length }}</b> participantes</p>
    </div>
</template>

<script>
import store from "@/store";
import AmigosMiniatura from "@/components/AmigosMiniatura";

export default {
  name: "ListadoMisAmigos",
  components: {
    AmigosMiniatura,
  },
  props: {
    amigos: {
      type: Array,
      required: true
    }
  },
  data: function () {
    return {
      store,
    };
  },
};
</script>