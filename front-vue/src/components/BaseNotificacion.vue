<template>
    <div
        class="alert alert-dismissible"
        :class="['alert-' + tipo]"
    >
      <h3
          class="alert-heading"
          v-if="titulo != null"
      >
        {{ titulo }}
      </h3>
      {{ mensaje }}
      <button
          type="button"
          class="close"
          aria-label="Cerrar"
          v-if="closable"
          @click="$emit('close')"
      >
        <span aria-hidden="true">&times;</span>
      </button>
    </div>
</template>

<script>
export default {
  name: "BaseNotificacion",
  components: {},
  props: {
    mensaje: {
      type: String,
      required: true
    },
    tipo: {
      type: String,
      default: 'primary'
    },
    closable: {
      type: Boolean,
      default: true
    },
    titulo: String,
  },
  data: function () {
    return {}
  },
  computed: {},
  methods: {}
}
</script>

<style>

</style>
