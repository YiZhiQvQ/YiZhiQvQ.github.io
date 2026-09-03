# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GitHub Pages user site (`YiZhiQvQ.github.io`) hosting a project hub and sub-pages for personal projects.

- `index.html` — Root hub page listing all projects with cards linking to sub-pages.
- `scutnetlogin/index.html` — Landing page for **SCUTNetLogin**, a Qt 6.11 / C++17 Windows desktop application that handles campus network authentication (802.1X/EAPOL + DrCOM) for South China University of Technology (华南理工大学).

The SCUTNetLogin application source code lives at `github.com/YiZhiQvQ/SCUTNetLogin`.

## Adding a new project page

1. Create a subdirectory (e.g., `myproject/`) with its own `index.html`.
2. Add a card to the root `index.html` in the `.projects` div, following the existing `<a class="project-card">` template.
3. Push to `main`.

Access it at `YiZhiQvQ.github.io/myproject/`.

## Development

No build step, linting, or test suite. To preview, open HTML files directly in a browser. No external JS/CSS dependencies (Google Fonts degrade gracefully).

## SCUTNetLogin page architecture

Single-file page in Chinese (zh-CN) with five sections: nav, hero, features, how-it-works, download cta, footer.

Embedded JS systems, all IIFE-based:
- **Particle canvas** — Fixed-background `<canvas>` with 80 particles that drift, bounce, and repel from mouse cursor. Lines connect nearby particles.
- **Typing animation** — Loops typing/deleting `从未如此简单` in `#typing-text`.
- **Scroll reveal** — `IntersectionObserver` adds `.visible` to `.reveal` elements, triggering CSS `fadeInUp`.
- **Navbar** — `scroll` event toggles `.scrolled` for glassmorphism backdrop.
- **Mobile nav** — Dynamically injects `<style>` for `.nav-links.open`, toggles on hamburger click. Closes on link/outside click.
- **Smooth scroll** — `#` anchors use `preventDefault` + `scrollTo` with 80px offset.

CSS uses no nesting, breakpoints at 1024px/768px/480px. Glassmorphism effects use `backdrop-filter: blur()` with `-webkit-` fallbacks.

## Deployment

Push to `main` — GitHub Pages serves the repo root automatically.

## Known issues

- The SCUTNetLogin logo `<img>` (scutnetlogin/index.html:354) references `../res/SCUTNetLogin.png`, which resolves to `res/SCUTNetLogin.png` at the repo root. The image hasn't been committed to this repo — add it at `res/SCUTNetLogin.png` to fix.
