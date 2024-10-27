<template>
  <div id="text-container">
    <svg viewBox="0 0 100 100" width="400" height="400" class="rotating">
      <defs>
        <!-- Define the circular path -->
        <path id="circle"
              d="
            M 50, 50
            m -37, 0
            a 37,37 0 1,1 74,0
            a 37,37 0 1,1 -74,0" />
      </defs>
      <text font-size="17" class="text">
        <!-- Text following the circular path -->
        <textPath xlink:href="#circle" startOffset="0" textLength="220">
          Return to Townsquare
        </textPath>
      </text>
    </svg>
  </div>
</template>

<style scoped lang="scss">
  @import "../vars.scss";
  #text-container{
    position:absolute;
  }
  svg {
    
    fill: currentColor;
    height: auto;
    max-width: 66vmin;
    transform-origin: center;
    width: 100%;
  }

  .rotating {
    animation: rotate 25s linear infinite;
  }

  .text {
    color: $botc_brandY;
    animation: hideAfterRotation 25s linear forwards;
  }

  @keyframes rotate {
    from {
      transform: rotate(0deg);
    }

    to {
      transform: rotate(360deg);
    }
  }

  @keyframes hideAfterRotation {
    0% {
      opacity: 1;
    }

    99% {
      opacity: 1;
    }

    100% {
      opacity: 0;
    }
  }
</style>
