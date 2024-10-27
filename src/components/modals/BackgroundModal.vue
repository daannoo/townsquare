<template>
  <Modal v-if="modals.background" @close="toggleModal('background')">
    <h3>Select Background</h3>
  </Modal>
</template>

<script>
import { mapMutations, mapState } from "vuex";
import Modal from "./Modal";

export default {
  components: {
    Modal,
  },
  computed: {
    ...mapState(["modals", "locale", "editions"]),
  },
  methods: {

    ...mapMutations(["toggleModal", "setEdition"]),
  },
};
</script>

<style scoped lang="scss">
  @import "../../vars.scss";

</style>
