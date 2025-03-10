<template>
  <div id="controls">
    <span
      class="nomlog-summary"
      v-show="session.voteHistory.length && session.sessionId"
      @click="toggleModal('voteHistory')"
      :title="`${session.voteHistory.length} recent ${
        session.voteHistory.length == 1 ? 'nomination' : 'nominations'
      }`"
    >
      <font-awesome-icon icon="book-dead" />
      {{ session.voteHistory.length }}
    </span>
    <span
      class="session"
      :class="{
        spectator: session.isSpectator,
        reconnecting: session.isReconnecting,
      }"
      v-if="session.sessionId"
      @click="leaveSession"
      :title="`${session.playerCount} other players in this session${
        session.ping ? ' (' + session.ping + 'ms latency)' : ''
      }`"
    >
      <font-awesome-icon icon="broadcast-tower" />
      {{ session.playerCount }}
    </span>
    <div class="menu" :class="{ open: grimoire.isMenuOpen }">
      <font-awesome-icon icon="cog" @click="toggleMenu" />
      <ul>
        <li class="tabs" :class="tab">
          <font-awesome-icon icon="book-open" @click="tab = 'grimoire'" />
          <font-awesome-icon icon="broadcast-tower" @click="tab = 'session'" />
          <font-awesome-icon
            icon="users"
            v-if="!session.isSpectator"
            @click="tab = 'players'"
          />
          <font-awesome-icon icon="theater-masks" @click="tab = 'characters'" />
          <font-awesome-icon icon="question" @click="tab = 'help'" />
        </li>

        <template v-if="tab === 'grimoire'">
          <!-- Grimoire -->
          <li class="headline">{{ locale.menu.grimoire.title }}</li>
          <li @click="toggleGrimoire" v-if="players.length">
            <template v-if="!grimoire.isPublic">
              {{
              locale.menu.grimoire.hide
              }}
            </template>
            <template v-if="grimoire.isPublic">
              {{
              locale.menu.grimoire.show
              }}
            </template>
            <em>[G]</em>
          </li>
          <li @click="toggleNight" v-if="!session.isSpectator">
            <template v-if="!grimoire.isNight">
              {{
              locale.menu.grimoire.nightSwitch
              }}
            </template>
            <template v-if="grimoire.isNight">
              {{
              locale.menu.grimoire.daySwitch
              }}
            </template>
            <em>[S]</em>
          </li>
          <li @click="toggleRinging" v-if="!session.isSpectator">
            <template>
              {{ locale.menu.grimoire.ringBell }}
            </template>
            <em>[B]</em>
          </li>

          <li @click="toggleOrganVoteMode">

            {{ locale.menu.grimoire.organGrinder }}
            <em>
              <font-awesome-icon :icon="[
                  'fas',
                  grimoire.isOrganVoteMode ? 'check-square' : 'square',
                ]" />
            </em>
          </li>
          <li @click="toggleNightOrder" v-if="session.isSpectator">
            {{ locale.menu.grimoire.order }}
            <em>
              <font-awesome-icon :icon="[
                  'fas',
                  grimoire.isNightOrder ? 'check-square' : 'square',
                ]" />
            </em>
          </li>
          <li v-if="players.length">
            {{ locale.menu.grimoire.zoom }}
            <em>
              <font-awesome-icon @click="setZoom(grimoire.zoom - 1)"
                                 icon="search-minus" />
              {{ Math.round(100 + grimoire.zoom * 10) }}%
              <font-awesome-icon @click="setZoom(grimoire.zoom + 1)"
                                 icon="search-plus" />
            </em>
          </li>
          <li @click="setBackground">
            {{ locale.menu.grimoire.background }}
            <em><font-awesome-icon icon="image" /></em>
          </li>
          <li @click="toggleModal('background')">
            Background Picker
            <em><font-awesome-icon icon="image" /></em>
          </li>
          <li @click="imageOptIn">
            <small>{{ locale.menu.grimoire.customImages }}</small>
            <em>
              <font-awesome-icon :icon="[
                  'fas',
                  grimoire.isImageOptIn ? 'check-square' : 'square',
                ]" />
            </em>
          </li>

          <li @click="toggleStatic">
            {{ locale.menu.grimoire.animations }}
            <em>
              <font-awesome-icon :icon="['fas', grimoire.isStatic ? 'check-square' : 'square']" />
            </em>
          </li>
          <li @click="toggleMuted">
            {{ locale.menu.grimoire.mute }}
            <em>
              <font-awesome-icon :icon="['fas', grimoire.isMuted ? 'volume-mute' : 'volume-up']" />
            </em>
          </li>
        </template>

        <template v-if="tab === 'session'">
          <!-- Session -->
          <li class="headline" v-if="session.sessionId">
            {{
              session.isSpectator
                ? locale.menu.session.title.player
                : locale.menu.session.title.host
            }}
          </li>
          <li class="headline" v-else>
            {{ locale.menu.session.title.create }}
          </li>
          <template v-if="!session.sessionId">
            <li @click="hostSession">
              {{ locale.menu.session.storyteller }}<em>[H]</em>
            </li>
            <li @click="joinSession">
              {{ locale.menu.session.player }}<em>[J]</em>
            </li>
          </template>
          <template v-else>
            <li v-if="session.ping">
              {{ locale.menu.session.delay }}
              {{
                session.isSpectator
                  ? locale.menu.session.host
                  : locale.menu.session.players
              }}
              <em>{{ session.ping }}ms</em>
            </li>
            <li @click="copySessionUrl">
              {{ locale.menu.session.link }}
              <em><font-awesome-icon icon="copy" /></em>
            </li>
            <li v-if="!session.isSpectator" @click="distributeRoles">
              {{ locale.menu.session.sendRoles }}
              <em><font-awesome-icon icon="theater-masks" /></em>
            </li>
            <li
              v-if="session.voteHistory.length || !session.isSpectator"
              @click="toggleModal('voteHistory')"
            >
              {{ locale.menu.session.voteHistory }}<em>[V]</em>
            </li>
            <li @click="leaveSession">
              {{ locale.menu.session.leave }}
              <em>{{ session.sessionId }}</em>
            </li>
          </template>
        </template>

        <template v-if="tab === 'players' && !session.isSpectator">
          <!-- Users -->
          <li class="headline">{{ locale.menu.players.title }}</li>
          <li @click="addPlayer" v-if="players.length < 20">
            {{ locale.menu.players.add }}<em>[A]</em>
          </li>
          <li @click="randomizeSeatings" v-if="players.length > 2">
            {{ locale.menu.players.randomize }}
            <em><font-awesome-icon icon="dice" /></em>
          </li>
          <li @click="clearPlayers" v-if="players.length">
            {{ locale.menu.players.removeAll }}
            <em><font-awesome-icon icon="trash-alt" /></em>
          </li>
        </template>

        <template v-if="tab === 'characters'">
          <!-- Characters -->
          <li class="headline">{{ locale.menu.characters.title }}</li>
          <li v-if="!session.isSpectator" @click="toggleModal('edition')">
            {{ locale.menu.characters.selectEdition }}
            <em>[E]</em>
          </li>
          <li
            @click="toggleModal('roles')"
            v-if="!session.isSpectator && players.length > 4"
          >
            {{ locale.menu.characters.assign }}
            <em>[C]</em>
          </li>
          <li v-if="!session.isSpectator" @click="toggleModal('fabled')">
            {{ locale.menu.characters.addFabled }}
            <em><font-awesome-icon icon="dragon" /></em>
          </li>
          <li @click="clearRoles" v-if="players.length">
            {{ locale.menu.characters.removeAll }}
            <em><font-awesome-icon icon="trash-alt" /></em>
          </li>
        </template>

        <template v-if="tab === 'help'">
          <!-- Help -->
          <li class="headline">{{ locale.menu.help.title }}</li>
          <li @click="toggleModal('reference')">
            {{ locale.menu.help.reference }}
            <em>[R]</em>
          </li>
          <li @click="toggleModal('nightOrder')" v-if="!session.isSpectator">
            {{ locale.menu.help.nightOrder }}
            <em>[N]</em>
          </li>
          <li @click="toggleModal('gameState')">
            Game State JSON
            <em><font-awesome-icon icon="file-code" /></em>
          </li>

        </template>
      </ul>
    </div>
  </div>
</template>

<script>
import { mapMutations, mapState } from "vuex";

export default {
  computed: {
    ...mapState(["grimoire", "session", "edition", "locale"]),
    ...mapState("players", ["players"]),
  },
  data() {
    return {
      tab: "grimoire",
    };
  },
  methods: {
    setBackground() {
      const background = prompt(this.locale.prompt.background);
      if (background || background === "") {
        this.$store.commit("setBackground", background);
      }
    },
    hostSession() {
      if (this.session.sessionId) return;
      const sessionId = prompt(
        this.locale.prompt.createSession,
        Math.round(Math.random() * 10000),
      );
      if (sessionId) {
        this.$store.commit("session/clearVoteHistory");
        this.$store.commit("session/setSpectator", false);
        this.$store.commit("session/setSessionId", sessionId);
        this.$store.commit("toggleGrimoire", false);
        this.copySessionUrl();
      }
    },
    copySessionUrl() {
      const url = window.location.href.split("#")[0];
      const link = url + "#" + this.session.sessionId;
      navigator.clipboard.writeText(link);
    },
    distributeRoles() {
      if (this.session.isSpectator) return;
      const popup = this.locale.prompt.sendRoles;
      if (confirm(popup)) {
        this.$store.commit("session/distributeRoles", true);
        setTimeout(
          (() => {
            this.$store.commit("session/distributeRoles", false);
          }).bind(this),
          2000,
        );
      }
    },
    imageOptIn() {
      const popup = this.locale.prompt.imageOptIn;
      if (this.grimoire.isImageOptIn || confirm(popup)) {
        this.toggleImageOptIn();
      }
    },
    streamerMode() {
      this.toggleStreamerMode();
    },
    joinSession() {
      if (this.session.sessionId) return this.leaveSession();
      let sessionId = prompt(this.locale.prompt.joinSession);
      if (sessionId.match(/^https?:\/\//i)) {
        sessionId = sessionId.split("#").pop();
      }
      if (sessionId) {
        this.$store.commit("session/clearVoteHistory");
        this.$store.commit("session/setSpectator", true);
        this.$store.commit("toggleGrimoire", false);
        this.$store.commit("session/setSessionId", sessionId);
      }
    },
    leaveSession() {
      if (confirm(this.locale.prompt.leaveSession)) {
        this.$store.commit("session/setSpectator", false);
        this.$store.commit("session/setSessionId", "");
      }
    },
    addPlayer() {
      if (this.session.isSpectator) return;
      if (this.players.length >= 20) return;
      const name = prompt(this.locale.prompt.addPlayer);
      if (name) {
        this.$store.commit("players/add", name);
      }
    },
    randomizeSeatings() {
      if (this.session.isSpectator) return;
      if (confirm(this.locale.prompt.randomizeSeatings)) {
        this.$store.dispatch("players/randomize");
      }
    },
    clearPlayers() {
      if (this.session.isSpectator) return;
      if (confirm(this.locale.prompt.clearPlayers)) {
        // abort vote if in progress
        if (this.session.nomination) {
          this.$store.commit("session/nomination");
        }
        this.$store.commit("players/clear");
      }
    },
    clearRoles() {
      if (confirm(this.locale.prompt.clearRoles)) {
        this.$store.dispatch("players/clearRoles");
      }
    },
    toggleNight() {
      this.$store.commit("toggleNight");
      if (this.grimoire.isNight) {
        this.$store.commit("session/setMarkedPlayer", -1);
      }
    },
    toggleOrganVoteMode() {
      this.$store.commit("toggleOrganVoteMode");
    },
    toggleRinging() {

      this.$store.commit("toggleRinging", true);
      setTimeout(this.$store.commit, 25000, "toggleRinging", false);
    },
    ...mapMutations([
      "toggleGrimoire",
      "toggleMenu",
      "toggleImageOptIn",
      "toggleStreamerMode",
      "toggleMuted",
      "toggleNightOrder",
      "toggleStatic",
      "setZoom",
      "toggleModal",
    ]),
  },
};
</script>

<style scoped lang="scss">
@import "../vars.scss";

// success animation
@keyframes greenToWhite {
  from {
    color: green;
  }
  to {
    color: white;
  }
}

// Controls
#controls {
  position: absolute;
  right: 3px;
  top: 3px;
  text-align: right;
  padding-right: 50px;
  z-index: 75;

  svg {
    filter: drop-shadow(0 0 5px rgba(0, 0, 0, 1));
    &.success {
      animation: greenToWhite 1s normal forwards;
      animation-iteration-count: 1;
    }
  }

  > span {
    display: inline-block;
    cursor: pointer;
    z-index: 5;
    margin-top: 7px;
    margin-left: 10px;
  }

  span.nomlog-summary {
    color: $townsfolk;
  }

  span.session {
    color: $demon;
    &.spectator {
      color: $townsfolk;
    }
    &.reconnecting {
      animation: blink 1s infinite;
    }
  }
}

@keyframes blink {
  50% {
    opacity: 0.5;
    color: gray;
  }
}

  .menu {
    width: 220px;
    transform-origin: 200px 22px;
    transition: transform 500ms cubic-bezier(0.68, -0.55, 0.27, 1.55);
    transform: rotate(-90deg);
    position: absolute;
    right: 0;
    top: 0;
    user-select: none;

    &.open {
      transform: rotate(0deg);
    }

    > svg {
      cursor: pointer;
      background: rgba(0, 0, 0, 0.5);
      border: 3px solid black;
      width: 40px;
      height: 50px;
      margin-bottom: -8px;
      border-bottom: 0;
      border-radius: 10px 10px 0 0;
      padding: 5px 5px 15px;
    }

    a {
      color: white;
      text-decoration: none;

      &:hover {
        color: red;
      }
    }

    ul {
      display: flex;
      list-style-type: none;
      padding: 0;
      margin: 0;
      flex-direction: column;
      overflow: hidden;
      box-shadow: 0 0 10px black;
      border: 3px solid black;
      border-radius: 10px 0 10px 10px;

      li {
        padding: 2px 5px;
        color: white;
        text-align: left;
        background: rgba(0, 0, 0, 0.7);
        display: flex;
        align-items: center;
        justify-content: space-between;
        min-height: 30px;

        &.tabs {
          display: flex;
          padding: 0;

          svg {
            flex-grow: 1;
            flex-shrink: 0;
            height: 35px;
            border-bottom: 3px solid black;
            border-right: 3px solid black;
            padding: 5px 0;
            cursor: pointer;
            transition: color 250ms;

            &:hover {
              color: $botc_brandY;
            }

            &:last-child {
              border-right: 0;
            }
          }

          &.grimoire .fa-book-open,
          &.players .fa-users,
          &.characters .fa-theater-masks,
          &.session .fa-broadcast-tower,
          &.help .fa-question {
            background: linear-gradient( to bottom, $townsfolk 0%, rgba(0, 0, 0, 0.5) 100% );
          }
        }

        &:not(.headline):not(.tabs):hover {
          cursor: pointer;
          color: $botc_brandY;
        }

        em {
          flex-grow: 0;
          font-style: normal;
          margin-left: 10px;
          font-size: 80%;
        }
      }

      .headline {
        font-family: PiratesBay, sans-serif;
        letter-spacing: 1px;
        padding: 0 10px;
        text-align: center;
        justify-content: center;
        background: linear-gradient( to right, $botc_brandY 0%, rgba(0, 0, 0, 0.5) 20%, rgba(0, 0, 0, 0.5) 80%, $botc_brandP 100% );
      }
    }
  }
</style>
