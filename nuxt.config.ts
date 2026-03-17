// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',
  ssr: true,
  devtools: { enabled: true },
  app: {
    baseURL: process.env.NUXT_APP_BASE_URL || '/',
    head: {
      title: 'RDS LP Test',
      htmlAttrs: { lang: 'en' },
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      ],
    },
  },
  css: [
    "@rds-vue-ui/rds-theme-base/style/rds-theme-base.scss",
    "~/assets/scss/styles.scss"
  ],
  components: [
    { path: "~/components" },
    {
      path: "~/node_modules/@rds-vue-ui/",
      ignore: ["**/index.ts", "**/index.js", "**/node_modules"],
    }
  ],
  modules: ['maz-ui/nuxt', '@nuxtjs/robots'],
  robots: {
    robotsTxt: false,
  },
  build: {
    transpile: [
      'bootstrap',
      '@rds-vue-ui/',
    ]
  },
  plugins: [
    "~/plugins/config.js",
    "~/plugins/font-awesome.js"
  ],
  runtimeConfig: {
    public: {
      siteEnv: process.env.NUXT_PUBLIC_SITE_ENV || 'local',
    }
  },
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          silenceDeprecations: [
            'import',
            'global-builtin',
            'color-functions',
            'if-function',
            'abs-percent',
          ],
        },
      },
    },
  },
})
