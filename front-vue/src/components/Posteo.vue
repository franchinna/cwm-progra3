<template>
  <div class="col-7 posteos">
    <div class="row">
      <div class="col-12 col-md-3 col-lg-3 user">
        <div class="row">
          <div class="col-4 col-md-12 col-lg-12">
            <img class="img-fluid rounded"
                 :src="imagenPath"
                 :alt="posteo.usernanme">
          </div>
          <div class="col col-md col-lg">
            <p class="m-0"><small class="mt-2 mb-0 f-14">Creado por: {{ posteo.username }}</small></p>
            <p class="m-0"><small>Fecha de creación: {{ posteo.fecha }}</small></p>
          </div>
        </div>
      </div>
      <div class="col-12 col-md col-lg tema">
        <h2 class="titulo">{{ posteo.titulo }}</h2>
        <hr>
        <p class="cuerpo">{{ posteo.cuerpo }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import {PATH_IMGS} from "@/constants";
import posteosService from "@/services/posteos";

export default {
  name: "Posteo",
  props: {},
  data: function () {
    return {
      posteo: {
        id_posteo: null,
        titulo: null,
        cuerpo: null,
        fecha: null,
        id_usuario: null,
        email: null,
        userimg: null,
        username: null
      },
    }
  },
  computed: {
    /**
     * @return {String}
     */
    imagenPath() {
      return `${PATH_IMGS}/perfil/${this.posteo.userimg}`;
    },

    /**
     *
     * @return {boolean}
     */
    tieneImagen() {
      return this.posteo.userimg !== null && this.posteo.userimg !== '';
    }
  },
  methods: {},
  mounted() {
    const id = this.$route.params.id;
    posteosService
        .getByPk(id)
        .then(data => {
          this.posteo = data;
        });
  },
}
</script>