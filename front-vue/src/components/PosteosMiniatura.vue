<template>
    <router-link :to="`/posteos/${posteo.id_posteo}`" class="text-decoration-none w-100">
      <article class="posteo mb-2 bg-light box-sh">
        <div
          :class="{
            'd-none': isProfile,
            'd-block': isHome,
          }"
        >
          <div class="d-flex justify-content-between">
            <ul>
              <li>
                <img
                  class="img-fluid border-drop"
                  :src="imagenPath"
                  :alt="'Avatar del usuario' + posteo.email"
                  :title="'Posteo creado por' + posteo.email"
                />
              </li>
              <li>{{ posteo.username }}</li>
              <li>{{ posteo.fecha }}</li>
            </ul>
            <!--Proximamente favs-->
            <div v-if="store.auth.id !== null" class="d-none">
              <div class="text-right">
                <a href="#" title="No me gusta">
                  <i class="bi bi-hand-thumbs-down"></i>
                </a>
                <a href="#" title="Me gusta">
                  <i class="bi bi-hand-thumbs-up"></i>
                </a>
              </div>
            </div>
          </div>
          <hr />
        </div>
        <h3>{{ posteo.titulo }}</h3>
        <p class="pr-2 m-0">{{ posteo.cuerpo }}</p>
      </article>
    </router-link>
</template>

<script>
import store from "@/store";
import posteosService from "@/services/posteos";
import { PATH_IMGS } from "@/constants";

export default {
  name: "PosteosMiniatura",
  props: ["posteo"],
  data: function () {
    return {
      store,
      isProfile: true,
      isHome: false,
    };
  },
  computed: {
    /**
     * @return {String}
     */
    imagenPath() {
      if (this.$route.path === "/perfil") {
        return `${PATH_IMGS}/perfil/${this.store.auth.imagen}`;
      }
      return `${PATH_IMGS}/perfil/${this.posteo.userimg}`;
    },
  },
  methods: {
    eliminar(id) {
      posteosService.deleteItem(id).then((success) => {
        if (success) {
          this.store.setStatus({
            titulo: "Éxito",
            mensaje: "El posteo se eliminó exitosamente.",
            tipo: "success",
          });
          this.$emit("delete");
        } else {
          this.store.setStatus({
            titulo: "Error",
            mensaje: "Ocurrió un error. El posteo NO se pudo eliminar.",
            tipo: "danger",
          });
        }
      });
    },
  },
  mounted() {
      //console.log('se ejecuta');
      if (this.$route.path === "/perfil") {
        this.isHome = false;
        this.isProfile = true;
      }else{
        this.isHome = true;
        this.isProfile = false;
      }
  }
};
</script>
