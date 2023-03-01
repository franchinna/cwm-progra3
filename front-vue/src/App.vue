<template>
  <div id="app">
    <header class="d-block">
      <nav class="navbar navbar-expand-lg navbar-light">
        <router-link class="navbar-brand" to="/">
          <h1 class="logo">AddcarApp El Foro</h1>
        </router-link>
        <button
          class="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarNavAltMarkup"
          aria-controls="navbarNavAltMarkup"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span class="navbar-toggler-icon"></span>
        </button>
        <div
          class="collapse navbar-collapse justify-content-end"
          id="navbarNavAltMarkup"
        >
          <div class="navbar-nav align-content-center">
            <ul class="navbar-nav">
              <li class="nav-item" v-if="store.auth.id !== null">
                <router-link
                  class="nav-link d-flex align-items-center"
                  data-ancla="true"
                  to="/PosteoNuevo"
                  title="Nuevo post"
                >
                  <i class="bi bi-plus-circle"></i>
                </router-link>
              </li>
              <li class="nav-item">
                <router-link
                  class="nav-link"
                  data-ancla="true"
                  to="/"
                  title="Home"
                >
                  <i class="bi bi-house-door"></i>
                </router-link>
              </li>
              <!--Proximamente notificaciones-->
              <li class="nav-item d-none" v-if="store.auth.id !== null">
                <router-link
                  class="nav-link"
                  data-ancla="true"
                  to="#"
                  title="Notificaciones"
                >
                  <i class="bi bi-bell"></i>
                </router-link>
              </li>
              <li class="nav-item dropdown" v-if="store.auth.id !== null">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  role="button"
                  data-toggle="dropdown"
                  aria-expanded="false"
                  title="Perfil"
                >
                  <img
                    :src="imagenPath"
                    alt=""
                    class="img-fluid"
                    style="width: 30px; border-radius: 100px"
                  />
                </a>
                <div class="dropdown-menu">
                  <router-link class="dropdown-item" to="/perfil">
                    <i class="bi bi-person-circle"></i>Mi perfil</router-link
                  >
                  <router-link class="dropdown-item" to="/amigos">
                    <i class="bi bi-people"></i>Mis Amigos</router-link
                  >
                  <a class="dropdown-item" href="#" @click="logout">
                    <i class="bi bi-box-arrow-in-right"></i>Cerrar sesión</a
                  >
                </div>
              </li>
              <li class="nav-item" v-if="store.auth.id === null">
                <router-link class="nav-link" to="/login">Login </router-link>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </header>
    <BaseNotificacion
      v-if="store.status.mensaje != null"
      :titulo="store.status.titulo"
      :mensaje="store.status.mensaje"
      :tipo="store.status.tipo"
      @close="closeNotification()"
    />
    <router-view />
  </div>
</template>

<script>
import store from "./store";
import BaseNotificacion from "./components/BaseNotificacion";
import authService from "./services/auth";
import { PATH_IMGS } from "@/constants";

export default {
  name: "App",
  components: {
    BaseNotificacion,
  },
  data: function () {
    return {
      store,
    };
  },
  mounted: function () {
    if (localStorage.getItem("user") !== null) {
      this.store.auth = JSON.parse(localStorage.getItem("user"));
      authService.logUser(this.store.auth);
    }
  },
  methods: {
    closeNotification() {
      this.store.clearStatus();
    },

    logout() {
      authService.logout().then((res) => {
        // Deslogueamos al usuario.
        this.store.auth = {
          id: null,
          email: null,
          usuario: null,
          imagen: null,
        };

        this.estaCargando = false;
        // Lo borro de localStorage.
        localStorage.removeItem("user");
        this.store.clearStatus();
        this.$router.push("/login");
      });
    },
  },
  computed: {
    /**
     * @return {String}
     */
    imagenPath() {
      return `${PATH_IMGS}/perfil/${this.store.auth.imagen}`;
    },

    /**
     *
     * @return {boolean}
     */
    tieneImagen() {
      return this.store.auth.imagen !== null && this.store.auth.imagen !== "";
    },
  },
};
</script>
