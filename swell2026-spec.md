# Swell 2026 Particle Animation — Product Specification

## Overview

An interactive particle animation where hundreds of thousands of pixels converge from random positions to form the text "Swell 2026" with a 3D appearance and sun flare effect.

---

## Core Requirements

### Visual Elements

| Element | Specification |
|---------|---------------|
| Background | Solid black |
| Particle count | 180,000 |
| Particle colors | White, grey, and black (greyscale) |
| Text | "Swell 2026" |
| Text appearance | 3D depth through layered particle structure (ASCII art style) |

### Animation Behavior

1. **Initial State**: Particles appear randomly distributed across the canvas
2. **Convergence**: Particles animate toward target positions forming the text
3. **Convergence Speed**: Fast — particles snap into position quickly
4. **Swirl Motion**: Up-and-down swirling movement during convergence (sun flare style)

### Interactivity

- **Platform**: HTML/JavaScript (Canvas)
- **Scatter**: Click/hold to scatter particles away from cursor
- **Reform**: Release to allow particles to converge back to text
- **Touch support**: Mobile-friendly touch events

---

## Layering & Depth

### Canvas Z-Order (back to front)

| Layer | Z-Index | Content |
|-------|---------|---------|
| Background | 1 | Sun flare particles |
| Foreground | 2 | Main particles forming text |

### 3D Text Effect (Particle-Based)

The 3D appearance is achieved through **particle structure**, not overlays:

- **6 depth layers** of particles
- **Back layers (0-2)**: Darker greys/black, smaller, dimmer, offset diagonally
- **Front layers (3-5)**: White/light grey, larger, brighter
- Creates natural 3D depth like ASCII art

---

## Sun Flare Effect

| Property | Specification |
|----------|---------------|
| Layer | Background (behind main particles) |
| Position | Wraps around actual font shape (not rectangular) |
| Distance from text | 5-10 pixels from letter edges |
| Motion | Orbital movement around anchor points |
| Colors | White and light grey |

### Flare Behavior

- Anchored to actual text edge pixels
- Positioned 5-10px outward following letter contours
- Small orbital animation (3-8px amplitude)
- Excluded from drawing inside text bounds

---

## Font Protection

The text is composed entirely of particles — no separate text overlay.

### Implementation

- Particles ARE the font (converge to text pixel positions)
- Flare particles check bounds and skip drawing inside text area
- Back-to-front layer rendering for proper depth

---

## Technical Implementation

| Aspect | Detail |
|--------|--------|
| Rendering | HTML5 Canvas (2 layered canvases) |
| Particle System | 180,000 main particles + 8,000 flare particles |
| Depth Layers | 6 layers with diagonal offset |
| Responsiveness | Adapts to window size |

---

## File

- `swell2026.html` — Self-contained single-file implementation
