<template>
  <section class="container-fluid" id="posteoNuevo">
    <div class="container">
      <div class="row justify-content-center">
          <ComentarioNuevoForm/>
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