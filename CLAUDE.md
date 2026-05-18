# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GitHub Pages repository (`YiZhiQvQ.github.io`) hosting the landing page for **SCUTNetLogin**, a Qt 6.11 / C++17 Windows desktop application that handles campus network authentication (802.1X/EAPOL + DrCOM) for South China University of Technology (华南理工大学).

The actual application source code lives in a separate repository at `github.com/MC-June/SCUTNetLogin`.

## Repo structure

- `index.html` — Single-file static landing page with embedded CSS and JS. No build step, no dependencies, no framework. Served directly by GitHub Pages.

## Development

There is no build process, linting, or test suite. To preview changes, open `index.html` directly in a browser. The page uses no external JS/CSS dependencies (Google Fonts are loaded but the page degrades gracefully without them).

## Deployment

Push to `main` — GitHub Pages serves the repo root automatically.

## Known issues

- The logo image at line 367 references `../res/SCUTNetLogin.png`, which resolves to a path above the repo root on GitHub Pages. This will 404 in production. The `<img>` has an `onerror` fallback that hides it, but the image should either be committed into this repo (e.g., at `res/SCUTNetLogin.png`) or the src path should be fixed.
