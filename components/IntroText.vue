<template>
  <section class="intro-text py-5">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8 text-center">
          <div class="intro-icon mb-3">
            <font-awesome-icon :icon="['fas', icon]" size="2x" />
          </div>
          <h2 class="mb-3">{{ title }}</h2>
          <p class="lead">{{ body }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
defineProps({
  icon: { type: String, default: 'info-circle' },
  title: { type: String, required: true },
  body: { type: String, required: true },
})
</script>

<style scoped>
.intro-text {
  background-color: var(--bs-light, #f8f9fa);
}
.intro-icon {
  color: var(--primary, #8c1d40);
}
</style>
