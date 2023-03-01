<template>
  <div class="bg-white rounded border box-sh w-100 d-flex justify-content-between align-content-center py-2 px-3 mr-2">
    <img
      :src="imagenPath"
      :alt="'Avatar de ' + amigo.username"
      :title="amigo.username"
      style="width: 32px; height: 32px"
      class="bg-warning border-drop my-auto"
    />
    <p class="m-auto col">{{amigo.username}}</p>
    <ul class="list-inline m-0">
      <!--Proximamente perfil de amigo-->
      <li class="list-inline-item d-none">
        <a href="" class="btn btn-light">
          <i class="m-0 bi bi-eye"></i>
        </a>
      </li>
      <li class="list-inline-item">
        <button @click="$emit('eliminar-amigo')" class="btn btn-outline-danger">
          <i class="m-0 bi bi-trash3"></i>          
        </button>
      </li>
    </ul>

    </div>
</template>

<script>
import { PATH_IMGS } from "@/constants";
import store from "@/store";


export default {
  name: "AmigosListadoCard",
  components: {},
  props: ["amigo"],
  data: function () {
    return {
      store,
    };
  },
  methods:{ },
  computed: {
    imagenPath() {
      return `${PATH_IMGS}/perfil/${this.amigo.userimg}`;
    },

    tieneImagen() {
      return this.amigo.userimg !== null && this.amigo.userimg !== "";
    },
  },
};
</script>
