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

