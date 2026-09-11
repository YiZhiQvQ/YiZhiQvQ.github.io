# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GitHub Pages user site (`YiZhiQvQ.github.io`) hosting a project hub and sub-pages for personal projects.

- `index.html` — Root hub page listing all projects, using the shared light editorial ("简约轻奢") design system.
- `scutnetlogin/index.html` — Landing page for **SCUTNetLogin**, a Qt 6.11 / C++17 Windows desktop application that handles campus network authentication (802.1X/EAPOL + DrCOM) for South China University of Technology (华南理工大学).

The SCUTNetLogin application source code lives at `github.com/YiZhiQvQ/SCUTNetLogin`.

## Adding a new project page

1. Create a subdirectory (e.g., `myproject/`) with its own `index.html`.
2. Add a row to the root `index.html` inside `.projects-list`, following the existing `<a class="project-row">` template (also kept as an HTML comment right below the SCUTNetLogin row). Renumber `.row-index` if needed.
3. Push to `main`.

Access it at `YiZhiQvQ.github.io/myproject/`.

## Design system (shared by both pages)

Both pages use the same editorial light-luxury theme: warm off-white background (`--bg: #fbfaf8`), serif headings (Cormorant Garamond / Noto Serif SC), sans body (Inter / Noto Sans SC), muted gold accent (`--gold: #9a7b4f`), hairline `1px` rules, `3px` radii, uppercase letter-spaced labels, and restrained hover lifts. The CSS custom properties at the top of each `<style>` block are duplicated per page — when changing the palette, update both files.

## Development

No build step, linting, or test suite. To preview, open HTML files directly in a browser. No external JS/CSS dependencies (Google Fonts degrade gracefully).

## Page architecture

Both pages are single-file, Chinese (zh-CN), and share the same embedded JS systems, all IIFE-based:
- **Typing animation** — Loops typing/deleting a phrase in `#typing-text` ("从未如此简单" on the SCUTNetLogin page, "问题解决好" on the hub). On the hub the phrase is also present in the HTML as a no-JS fallback and is cleared by the script before typing starts; both pages print the phrase directly when `prefers-reduced-motion` is set.
- **Scroll reveal** — `IntersectionObserver` adds `.visible` to `.reveal` elements, triggering the CSS opacity/translate transition. Staggered `transition-delay` rules handle siblings.
- **Navbar** — `scroll` event toggles `.scrolled` for the blurred translucent backdrop.
- **Mobile nav** — Toggles `.nav-links.open` on hamburger click; closes on link click, outside click, or `Escape`.
- **Smooth scroll** — `#` anchors use `preventDefault` + `scrollTo` with a fixed-nav offset.
- **Preview gallery** (SCUTNetLogin only) — Tabs switch `assets/shot_*.png` with an auto-advance timer that pauses on hover.

CSS uses no nesting, prefers `var(--token)` values, and sets breakpoints at 1080px / 900px / 768px / 480px, plus a `prefers-reduced-motion` block that disables animation and forces `.reveal` visible.

## Deployment

Push to `main` — GitHub Pages serves the repo root automatically.

## Known issues

- SCUTNetLogin screenshots in `scutnetlogin/assets/` are captured by `scutnetlogin/capture_shots.ps1` and can lag behind the application UI.

