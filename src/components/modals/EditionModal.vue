<template>
  <Modal class="editions" v-if="modals.edition" @close="toggleModal('edition')">
    <div v-if="!isCustom">
      <h3>{{ locale.modal.edition.title }}</h3>
      <ul class="editions">
        <li
          v-for="edition in editions"
          class="edition"
          :class="['edition-' + edition.id]"
          :style="{
            backgroundImage: `url(${require('../../assets/editions/' +
              edition.id +
              '.png')})`
          }"
          :key="edition.id"
          @click="setEdition(edition)"
        >
          {{ edition.name }}
        </li>
        <li
          class="edition edition-custom"
          @click="isCustom = true"
          :style="{
            backgroundImage: `url(${require('../../assets/editions/custom.png')})`
          }"
        >
          {{ locale.modal.edition.custom.button }}
        </li>
      </ul>
    </div>
    <div class="custom" v-else>
      <h3>{{ locale.modal.edition.custom.title }}</h3>
      {{ locale.modal.edition.custom.introStart }}
      <a href="https://script.bloodontheclocktower.com/" target="_blank">{{
        locale.modal.edition.custom.scriptTool
      }}</a>
      {{ locale.modal.edition.custom.introEnd }}.<br />
      <br />
      {{ locale.modal.edition.custom.instructionsStart }}
      <a
        href="https://github.com/bra1n/townsquare#custom-characters"
        target="_blank"
        >{{ locale.modal.edition.custom.documentation }}n</a
      >
      {{ locale.modal.edition.custom.instructionsEnd }}<br />
      <b>{{ locale.modal.edition.custom.warning }}</b>
      <h3>{{ locale.modal.edition.popularScripts }}</h3>
      <ul class="scripts">
        <li
          v-for="(script, index) in scripts"
          :key="index"
          @click="handleURL(script[1])"
        >
          {{ script[0] }}
        </li>
      </ul>
      <input
        type="file"
        ref="upload"
        accept="application/json"
        @change="handleUpload"
      />
      <div class="button-group">
        <div class="button" @click="openUpload">
          <font-awesome-icon icon="file-upload" />
          {{ locale.modal.edition.custom.upload }}
        </div>
        <div class="button" @click="promptURL">
          <font-awesome-icon icon="link" />
          {{ locale.modal.edition.custom.url }}
        </div>
        <div class="button" @click="readFromClipboard">
          <font-awesome-icon icon="clipboard" />
          {{ locale.modal.edition.custom.clipboard }}
        </div>
        <div class="button" @click="isCustom = false">
          <font-awesome-icon icon="undo" />
          {{ locale.modal.edition.custom.back }}
        </div>
      </div>
    </div>
  </Modal>
</template>

<script>
import { mapMutations, mapState } from "vuex";
import Modal from "./Modal";

export default {
  components: {
    Modal
  },
  data: function() {
    return {
      editions: this.$store.state.editions,
      isCustom: false,
      scripts: [
        [
          "Deadly Penance Day",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/deadly_penance_day.json"
        ],
        [
          "Catfishing",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/catfishing.json"
        ],
        [
          "On thin ice (Teensyville)",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/on_thin_ice.json"
        ],
        [
          "Race to the bottom (Teensyville)",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/race_to_the_bottom.json"
        ],
        [
          "Frankenstein's Mayor (Teensyville)",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/frankensteins_mayor.json"
        ],
        [
          "Vigormortis High school (Teensyville)",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/vigormortis_high_school.json"
        ],
        [
          "Trouble with Violets",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/trouble_with_violets.json"
        ],
        [
          "Rochambeau",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/rochambeau.json"
        ],
        [
          "Knowing me, Knowing you",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/knowing_me_knowing_you.json"
        ],
        [
          "Hide & Seek",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/hide_and_seek.json"
        ],
        [
          "Poppyganda",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/poppyganda.json"
        ],
        [
          "Whose Cult is it Anyway",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/whose_cult_is_it_anyway.json"
        ],
        [
          "Uncertain Death",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/uncertain_death.json"
        ],
        [
          "Reykjavik's Scheme",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/reykjaviks_scheme.json"
        ],
        [
          "Pont Saint-Esprit",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/pont_saint_esprit.json"
        ],
        [
          "Simpletown Village",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/pont_saint_esprit.json"
        ],
        [
          "Trouble Brewing Advanced",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/trouble_brewing_advanced.json"
        ],
        [
          "Storyteller's Vengeance",
          "https://raw.githubusercontent.com/Pingumask/townsquare/develop/src/assets/scripts/storytellers_vengeance.json"
        ]
      ]
    };
  },
  computed: {
    ...mapState(["modals", "locale", "editions"])
  },
  methods: {
    openUpload() {
      this.$refs.upload.click();
    },
    handleUpload() {
      const file = this.$refs.upload.files[0];
      if (file && file.size) {
        const reader = new FileReader();
        reader.addEventListener("load", () => {
          try {
            const roles = JSON.parse(reader.result);
            this.parseRoles(roles);
          } catch (e) {
            alert("Error reading custom script: " + e.message);
          }
          this.$refs.upload.value = "";
        });
        reader.readAsText(file);
      }
    },
    promptURL() {
      const url = prompt(this.locale.prompt.customUrl);
      if (url) {
        this.handleURL(url);
      }
    },
    async handleURL(url) {
      const res = await fetch(url);
      if (res && res.json) {
        try {
          const script = await res.json();
          this.parseRoles(script);
        } catch (e) {
          alert(this.locale.prompt.customError + ": " + e.message);
        }
      }
    },
    async readFromClipboard() {
      const text = await navigator.clipboard.readText();
      try {
        const roles = JSON.parse(text);
        this.parseRoles(roles);
      } catch (e) {
        alert("Error reading custom script: " + e.message);
      }
    },
    parseRoles(roles) {
      if (!roles || !roles.length) return;
      const metaIndex = roles.findIndex(({ id }) => id === "_meta");
      let meta = {};
      if (metaIndex > -1) {
        meta = roles.splice(metaIndex, 1).pop();
      }
      this.$store.commit("setCustomRoles", roles);
      this.$store.commit(
        "setEdition",
        Object.assign({}, meta, { id: "custom" })
      );
      // check for fabled and set those too, if present
      if (roles.some(({ id }) => this.$store.state.fabled.has(id))) {
        const fabled = [];
        roles.forEach(({ id }) => {
          if (this.$store.state.fabled.has(id)) {
            fabled.push(this.$store.state.fabled.get(id));
          }
        });
        this.$store.commit("players/setFabled", { fabled });
      }
      this.isCustom = false;
    },
    ...mapMutations(["toggleModal", "setEdition"])
  }
};
</script>

<style scoped lang="scss">
ul.editions {
  .edition {
    font-family: PiratesBay, sans-serif;
    letter-spacing: 1px;
    text-align: center;
    padding-top: 15%;
    background-position: center center;
    background-size: 100% auto;
    background-repeat: no-repeat;
    width: 30%;
    margin: 5px;
    font-size: 120%;
    text-shadow: -1px -1px 0 #000, 1px -1px 0 #000, -1px 1px 0 #000,
      1px 1px 0 #000, 0 0 5px rgba(0, 0, 0, 0.75);
    cursor: pointer;
    &:hover {
      color: red;
    }
  }
}

.custom {
  text-align: center;
  input[type="file"] {
    display: none;
  }
  .scripts {
    list-style-type: disc;
    font-size: 120%;
    cursor: pointer;
    display: block;
    width: 50%;
    text-align: left;
    margin: 10px auto;
    li:hover {
      color: red;
    }
  }
}
</style>
