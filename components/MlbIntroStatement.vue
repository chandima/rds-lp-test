<script setup lang="ts">
defineProps<{
  iconSrc: string
  iconAlt: string
  textBeforeHighlight: string
  highlightText: string
  textAfterHighlight: string
}>()
</script>

<template>
  <section class="mlb-intro">
    <div class="container">
      <div class="row">
        <div class="col d-flex justify-content-center flex-column align-items-center intro-text">
          <div class="intro-icon">
            <img :src="iconSrc" :alt="iconAlt" />
          </div>
          <div>
            <h1 class="h1-small text-center">
              {{ textBeforeHighlight }}
              <span class="text-element">{{ highlightText }}</span>
              {{ textAfterHighlight }}
            </h1>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
.intro-text {
  font-family: Arial, Helvetica, sans-serif;
  padding: 6rem 8.29rem;
}

.intro-icon {
  background-color: #ffca38;
  border-radius: 4rem;
  margin-bottom: 32px;
  padding: 0.68rem;

  img {
    height: 50px;
    width: 50px;
  }
}

.text-element {
  background: #ffca38;
  box-decoration-break: clone;
  display: inline;
  padding: 0 8px;
  -webkit-box-decoration-break: clone;
}

@media (max-width: 768px) {
  .intro-text {
    padding: 6rem 1rem;
  }
}
</style>
