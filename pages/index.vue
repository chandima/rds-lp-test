<script setup lang="ts">
import content from '~/assets/content/home.json'

const runtimeConfig = useRuntimeConfig()

useHead({
  title: content.pageTitle,
})

const formatLinkTarget = (target: string) => {
  return target === 'SELF' ? '_self' : '_blank'
}

const withSiteBase = (path: string) => {
  if (!path.startsWith('/')) {
    return path
  }

  const base = runtimeConfig.app.baseURL || '/'
  return `${base.replace(/\/$/, '')}${path}`
}
</script>

<template>
  <div class="mlb-page">
    <MlbLandingHeader
      :logo-src="withSiteBase(content.header.logoSrc)"
      :logo-alt="content.header.logoAlt"
      :cta-text="content.header.ctaText"
      :cta-href="content.header.ctaHref"
    />

    <main>
      <!-- Section: Hero -->
      <HeroStandardApollo
        :full-width="true"
        :bg-image-source="withSiteBase(content.hero.bgImageSource)"
        :bg-image-alt="content.hero.bgImageAlt"
        :display-gradient="true"
        :gradient-opacity="0.6"
        :show-text="false"
        :title="content.hero.title"
        title-level="h1"
        title-size="large"
        title-variant="white"
      />

      <!-- Section: Intro -->
      <MlbIntroStatement
        :icon-src="withSiteBase(content.intro.iconSrc)"
        :icon-alt="content.intro.iconAlt"
        :text-before-highlight="content.intro.textBeforeHighlight"
        :highlight-text="content.intro.highlightText"
        :text-after-highlight="content.intro.textAfterHighlight"
      />

      <!-- Section: Support -->
      <section id="support" class="support-section bg-light-1">
        <div class="container py-0 py-md-space-md py-lg-space-lg">
          <div class="py-space-lg py-lg-space-lg">
            <div class="d-flex flex-column">
              <h2 class="mb-space-sm px-0 col-12 col-lg-8 w-auto h2-medium text-dark-3 align-self-start">
                {{ content.support.title }}
              </h2>
              <div class="accordion-title-underline bg-secondary align-self-start"></div>
              <div class="mb-space-md px-0 fw-medium">
                <p class="col-xl-8 fs-medium mb-0">
                  {{ content.support.description }}
                </p>
              </div>
            </div>

            <img
              :src="withSiteBase(content.support.image)"
              :alt="content.support.imageAlt"
              class="d-block d-lg-none w-100 mb-space-md support-mobile-image"
            />

            <OverlapAccordionAtlas
              :bg-lazy="true"
              :default-accordion-image="withSiteBase(content.support.image)"
              :accordion-items="content.support.items"
              overlap-side="left"
              accordion-title-size="large"
              title-background-variant="white"
              content-background-variant="light-1"
              border-variant="light-4"
            />
          </div>
        </div>
      </section>

      <!-- Section: Get Started -->
      <SectionApollo
        class="get-started-section"
        :title="content.getStarted.title"
        :title-size="'medium'"
        :title-variant="'dark-3'"
        :image="withSiteBase(content.getStarted.image)"
        :image-lazy="true"
        :image-position="'left'"
        :section-background-variant="'white'"
        :text-background-variant="'white'"
        :mobile-img="true"
        :mobile-img-height="420"
        :show-sub-heading="false"
        :show-text="true"
        :text="content.getStarted.body"
        :show-cta="true"
        :cta-link="content.getStarted.link"
        :cta-link-target="'_blank'"
        :cta-text="content.getStarted.buttonText"
        :cta-as-button="true"
        :cta-button-variant="'secondary'"
        :cta-aria-label="content.getStarted.buttonText"
      />

      <!-- Section: Testimonial -->
      <div id="testimonial" class="container testimonial-shell">
        <div class="row justify-content-center">
          <div class="col-12 col-md-9">
            <SectionTestimonialFalcon
              :label="content.testimonial.label"
              label-size="xl"
              label-background-variant="dark-3"
              label-variant="white"
              :text="content.testimonial.text"
              text-size="xl"
              text-variant="dark-3"
              text-weight="bold"
              :author-text="content.testimonial.authorText"
              author-text-size="large"
              author-text-variant="dark-3"
              author-text-weight="bold"
              :designation-text="content.testimonial.designationText"
              designation-text-size="medium"
              designation-text-variant="dark-3"
              :description-text="content.testimonial.descriptionText"
              description-text-size="xs"
              description-text-variant="dark-1"
              :image-source="withSiteBase(content.testimonial.imageSource)"
              :image-alt="content.testimonial.imageAlt"
              :show-custom-line="false"
              :display-image="true"
              :show-cta="false"
            />
          </div>
        </div>
      </div>
    </main>

    <div class="footer-shell">
      <FooterStandard :tertiary-items="content.footer.tertiaryItems">
        <template #secondary-menu>
          <nav class="nav grid-flex-menu order-1" aria-label="University Services">
            <a
              v-for="item in content.footer.secondaryItems"
              :key="item.text"
              :href="item.uri"
              :target="formatLinkTarget(item.target)"
              class="nav-link text-dark-3 menu-item fw-bold py-space-xxs py-lg-0 footer-secondary-item"
              rel="noopener noreferrer"
            >
              {{ item.text }}
            </a>
          </nav>
        </template>
      </FooterStandard>
    </div>
  </div>
</template>

<style scoped lang="scss">
.mlb-page {
  background: var(--rds-white);
}

.accordion-title-underline {
  border-top: 5px solid var(--rds-secondary);
  margin: 0 0 20px;
  width: 3.2rem;
}

.support-mobile-image {
  aspect-ratio: 16 / 10;
  object-fit: cover;
}

.testimonial-shell {
  :deep(.text-dark-1) {
    margin: auto;
    width: 70%;
  }
}

.footer-shell {
  :deep(.footer-secondary-item) {
    padding-left: 0;
    padding-right: 0;
  }

  :deep(#baseFooter) {
    position: relative;
  }
}

:deep(.hero-image-container) {
  padding-left: 0.6rem;
}

:deep(.description-div-left .mb-space-xs) {
  margin-bottom: 0 !important;
}

:deep(.get-started-section .btn-secondary) {
  background-color: var(--rds-secondary);
  border-color: var(--rds-secondary);
  border-radius: 2rem;
  color: var(--rds-dark-3);
  font-weight: 700;
  padding: 1rem 2rem;
}

:deep(.get-started-section .btn-secondary:hover) {
  background-color: var(--rds-secondary);
  border-color: var(--rds-secondary);
  color: var(--rds-dark-3);
}

@media (max-width: 992px) {
  .testimonial-shell {
    :deep(.text-dark-1) {
      width: 100%;
    }
  }

  .footer-shell {
    margin-bottom: 3.5rem;
  }
}
</style>
