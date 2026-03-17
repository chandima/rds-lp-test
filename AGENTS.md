# AGENTS.md — RDS Landing Page Factory

## 1. Project Overview

This is a Nuxt 3 landing page built with the RDS (Rocket Design System) Vue 3 component library. All UI sections must use `@rds-vue-ui/*` components. The project follows a JSON-driven content model where page data lives in `assets/content/` and is passed as props to RDS components.

## 2. Golden Rule

> **ALWAYS use `@rds-vue-ui/*` components as the primary building blocks.**

- **NEVER** write raw HTML/CSS for layout sections (heroes, footers, cards, sections, navbars) that have an RDS equivalent.
- Custom components are **only** for page-specific glue logic not covered by the design system.
- When in doubt, check the component catalog below before writing custom markup.

---

## 3. RDS Component Catalog

The RDS (Reusable Design System) provides 94 pre-built Vue 3 components organized in a Lerna monorepo. All components are available at `@rds-vue-ui/{package-name}`.

### Quick Setup

```typescript
// main.ts - Always required
import '@rds-vue-ui/rds-theme-base/style';
```

### 94 Components Across 15 Categories

| Category | Count | Examples |
|----------|-------|----------|
| Sections | 22 | Hero, testimonials, parallax, cards, video |
| Cards | 14 | Image, testimonial, article, degree, icon |
| Forms | 11 | Input, checkbox, radio, dropdown, date |
| Core | 8 | Modal, alert, accordion, tooltip, popover |
| Carousels | 5 | Image, tab, ranking, timer sliders |
| Images | 4 | Landscape, portrait, infographic, testimonial |
| Buttons | 1 | Play button |
| Footers | 2 | Standard, partner |
| Navbars | 3 | Sticky/fixed navigation |
| Accordions | 3 | Collapse, overlap, side panel |
| Lists | 3 | Circular, hover, timeline |
| Videos | 2 | Caption, modal |
| Tabs/Tables | 2 | Tab switcher, data table |
| Utilities | 6 | Breadcrumb, loader, analytics, highlight |
| **Themes** | **7** | Base, Apollo, Atlas, + 4 branded |

### Most Useful Components

**Layout Foundation:**
- `hero-standard-apollo` — Hero sections with backgrounds
- `section-apollo` — Content containers
- `footer-standard` — Page footers

**Content Display:**
- `card-image-article` — Article cards
- `carousel-image-apollo` — Image carousels
- `section-testimonial-falcon` — Testimonial displays
- `list-timeline` — Timeline/vertical lists

**Forms:**
- `typeinput-text` — Text input with suggestions
- `dropdown-apollo` — Dropdown/select
- `form-checkbox` — Checkboxes
- `radio-button-apollo` — Radio buttons
- `date-picker` — Date selection

**UI Elements:**
- `rds-alert` — Notifications
- `rds-modal` — Dialog boxes
- `rds-accordion` — Collapsible sections
- `tab-switcher-apollo` — Tab navigation

### Import Pattern

```typescript
// Single component
import { ComponentName } from '@rds-vue-ui/package-name';

// Example: Hero component
import { HeroStandardApollo } from '@rds-vue-ui/hero-standard-apollo';

// Usage in template
<HeroStandardApollo
  :bgImageSource="imageUrl"
  title="Page Title"
  :displayGradient="true"
/>
```

> **Note:** In this Nuxt 3 project, RDS components are auto-imported via `nuxt.config.ts`. You do **not** need manual import statements in page/component files.

### Common Props Pattern

**Sections & Containers:**
```typescript
title?: string
displayLabel?: boolean
labelText?: string
labelVariant?: string  // Color variant
```

**Content Components:**
```typescript
title: string
description?: string
imageSource?: string
displayBorder?: boolean
```

**Forms (v-model binding):**
```typescript
modelValue: any
placeholder?: string
disabled?: boolean
size?: 'sm' | 'md' | 'lg'
```

### Design System Themes

All components are built on theme variables. Available themes:
- `rds-theme-base` (required)
- `rds-theme-apollo` (modern blue)
- `rds-theme-atlas` (professional)
- `rds-theme-airuniversity` (Air University branding)
- `rds-theme-army` (Army branding)
- `rds-theme-dsl` (DSL branding)
- `rds-theme-starbucks` (Starbucks branding)

### Full Component List by Category

**Heroes:** hero-standard-apollo, hero-article-atlas, hero-video-apollo

**Sections:** section-apollo, section-card-apollo, section-card-atlas, section-container-atlas, section-explore-atlas, section-grid-atlas, section-intro-falcon, section-overlap-apollo, section-paginated-atlas, section-parallax-apollo, section-parallax-atlas, section-parallax-stacked, section-search-atlas, section-step-apollo, section-testimonial-atlas, section-testimonial-columns, section-testimonial-delta, section-testimonial-falcon, section-testimonial-scout, section-video-apollo, section-video-modal, sectional-testimonial-video

**Cards:** card-degree-search, card-degree-text, card-icon, card-image-article, card-image-full, card-image-tile, card-info-horizontal, card-info-vertical, card-link-atlas, card-testimonial-apollo, card-testimonial-atlas, card-text-atlas, carousel-card-apollo, starbucks-hover-card

**Forms:** form-checkbox, radio-button-apollo, radio-group-apollo, dropdown-apollo, rds-dropdown, date-picker, typeahead-search, typeahead-select, typeinput-text, file-input-apollo, phone-input-apollo

**Core:** rds-alert, rds-modal, rds-offcanvas, rds-accordion, rds-pagination, rds-popover, rds-tool-tip, rds-loader

**Carousels:** carousel-image-apollo, tab-carousel-atlas, ranking-carousel-apollo, timer-carousel-apollo

**Others:** navbar-sticky-apollo, navbar-sticky-atlas, navbar-fixed-atlas, footer-standard, footer-partner, collapse-item, side-panel-accordion, overlap-accordion-atlas, list-item-circular, list-item-hover, list-timeline, image-landscape-atlas, image-portrait-atlas, image-infographic-atlas, image-testimonial-atlas, video-caption-apollo, video-modal-atlas, button-play-apollo, tab-switcher-apollo, table-apollo, breadcrumb-apollo, highlight-apollo, content-slide-in-atlas, content-timed-delay, analytics-gs-composable, starbucks-container-atlas

---

## 4. Page Structure Conventions

```
├── pages/                  # Nuxt page routes (each .vue file = a route)
├── components/             # Custom glue components (NOT design system components)
├── layouts/                # Page layout wrappers (default.vue)
├── assets/
│   ├── content/            # JSON files driving page content
│   └── scss/               # Custom SCSS styles
├── plugins/                # Nuxt plugins (config, font-awesome)
├── public/                 # Static assets (images, favicons)
├── server/                 # Nuxt server middleware/API routes
├── .env.local              # Local environment variables
├── .env.staging            # Staging environment variables
├── .env.production         # Production environment variables
├── nuxt.config.ts          # Nuxt configuration (RDS auto-imports configured here)
└── package.json            # Dependencies and scripts
```

- **`pages/`** — Each `.vue` file becomes a route. `index.vue` is the landing page.
- **`components/`** — Only for page-specific glue logic. RDS components are imported from `@rds-vue-ui/*`.
- **`layouts/`** — Wrapper templates. `default.vue` wraps all pages.
- **`assets/content/`** — JSON files that drive page content. Load these and pass data as props to RDS components.
- **`assets/scss/`** — Custom SCSS overrides and utilities.
- **`.env.[environment]`** — Environment variables. Use `yarn env-local`, `yarn env-staging`, `yarn env-production` to activate.
- **`plugins/`** — Nuxt plugins for global configuration (e.g., Font Awesome icons, runtime config).
- **`public/`** — Static files served as-is (images, favicons, robots.txt).

---

## 5. Nuxt 3 Patterns

- Use **`<script setup>`** in all Vue components — no Options API.
- RDS components are **auto-imported** (no manual import needed) via `nuxt.config.ts`.
- Use **`useRuntimeConfig()`** for environment-specific values (API URLs, feature flags).
- Use **composables** (`composables/` directory) for shared reactive logic.
- Content is **JSON-driven**: load data from `assets/content/` and pass as props to RDS components.
- Use **`definePageMeta()`** for page-level metadata (layout, middleware).
- Use **`useHead()`** for SEO meta tags.

### Example Page Pattern

```vue
<script setup lang="ts">
import heroContent from '~/assets/content/hero.json';
import sectionContent from '~/assets/content/sections.json';

const config = useRuntimeConfig();
</script>

<template>
  <div>
    <HeroStandardApollo
      :bgImageSource="heroContent.backgroundImage"
      :title="heroContent.title"
      :displayGradient="true"
    />
    <SectionApollo
      v-for="section in sectionContent.items"
      :key="section.id"
      :title="section.title"
    >
      <!-- Section content -->
    </SectionApollo>
    <FooterStandard />
  </div>
</template>
```

---

## 6. Styling Rules

- **Bootstrap 5** grid system for layout (`container`, `row`, `col-*`).
- **SCSS** for custom styles — **NOT Tailwind**.
- **`@rds-vue-ui/rds-theme-base`** is the required theme foundation.
- **Maz-UI** for form utilities (phone input, etc.).
- Use **scoped styles** (`<style scoped lang="scss">`) in components when needed.
- Use **CSS custom properties** from the RDS theme for colors — do not hardcode color values.
- Place shared SCSS in `assets/scss/` and import via `nuxt.config.ts`.

---

## 7. MCP Server Usage

### Figma MCP (`mcp.figma.com`)

Use when the user provides a **Figma URL**:
1. Call `get_design_context` to extract design structure, colors, typography, and spacing.
2. Call `get_screenshot` to capture visual reference of the design.
3. Map extracted design tokens to RDS components and theme variables.
4. On **basic Figma accounts**, `get_design_context` may fail — fall back to screenshot-only analysis.

### Playwright MCP (`@playwright/mcp`)

Use when:
- The user provides a **reference URL** to replicate or draw inspiration from.
- You need to **take screenshots** of the dev server for visual validation.
- You need to inspect a live page's structure or content.

---

## 8. Available Skills

Invoke these skills based on the user's input type:

| Skill | When to Use |
|-------|-------------|
| `rds-component-mapper` | Mapping visual descriptions or design context to RDS components |
| `figma-to-landing-page` | User provides a Figma design URL |
| `reference-to-landing-page` | User provides a reference website URL + modification intent |
| `iterative-build-page` | User describes sections one at a time |
| `markdown-spec-to-page` | User provides a markdown specification document |

### Skill Selection Guide

- **"Build a page like this Figma design"** → `figma-to-landing-page`
- **"Make it look like this website but change X"** → `reference-to-landing-page`
- **"Add a hero section with..."** → `iterative-build-page`
- **"Here's the spec in markdown"** → `markdown-spec-to-page`
- **"What RDS component should I use for X?"** → `rds-component-mapper`

---

## 9. Environment & Build

| Command | Purpose |
|---------|---------|
| `yarn dev` | Start development server |
| `yarn build` | Build for current environment |
| `yarn build-production` | Production build |
| `yarn env-local` | Switch to local environment |
| `yarn env-staging` | Switch to staging environment |
| `yarn env-production` | Switch to production environment |

- **Package manager:** Yarn (not npm)
- **Custom npm registry:** `https://npm.edpl.us/` (configured in `.yarnrc.yml` for Yarn 4 and `.npmrc` for Yarn 1 — required for `@rds-vue-ui/*` packages)
- **Node version:** Check `.nvmrc` or `package.json` engines field
- Always run `yarn install` after modifying `package.json`
- Environment files are `.env.local`, `.env.staging`, `.env.production` at the project root — use the `env-*` scripts to copy them to `.env`
