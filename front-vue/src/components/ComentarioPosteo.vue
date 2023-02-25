<template>
    <div class="comentarios mb-3 bg-white">
      <p>{{ comentario.cuerpo }}</p>
      <p class="f-14 text-secondary m-0">Creado el día {{ comentario.fecha }} por {{ comentario.username }}</p>
    </div>
</template>

<script>
import store from '@/store';

export default {
name: "ComentarioPosteo",
  props: ['comentario'],
  data: function() {
    return {
      store
    }
  },
  methods: {
  }
}
</script>