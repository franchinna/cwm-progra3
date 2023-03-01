<template>
  <div class="mb-2">
    <div class="d-flex justify-content-between mb-2">
      <h2 class="p-0 m-0">Posteos de amigos</h2>
    </div>
    <div
      class="d-flex flex-wrap justify-content-between align-content-start py-2 pr-2"
    >
      <PosteosMiniatura
        v-for="posteo in posteosamigos"
        :key="posteo.id_posteo"
        :posteo="posteo"
      />
    </div>
  </div>
</template>

<script>
import PosteosMiniatura from "@/components/PosteosMiniatura";

export default {
  name: "ListadoPosteosAmigos",
  components: {
    PosteosMiniatura,
  },
  props: {
    posteosamigos: {
      type: Array,
      required: true,
    },
  },
};
</script>
