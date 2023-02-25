<template>
  <div class="mb-2">
    <PosteosMiniatura
      v-for="posteo in posteos"
      :key="posteo.id_posteo"
      :posteo="posteo"
    />
  </div>
</template>

<script>
import PosteosMiniatura from "@/components/PosteosMiniatura";

export default {
  name: "ListadoPosteos",
  components: {
    PosteosMiniatura,
  },
  props: {
    posteos: {
      type: Array,
      required: true,
    },
  },
};
</script>
