<template>
  <div style="position: absolute;">
    <audio :muted="grimoire.isMuted"
           ref="timer"
           src="../assets/sounds/timer.mp3"
           preload="auto">
    </audio>
    <audio :muted="grimoire.isMuted"
           ref="gong"
           src="../assets/sounds/gong.mp3"
           preload="auto">
    </audio>
    <div class="box">

      <table>
        <caption>
          <img class="edition_logo"
               style="width: 400px"
               :src="`${
            edition.logo && grimoire.isImageOptIn
              ? edition.logo
              : require('../assets/editions/' + edition.id + '.png')
          }`" />
        </caption>
        <tr>
          <td colspan="4"></td>
        </tr>
        <tr>
          <td>Players</td>
          <td>{{ players.length - teams.traveler }}<span v-if="teams.traveler>0" class="traveler"> + {{ teams.traveler }}</span></td>
          <td>Alive</td>
          <td>{{ teams.aliveNT }}<span v-if="teams.alive - teams.aliveNT >0" class="traveler"> + {{ teams.alive - teams.aliveNT }}</span></td>
        </tr>
        <tr>
          <td class="townsfolk">Townsfolk</td>
          <td class="townsfolk">{{ teams.townsfolk }}</td>
          <td class="minion">Minions</td>
          <td class="minion">{{ teams.minion }}</td>
        </tr>
        <tr>
          <td class="outsider">Outsiders</td>
          <td class="outsider">{{ teams.outsider }}</td>
          <td class="demon">Demons</td>
          <td class="demon">{{ teams.demon }}</td>
        </tr>

      </table>
    </div>

    <ul class="info">
      <li v-if="grimoire.isNight">
        <font-awesome-icon :icon="['fas', 'cloud-moon']" />
        {{ locale.towninfo.nightPhase }}
      </li>
      <li v-if="grimoire.isRinging">
        <audio :autoplay="!grimoire.isMuted"
               src="../assets/sounds/assemble.mp3"
               :muted="grimoire.isMuted"></audio>
        <font-awesome-icon :icon="['fas', 'music']" />
        <font-awesome-icon :icon="['fas', 'bell']" />
        <font-awesome-icon :icon="['fas', 'music']" />
      </li>
      <li>
        <Countdown v-if="grimoire.timer.duration"
                   :timerName="grimoire.timer.name"
                   :timerDuration="grimoire.timer.duration" />
      </li>

    </ul>

  </div>
  
</template>

<script>
import gameJSON from "./../game";
import { mapState } from "vuex";
  import Countdown from "./Countdown";
  

export default {
  components: {
    Countdown,
    
  },
  computed: {
    teams: function () {
      const { players } = this.$store.state.players;
      const nonTravelers = this.$store.getters["players/nonTravelers"];
      const alive = players.filter((player) => player.isDead !== true).length;
      const aliveNT = players.filter(
        (player) => player.isDead !== true && player.role.team !== "traveler",
      ).length;
      return {
        ...gameJSON[nonTravelers - 5],
        traveler: players.length - nonTravelers,
        alive,
        aliveNT,
        votes:
          alive +
          players.filter(
            (player) => player.isDead === true && player.isVoteless !== true,
          ).length,
      };
    },
    countdownStyle: function () {
      return `--timer: ${this.$store.state.grimoire.timer.duration}`;
    },
    ...mapState(["edition", "grimoire", "locale"]),
    ...mapState("players", ["players"]),
    },
    watch: {
      'grimoire.isNight': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.playGong();
        }
      },
      'grimoire.timer.duration': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.playTimer();
        }
      },
    },
    methods: {
      playGong() {
        const audio = this.$refs.gong;
        if (audio) {
          audio.currentTime = 0; 
          audio.play();
        }
      },
      playTimer() {
        const audio = this.$refs.timer;
        if (audio) {
          audio.currentTime = 0;
          audio.play();
        }
      },
    },
};
</script>

<style lang="scss" scoped>
@import "../vars.scss";

  .box {
    
    border: 10px solid;
    -o-border-image: url("../assets/towninfo.122e2c26.webp") 40 fill/20px stretch;
    border-image: url("../assets/towninfo.122e2c26.webp") 40 fill/20px stretch;
    padding: 1vh calc(1vh + 10px) 1vh 1vh;
    font-size: 80%;
    color: #000;
    font-weight: 500;
    line-height: 1.1;
    display: flex;
    align-items: center;

    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5) tr {
      white-space: nowrap;
    }

    tr td:nth-child(odd) {
      text-align: center;
      padding: 0 10px;
    }

    tr td:nth-child(2n) {
      text-align: center;
      font-size: 120%;
      font-weight: 500;
      border-left: 1px dotted #806151;
      border-right: 1px dotted #806151;
      padding: 0 10px;
    }
  }
  .townsfolk {
    color: $townsfolk;
  }

  .outsider {
    color: $townsfolk;
  }

  .minion {
    color: $demon;
  }

  .demon {
    color: $demon;
  }

  .traveler {
    color: $traveler;
  }

.info {
  
  display: flex;
  width: 100%;
  height: 20%;
  
  
  align-content: center;
  
  flex-wrap: wrap;


  li {
    font-weight: bold;
    width: 100%;
    filter: drop-shadow(0 0 2px rgba(0, 0, 0, 0.7));
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    text-shadow:
      0 2px 1px black,
      0 -2px 1px black,
      2px 0 1px black,
      -2px 0 1px black;

    span {
      white-space: nowrap;
      text-align:center;
    }

    .meta {
      text-align: center;
      flex-basis: 100%;
      font-family: PiratesBay, sans-serif;
      font-weight: normal;
    }

    svg {
      margin-right: 10px;
    }

    .players {
      color: #00f700;
    }
    .alive {
      color: #ff4a50;
    }
    .votes {
      color: #fff;
    }
    .townsfolk {
      color: $townsfolk;
    }
    .outsider {
      color: $outsider;
    }
    .minion {
      color: $minion;
    }
    .demon {
      color: $demon;
    }
    .traveler {
      color: $traveler;
    }
  }

  li.edition {
    width: 220px;
    height: 200px;
    max-width: 100%;
    max-height: 100%;
    background-position: 0 center;
    background-repeat: no-repeat;
    background-size: 100% auto;
    position: absolute;
    top: -50%;
  }
}
</style>
