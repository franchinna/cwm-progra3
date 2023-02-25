<template>
    <img 
      :src="imagenPath" 
      :alt="'Avatar de ' + amigo.username"
      :title="amigo.username"
      class="avatar-amigo img-fluid">
</template>

<script>
import store from "@/store";
import { PATH_IMGS } from "@/constants";

export default {
  name: "AmigosMiniatura",
  props: ["amigo"],
  data: function () {
    return {
      store,
    };
  },
  computed: {
    /**
     * @return {String}
     */
    imagenPath() {
      return `${PATH_IMGS}/perfil/${this.amigo.userimg}`;
    },

    /**
     *
     * @return {boolean}
     */
    tieneImagen() {
      return this.amigo.userimg !== null && this.amigo.userimg !== "";
    },

    
  },
  methods: {},
};
</script>

<style></style>
