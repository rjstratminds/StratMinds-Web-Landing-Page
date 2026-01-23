# StratMinds Landing - Project Notes

## What Was Done
- Built a WebGL/particle hero in `public/index.html` with ripple hole, hidden text, warp/hyperspace visuals, and scroll-aware typography/sections.
- Added audio behavior:
  - Background ambience plays when Sound is ON.
  - Hyperspace engage SFX plays when Warp + Sound are ON.
  - Ripple hole press/release plays a whoosh SFX (forward on press, reversed on release).
  - Clicking any video card mutes site audio (Sound OFF).
- Added two video cards under "Dual Investment Thesis" with modal overlay playback and speed controls.
- Organized media under `public/media/` with subfolders for audio, video, icon, image, logo.
- Deployed to Firebase Hosting project `stratminds-ai-bot`.

## Recent Updates (Jan 2026)

### Hidden Text Interactive LinkedIn Links
- **Hidden Text**: Displays team names (Richard Jhang, Anton Borzov, Summer Kim, Arie Fisher) in 4 columns when holding/pressing on logo area.
- **Interactive**: Hold for 600ms+ to reveal names, release over a name to open their LinkedIn profile.
- **Hit Detection**: Uses computed bounds from actual particle positions, converted to screen coordinates with 10px buffer and 40px vertical offset.
- **LinkedIn URLs**:
  - Richard Jhang → linkedin.com/in/richardjhang/
  - Anton Borzov → linkedin.com/in/tyggy/
  - Summer Kim → linkedin.com/in/skim725/
  - Arie Fisher → linkedin.com/in/ariefisher/

### Contact Strip
- Changed from emoji icons to text links: `email.` `linkedIn.` `portal.`
- Default color: `rgba(255, 255, 255, 0.68)`
- Hover/focus: green `#3be28c`
- `portal.` has `opacity: 0.85` (slightly softer)
- Font size: 16px desktop, 12px mobile

### Performance Optimizations
- **Desktop**: Logo particles increased 50% (multiplier 5.4), hidden text 2x sharper (stepDiv 240k, 2.1M particles)
- **Mobile**: Logo particles reduced (multiplier 1.35), hidden text 2x sharper (stepDiv 180k, 1.4M particles), logo 20% larger (scale 0.82)
- **Settle behavior**: Logo settles after 1.5s idle at top (animations reduce to 2%)
- **Mobile animation**: Logo settles in 1.5s (vs 3.6s desktop)

### Video Thumbnails
- Reduced size 20% (max-width 314px desktop, 280px mobile)
- Mobile now shows 2 columns instead of 1

- **Intro Layout**: Fixed positioning so tagline, contact icons, and green triangle flow vertically below logo with consistent 48px spacing using flexbox.
- **Green Triangles**: Replaced CSS border triangles with SVG polygons that:
  - Gradually hollow out (fill fades, stroke remains) as they scroll from bottom to center of screen.
  - Use thin 1px stroke when fully hollow.
  - Controlled via `--hollow` CSS custom property updated in JS render loop.
- **Logo Dimming**: Logo particles dim to near-black (0.04 brightness) when "Purpose-Built Since 2018" section reaches 50% viewport height for text legibility.
- **Video Thumbnails**:
  - Added thin white border (`1px solid rgba(255,255,255,0.35)`).
  - White text titles on transparent background.
  - Reduced size to 70% (max-width: 392px).
  - Renamed second video title to "UX for AI".
- **Metric Headings**: "As many as 1,000+/day", "2B+ Users", "San Francisco" now use green color (#3be28c).
- **Text Blocks**: Increased max-width from 46ch to 69ch (50% wider).
- **Content Updates**: Rewrote copy for Dual Investment Thesis, VC + Advisory Platform, Why Now, and Performance & Access sections.

## Current Structure
- Entry point: `public/index.html`
- Media:
  - `public/media/audio/` (mp3)
  - `public/media/logo/StratMinds.png`
  - `public/media/icon/StratMinds Video Logo.png`
  - `public/media/video/` (mp4 + icon jpg)
  - `public/media/image/` (unused backgrounds)

## Video Overlay
- Two tiles under "Dual Investment Thesis":
  - Intro to StratMinds
  - UX for AI
- Clicking a tile opens a modal and auto-mutes site audio.
- Playback speed controls removed (native controls only).

## Audio Rules
- Sound toggle controls background ambience.
- Warp toggle + Sound ON triggers hyperspace SFX when the yellow/green cue hits center.
- Ripple whoosh only plays when Sound ON and click is inside the logo bounds.

## Hosting / Deploy
- Firebase Hosting project: `stratminds-ai-bot`
- Firebase config: `firebase.json` (public = `public/`, SPA rewrite to `/index.html`).
- Deploy command:
  - `firebase deploy`
- Live URL:
  - https://stratminds-ai-bot.web.app

## Git / Large Files
- MP4s are large and tracked via Git LFS (`.gitattributes` includes `*.mp4`).
- If pushes fail with HTTP 400, use:
  - `git config --global http.postBuffer 524288000`
  - then `git push`.

## Notes / Pitfalls
- If the live site shows Firebase default, deploy from the repo root with correct `public/` assets.
- If media fails to load, verify paths are `media/...` relative to `public/index.html`.
- For local testing, serve via HTTP (e.g., `python3 -m http.server`) so audio can load.

