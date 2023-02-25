<template>
  <section class="container-fluid" id="posteoNuevo">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12 col-md">
          <h2 class="m-0 p-0">Creá una publicación</h2>
          <p>¿Sobre que querés hablar?</p>
          <PosteoNuevoForm />
        </div>
        <div class="col-12 col-md-3 text-center pt-4 d-none d-lg-block">
          <div class="text-center rounded border mb-3">
            <p class="m-0 p-2">Mantente informado sobre las noticias y tendencias de tu sector</p>
          </div>
          <div>
            <img :src="imagenPath" alt="img_publicidad" class="img-fluid rounded">
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import PosteoNuevoForm from "@/components/PosteoNuevoForm";
import { PATH_IMGS } from "@/constants";

export default {
  name: "PosteoNuevo",
  components: {
    PosteoNuevoForm
  },
  props: {},
  data: function () {
    return {};
  },
  computed: {
    /**
     * @return {String}
     */
    imagenPath() {
      return `${PATH_IMGS}/anuncios/publicidad_1.jpg`;
    },
  },
  methods: {},
};
</script>
