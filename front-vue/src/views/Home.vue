<template>
  <section class="container-fluid" id="home">
    <div class="container">
      <div class="row">
        <div class="col-12 col-md col-lg-8 posteos">
          <SpinnerLoader v-if="estaCargando" />
          <ListadoPosteos
            v-else
            :posteos="posteosOrdenados"
            @delete="refrescarPosteos()"
          />
        </div>
        <div class="col-12 col-lg-4">
            <SpinnerLoader v-if="estaCargandoEventos" />
            <ListadoEventos
              v-else
              :eventos="eventosOrdenados"
              @delete="refrescarEventos()"
            />
          </div>
        </div>
      </div>
  </section>
</template>

<script>
import store from "@/store";
import ListadoPosteos from "@/components/ListadoPosteos";
import ListadoEventos from "@/components/ListadoEventos";
import user from '@/services/users';
import SpinnerLoader from "@/components/SpinnerLoader";
import posteosService from "@/services/posteos";
import eventosService from "@/services/eventos";

export default {
  name: "Home",
  components: {
    SpinnerLoader,
    ListadoPosteos,
    ListadoEventos,
  },
  data: function () {
    return {
      store,
      user,
      estaCargando: true,
      estaCargandoEventos: true,
      posteos: [],
      eventos: [],
    };
  },
  computed: {
    eventosOrdenados: function () {
      const eventos = this.eventos.slice();
      eventos.reverse();
      return eventos;
    },
    posteosOrdenados: function () {
      const posteos = this.posteos.slice();
      posteos.reverse();
      return posteos;
    },
  },
  methods: {
    refrescarPosteos() {
      console.log('Entra a refrescarPosteos');
      this.estaCargando = true;
      posteosService.getAll().then((response) => {
        this.estaCargando = false;
        this.posteos = response;
      });
    },
    refrescarEventos() {
      console.log('refrescarEventos');
      this.estaCargandoEventos = true;
      eventosService.getAll().then((response) => {
        this.estaCargandoEventos = false;
        this.eventos = response;
      });
    },
  },
  mounted: function () {
    this.estaCargando = true;
    posteosService.getAll().then((response) => {
      this.estaCargando = false;
      this.posteos = response;
    });

    const id = this.store.auth.id;

    console.log('id = ', id);
    this.estaCargandoEventos = true;
    eventosService.getAll().then((response) => {
      this.estaCargandoEventos = false;
      this.eventos = response;
    });
    
  },
};
</script>
