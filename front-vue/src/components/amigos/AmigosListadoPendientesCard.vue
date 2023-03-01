<template>
  <div class="bg-white rounded border box-sh w-100 d-flex justify-content-between align-content-center py-2 px-3 mr-2">
    <img
      :src="imagenPath"
      :alt="'Avatar de ' + noamigo.username"
      :title="noamigo.username"
      style="width: 32px; height: 32px"
      class="bg-warning border-drop my-auto"
    />
    <p class="m-auto col">{{noamigo.username}}</p>
    <ul class="list-inline m-0">
      <li class="list-inline-item">
        <button class="btn btn-danger" @click="$emit('eliminar-amigo')">
          <i class="m-0 bi bi-trash text-white"></i>
        </button>
      </li>
      <li class="list-inline-item">
        <button @click="$emit('aceptar-amigo')" class="btn btn-success">
          <i class="m-0 bi bi-person-add text-white"></i>
        </button>
      </li>
    </ul>
  </div>
</template>

<script>
import { PATH_IMGS } from "@/constants";

export default {
  name: "NoAmigosListadoCard",
  components: {},
  props: ["noamigo"],
  data: function () {
    return {};
  },
  computed: {
    imagenPath() {
      return `${PATH_IMGS}/perfil/${this.noamigo.userimg}`;
    },

    tieneImagen() {
      return this.noamigo.userimg !== null && this.noamigo.userimg !== "";
    },
  },
};
</script>