<template>
  <div class="d-flex flex-column text-center justify-items-center">
    <div class="w-100 bg-light p-3 rounded border">
      <div class="text-right">
      <a
        type="button"
        title="Editar perfil"
        class="btn btn-light f-14 btn-edit-user"
        @click="$emit('click', editarUser)"
      >
        <i class="bi bi-pencil-square m-0"></i>
      </a>
      </div>

      <img 
        :src="imagenPath"
        :alt="usuario.email"
        class="img-fluid avatar">
        
      <h3 class="my-2"><span class="f-24 font-bold">{{usuario.usuario}}</span></h3>

      <ul class="list-group text-left my-3">
        <li class="text-secondary"><i class="bi bi-upc-scan"></i># {{usuario.id}}</li>
        <li class=""><i class="bi bi-person-circle"></i><b>{{usuario.usuario}}</b></li>
        <li class=""><i class="bi bi-envelope-at"></i><b>{{usuario.email}}</b></li>
      </ul>

      <ul class="social-networks mt-3">
        <li><a href="#" title="Proximamente!"><i class="bi bi-facebook f-24 text-secondary m-0"></i></a></li>
        <li><a href="#" title="Proximamente!"><i class="bi bi-github f-24 text-secondary m-0"></i></a></li>
        <li><a href="#" title="Proximamente!"><i class="bi bi-twitter f-24 text-secondary m-0"></i></a></li>
      </ul>

    </div>
  </div>
</template>

<script>
import store from "@/store";
import UsersService from "@/services/users";
import { PATH_IMGS } from "@/constants";

export default {
  name: "PerfilDatos",
  data: function () {
    return {
      usuario: {
        id: null,
        usuario: null,
        email: null,
        imagen: null,
        password: null,
      },
      editarUser: false,
    };
  },
  computed: {
    /**
     * @return {String}
     */
    imagenPath() {
      return `${PATH_IMGS}/perfil/${store.auth.imagen}`;
    },

    /**
     *
     * @return {boolean}
     */
    tieneImagen() {
      return store.auth.imagen !== null && store.auth.imagen !== "";
    },
  },
  mounted() {
    const id = store.auth.id;
    UsersService.getByPk(id).then((data) => {
      this.usuario = data;
    });
  },
};
</script>

<style scoped></style>
