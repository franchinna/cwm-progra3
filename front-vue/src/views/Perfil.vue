<template>
  <section class="container-fluid" id="perfil">
    <div class="container">
      <div class="row">
        <div class="col-12 col-md-12 col-lg-3">
          <PerfilDatos v-if="editarUser" @click="editarUsuario()" />
          <PerfilEditar v-else @click="editarUsuario()"/>

          <div class="mt-3">
            <h2>Mis amigos</h2>
            <p class="px-4 py-2 border alert alert-warning text-center" role="alert" v-if="amigos.length === 0"> No tenés amigos </p>
            <ListadoMisAmigos :amigos="AmigosOrdenados" class="mt-3" v-else/>
          </div>
        </div>

        <div class="col-12 col-md col-lg-6">
          <h2>Mis posteos</h2>
          <p
            class="px-4 py-2 border alert alert-warning"
            role="alert"
            v-if="posteos.length === 0"
          >
            No tenés
          </p>
          <ListadoPosteos v-else :posteos="posteosOrdenados" />
          <router-link
            to="/PosteoNuevo"
            class="btn btn-outline-primary w-sm-100 float-right mt-1"
          >
            <i class="bi bi-plus-circle"></i>Nuevo posteo</router-link
          >
        </div>

        <div class="col-12 col-md col-lg-3">
          <h2>Favoritos</h2>
          <p
            class="px-4 py-2 border alert alert-warning text-center"
            role="alert"
          >
            No tenés favoritos
          </p>
          <div class="col-12 col-md col-lg py-2 mb-3 border bg-light rounded box-sh">
            <router-link to="/posteos/20" class="text-decoration-none">
              <h3 class="f-16">Titulo del posteo</h3>
              <p class="m-0 post-fav">
                Esto es un posteo favorito la idea es que haga puntos
              </p>
              <div class="text-right">
                <a href="#" title="No me gusta">
                  <i class="bi bi-hand-thumbs-down"></i>
                </a>
                <a href="#" title="Me gusta">
                  <i class="bi bi-hand-thumbs-up-fill"></i>
                </a>
              </div>
            </router-link>
          </div>
          <div class="col-12 col-md col-lg py-2 mb-3 rounded">
            <img :src="imagenPath" alt="" class="img-fluid">
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import store from "@/store";
import UsersService from "@/services/users";
import AmigosService from "@/services/amigos";
import PerfilEditar from "@/components/PerfilEditar";
import PerfilDatos from "@/components/PerfilDatos";
import ListadoMisAmigos from "@/components/ListadoMisAmigos";
import ListadoPosteos from "@/components/ListadoPosteos";
import PosteosService from "@/services/posteos";
import { PATH_IMGS } from "@/constants";

export default {
  name: "Perfil",
  components: {
    PerfilDatos,
    PerfilEditar,
    ListadoMisAmigos,
    ListadoPosteos,
  },
  data: function () {
    return {
      store,
      editarUser: true,
      estaCargando: true,
      amigos: [],
      posteos: [],
    };
  },
  computed: {
    AmigosOrdenados: function () {
      const amigos = this.amigos.slice();
      amigos.reverse();
      return amigos;
    },
    posteosOrdenados: function () {
      const posteos = this.posteos.slice();
      posteos.reverse();
      return posteos;
    },
    /**
     * @return {String}
     */
    imagenPath() {
      return `${PATH_IMGS}/anuncios/publicidad_1.jpg`;
    },
  },
  methods: {
    editarUsuario: function () {
      if (this.editarUser) {
        this.editarUser = false;
      } else {
        this.editarUser = true;
      }
    },
  },
  mounted() {
    const id = store.auth.id;
    UsersService.getByPk(id).then((data) => {
      this.usuario = data;
    });

    AmigosService.traerAmigosPorUsuario(id).then((data) => {
      this.amigos = data;
    });

    this.estaCargando = true;
    PosteosService.getPosteos(id).then((data) => {
      this.estaCargando = false;
      this.posteos = data;
    });
  },
};
</script>
