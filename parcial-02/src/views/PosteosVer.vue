<template>
  <section class="container-fluid" id="posteo">
    <div class="container">
      <div class="row justify-content-center">
        <Posteo />
        <SpinnerLoader v-if="estaCargando" />
        <ComentariosLista v-else :comentarios="comentariosOrdenados" />
      </div>
    </div>
  </section>
</template>

<script>
import SpinnerLoader from "@/components/SpinnerLoader";
import ComentariosLista from "@/components/ComentariosLista";
import Posteo from "@/components/Posteo";
import store from "@/store";
import comentariosService from "@/services/comentarios";

export default {
  name: "PosteosVer",
  components: {
    SpinnerLoader,
    Posteo,
    ComentariosLista,
  },
  data: function () {
    return {
      store,
      estaCargando: true,
      comentarios: [],
    };
  },
  computed: {
    comentariosOrdenados: function () {
      const comentarios = this.comentarios.slice();
      comentarios.reverse();
      return comentarios;
    },
  },
  methods: {
    refrescarComentarios() {
      this.estaCargando = true;
      comentariosService.getAll().then((response) => {
        this.estaCargando = false;
        this.comentarios = response;
      });
    },
  },
  mounted: function () {
    this.estaCargando = true;
    const id = this.$route.params.id;
    comentariosService.getByPk(id).then((response) => {
      this.estaCargando = false;
      this.comentarios = response;
    });
  },
};
</script>
