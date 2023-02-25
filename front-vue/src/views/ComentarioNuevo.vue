<template>
  <section class="container-fluid" id="posteoNuevo">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-md-10 col-lg-12 ">
          <h2>Nuevo Comentario!</h2>
          <ComentarioNuevoForm/>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import ComentarioNuevoForm from "@/components/ComentarioNuevoForm";

export default {
  name: "ComentarioNuevo",
  components: {
    ComentarioNuevoForm
  },
  props: {},
  data: function () {
    return {}
  },
  computed: {},
  methods: {}
}
</script>