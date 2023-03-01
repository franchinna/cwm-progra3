<template>
  <section class="container-fluid">
    <div class="container">
      <div class="row">
        <div class="col-12 col-lg-8">
          <SpinnerLoader v-if="estaCargandoPosteosAmigos" />
          <AmigosListadoPosteos
            v-else-if="posteosAmigos.length !== 0"
            :posteosamigos="posteosAmigosOrdenados"
            @delete="refrescarPosteosAmigos()"
          />
            <div class="text-center" v-else>
              <p class="py-2 alert alert-warning">
                Buuu! Tus amigos no postearon nada. Son unos aburridos!
              </p>
            </div>
        </div>

        <div class="col-12 col-lg-4">
          <h3>Listado de Amigos</h3>
          <div class="mb-4">
            <SpinnerLoader v-if="estaCargandoAmigos" />
            <AmigosListado
              @eliminar-amigo="eliminarAmigo"
              :listadoAmigos="ListadoAmigosOrdenados"
              v-else-if="listadoAmigos.length !== 0"
            />
            <div class="text-center" v-else>
              <p class="py-2 alert alert-warning">
                Buuu! No tenés amigos, ¡Agregá uno!
              </p>
            </div>
          </div>
          <div v-if="listadoPendientes.length !== 0" class="mb-4">
            <h3>Solicitudes pendientes</h3>
            <SpinnerLoader v-if="estaCargandoAmigosPendientes" />
            <AmigosListadoPendientes
              :listadoPendientes="ListadoAmigosPendientesOrdenados"
              @aceptar-amigo="aceptarAmigo"
              @eliminar-amigo="eliminarAmigo"
              v-else
            />
          </div>
          <div>
            <h3>Agrega amigos a tu listado</h3>
            <SpinnerLoader v-if="estaCargandoNoAmigos" />
            <NoAmigosListado
              :listadoNoAmigos="ListadoNoAmigosOrdenados"
              @agregar-amigo="agregarAmigo"
              v-else
            />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import store from "@/store";

import amigosService from "@/services/amigos";
import AmigosListado from "@/components/amigos/AmigosListado";
import posteosService from "@/services/posteos";

import AmigosListadoPendientes from "@/components/amigos/AmigosListadoPendientes";
import AmigosListadoPosteos from "@/components/amigos/AmigosListadoPosteos";
import NoAmigosListado from "@/components/amigos/NoAmigosListado";

import SpinnerLoader from "@/components/SpinnerLoader";

export default {
  name: "Amigos",
  components: {
    AmigosListado,
    AmigosListadoPendientes,
    AmigosListadoPosteos,
    NoAmigosListado,
    SpinnerLoader,
  },
  data: function () {
    return {
      store,
      estaCargandoAmigos: true,
      estaCargandoNoAmigos: true,
      estaCargandoAmigosPendientes: true,
      estaCargandoPosteosAmigos: true,
      listadoAmigos: [],
      listadoNoAmigos: [],
      listadoPendientes: [],
      posteosAmigos: [],
    };
  },
  computed: {
    ListadoAmigosOrdenados: function () {
      const listadoAmigos = this.listadoAmigos.slice();
      listadoAmigos.reverse();
      return listadoAmigos;
    },

    ListadoNoAmigosOrdenados: function () {
      const listadoNoAmigos = this.listadoNoAmigos.slice();
      listadoNoAmigos.reverse();
      return listadoNoAmigos;
    },

    ListadoAmigosPendientesOrdenados: function () {
      const listadoPendientes = this.listadoPendientes.slice();
      listadoPendientes.reverse();
      return listadoPendientes;
    },

    posteosAmigosOrdenados: function () {
      const posteosAmigos = this.posteosAmigos.slice();
      posteosAmigos.reverse();
      return posteosAmigos;
    },
  },
  methods: {

    refrescarPosteosAmigos: function () {
      
      console.log("Entra a refrescarPosteosAmigos");

      this.estaCargandoPosteosAmigos = true;
      posteosService.posteosDeAmigos(store.auth.id).then((response) => {
        this.estaCargandoPosteosAmigos = false;
        this.posteosAmigos = response;
      });
    },

    agregarAmigo: function (id_amigo, usuario) {
      const id_usuario = store.auth.id;
      this.estaCargandoNoAmigos = true;

      console.log("Se ejecuta agregarAmigo", id_amigo, usuario);

      amigosService.agregarAmigo(id_usuario, id_amigo).then((success) => {
        if (success) {
          this.store.setStatus({
            titulo: "Éxito",
            mensaje: `Agregaste a "${usuario}" de tu lista de amigos, ahora a esperar que te acepte :)`,
            tipo: "success",
          });
        } else {
          this.store.setStatus({
            titulo: "Error",
            mensaje: `Ups!! Ah ocurrido un error intentando enviar la solicitud a "${usuario}". Intentá de nuevo más tarde`,
            tipo: "danger",
          });
        }
        amigosService.traerNoAmigosPorUsuario(id_usuario).then((data) => {
          this.estaCargandoNoAmigos = false;
          this.listadoNoAmigos = data;
        });
      });
    },

    eliminarAmigo: function (id_amigo, usuario) {
      const id_usuario = store.auth.id;
      this.estaCargandoAmigos = true;
      this.estaCargandoNoAmigos = true;

      console.log("Se ejecuta eliminarAmigo", id_amigo, usuario);

      amigosService.eliminarAmigo(id_usuario, id_amigo).then((success) => {
        if (success) {
          this.store.setStatus({
            titulo: "Éxito",
            mensaje: `Eliminaste a "${usuario}" de tu lista de amigos`,
            tipo: "success",
          });
        } else {
          this.store.setStatus({
            titulo: "Error",
            mensaje: `Ups!! Ah ocurrido un error en la eliminación de tu amigo "${usuario}". Intentá de nuevo más tarde`,
            tipo: "danger",
          });
        }

        amigosService.traerAmigosPorUsuario(id_usuario).then((data) => {
          this.estaCargandoAmigos = false;
          this.listadoAmigos = data;
        });

        amigosService.traerAmigosPendientes(id_usuario).then((data) => {
          this.estaCargandoAmigosPendientes = false;
          this.listadoPendientes = data;
        });

        amigosService.traerNoAmigosPorUsuario(id_usuario).then((data) => {
          this.estaCargandoNoAmigos = false;
          this.listadoNoAmigos = data;
        });
        
        this.refrescarPosteosAmigos();
      });
    },

    aceptarAmigo: function (id_amigo, usuario) {
      const id_usuario = store.auth.id;
      this.estaCargandoAmigos = true;

      console.log("Se ejecuta aceptarAmigo", id_amigo, usuario);

      amigosService.aceptarAmigo(id_usuario, id_amigo).then((success) => {
        if (success) {
          this.store.setStatus({
            titulo: "Éxito",
            mensaje: `Agregaste a "${usuario}" de tu lista de amigos`,
            tipo: "success",
          });
        } else {
          this.store.setStatus({
            titulo: "Error",
            mensaje: `Ups!! Ah ocurrido un error mientras que se aceptaba a tu amigo "${usuario}". Intentá de nuevo más tarde`,
            tipo: "danger",
          });
        }

        amigosService.traerAmigosPorUsuario(id_usuario).then((data) => {
          this.estaCargandoAmigos = false;
          this.listadoAmigos = data;
        });

        amigosService.traerAmigosPendientes(id_usuario).then((data) => {
          this.estaCargandoAmigosPendientes = false;
          this.listadoPendientes = data;
        });

      amigosService.traerNoAmigosPorUsuario(id_usuario).then((data) => {
        this.estaCargandoNoAmigos = false;
        this.listadoNoAmigos = data;
      });
        
        this.refrescarPosteosAmigos();

      });
    },
  },
  mounted() {
    const id = store.auth.id;
    this.estaCargandoAmigos = true;
    this.estaCargandoNoAmigos = true;
    this.estaCargandoPosteosAmigos = true;

    amigosService.traerAmigosPorUsuario(id).then((data) => {
      this.estaCargandoAmigos = false;
      this.listadoAmigos = data;
    });

    amigosService.traerNoAmigosPorUsuario(id).then((data) => {
      this.estaCargandoNoAmigos = false;
      this.listadoNoAmigos = data;
    });

    amigosService.traerAmigosPendientes(id).then((data) => {
      this.estaCargandoAmigosPendientes = false;
      this.listadoPendientes = data;
    });

    posteosService.posteosDeAmigos(id).then((response) => {
      this.estaCargandoPosteosAmigos = false;
      this.posteosAmigos = response;
    });
  },
};
</script>
