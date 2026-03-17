<script setup lang="ts">
defineProps<{
  logoSrc: string
  logoAlt: string
  ctaText: string
  ctaHref: string
}>()
</script>

<template>
  <div class="header-wrapper">
    <div class="header-spacer"></div>

    <header class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom fixed-top bg-white header-shell">
      <div class="container">
        <div class="row">
          <div class="col p-0">
            <div class="brand-logo">
              <img :src="logoSrc" :alt="logoAlt" />
            </div>
          </div>
          <div class="col-5 col-md-4 d-flex align-items-center justify-content-end">
            <a v-if="ctaHref" :href="ctaHref" class="text-decoration-none">
              <div class="request-button fw-bold">
                {{ ctaText }}
              </div>
            </a>
            <div v-else class="request-button fw-bold">
              {{ ctaText }}
            </div>
          </div>
        </div>
      </div>
    </header>
  </div>
</template>

<style scoped lang="scss">
.header-shell {
  z-index: 99999;
}

.header-spacer {
  height: 6.5rem;
}

.brand-logo {
  padding: 1.25rem 0;

  img {
    height: 4rem;
    max-width: 100%;
  }
}

.request-button {
  background-color: var(--rds-secondary);
  border-radius: 2rem;
  color: var(--rds-dark-3);
  cursor: pointer;
  padding: 1rem 2rem;
  text-align: center;
}

@media (max-width: 768px) {
  .header-spacer {
    height: 5.75rem;
  }

  .request-button {
    border-radius: 0;
    bottom: 0;
    left: 50%;
    position: fixed;
    transform: translateX(-50%);
    width: 100%;
    z-index: 999;
  }
}
</style>
