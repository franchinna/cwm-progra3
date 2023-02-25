<template>
  <div class="col">
    <div
      v-if="store.auth.id !== null" class="text-right mb-3"
    >
      <router-link :to="`/ComentarioNuevo/${this.$route.params.id}`" class="btn btn-primary">
        <i class="bi bi-plus-circle"></i>
        Comentar este post
      </router-link>
    </div>
    <ComentarioPosteo
      v-for="comentario in comentarios"
      :key="comentario.id_producto"
      :comentario="comentario"
    ></ComentarioPosteo>
  </div>
</template>

<script>
import ComentarioPosteo from "@/components/ComentarioPosteo";
import store from "@/store";

export default {
  name: "ComentariosLista",
  components: {
    ComentarioPosteo,
  },
  props: {
    comentarios: {
      type: Array,
      required: true,
    },
  },
  data: function(){
    return {
      store,
    }
  }
};
</script>
