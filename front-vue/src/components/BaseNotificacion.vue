<template>
  <section class="container-fluid pb-0">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <div class="alert alert-dismissible" :class="['alert-' + tipo]">
            <p class="alert-heading p-0 m-0" :class="['text-' + tipo]" v-if="titulo != null">
              <span class="font-bold" :class="['text-' + tipo]">{{ titulo }}.</span> {{ mensaje }}
            </p>
            <button
              type="button"
              class="close"
              aria-label="Cerrar"
              v-if="closable"
              @click="$emit('close')"
            >
              <i class="bi bi-x m-0"></i>
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: "BaseNotificacion",
  components: {},
  props: {
    mensaje: {
      type: String,
      required: true,
    },
    tipo: {
      type: String,
      default: "primary",
    },
    closable: {
      type: Boolean,
      default: true,
    },
    titulo: String,
  },
  data: function () {
    return {};
  },
  computed: {},
  methods: {},
};
</script>

<style></style>
