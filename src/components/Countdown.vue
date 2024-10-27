<template>
  <countdown :time="timerDuration*1000" :transform="transform">
    <template slot-scope="props" >
      <div class="timerBox">
        <div>{{timerName}}</div>
        <div class="label">
          <span >
            {{ props.minutes }}
          </span>
          <span>
            {{ props.seconds }}
          </span>
        </div>
        
      </div>
    </template>
  </countdown>
</template>

<script>
  
  export default {
    props: {
      timerName: String,
      timerDuration: Number,
    },
    computed: {
      style() {
        return `:time= ${this.timerDuration}`;
      },
    },
    methods: {
      transform(props) {
        Object.entries(props).forEach(([key, value]) => {
          // Adds leading zero
          const digits = value < 10 ? `${value}` : value;

          // uses singular form when the value is less than 2
          const word = value < 2 ? key.replace(/s$/, '') : key;

          props[key] = `${digits} ${word}`;
        });

        return props;
      },
    },
  };
</script>

<style lang="scss" scoped>
  @import "../vars.scss";
  .label{
      color:$botc_brandY;
  }
  .timerBox {
    width: 100%;
    border-radius:5px;
    color:$botc_brandP;
    padding:.5em;
    background:black;
    position: relative;
    z-index: 0;
    
  }


@keyframes countdown {
  0% {
    width: 100%;
  }
  100% {
    width: 0%;
    display: none;
  }
}
</style>
