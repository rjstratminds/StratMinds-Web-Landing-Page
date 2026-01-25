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

### Team Page Layout Refinements
- **2-column grid**: Lead Partners now display in 2 columns (was 4), max-width 600px
- **Responsive simplification**: Removed 900px breakpoint (2-column is now default)
- **Role text**: Summer's role now reads "Next Gen UX / +Tech Adoption" (line break)
- **Bio typos fixed**: "over a 1.8 billion" → "over 1.8 billion", added Oxford comma to Arnold's bio
- **Role shortening**: Mike's role simplified to "Next Gen AI+Enterprise"

### "Our Team" Link Styling
- Restyled from bold green text to pill/button style
- Uppercase, 12px font, 0.2em letter-spacing
- Transparent background with solid white border
- Hover: green text + green border

### Favicon
- Updated `favicon.jpg` (new version)

### Team Page (stratminds-team.html)
- **New page**: Created `stratminds-team.html` with team member profiles
- **Lead Partners**: Richard Jhang, Anton Borzov, Summer Kim, Arie Fisher
- **Advisory Partners**: Mike Mortensen, Arnold Liwanag
- **Profile photos**: Circular B&W photos in `public/media/team/`
- **Hover effect**: Green border (#3be28c) + 5% zoom on hover
- **LinkedIn links**: Clicking profile photo opens LinkedIn in new tab
- **Starry background**: Animated twinkling stars matching index.html aesthetic
- **"Our Team" link**: Added centered below metrics grid on index.html (green, bold, title case)

### Button Hover Effects
- **Warp On / Sound Off buttons**: Now turn green (text + border) on hover, matching Back button style

### Content Updates
- **Signals**: "StratMinds AI for real-time market analysis and trend tracking."
- **Geo Edge**: "Embedded in the epicenter of AI capital, brains and startups."

### Favicon
- Updated to black/white PNG version (`favicon.png`)
- Used for both standard favicon and Apple touch icon

### Hidden Text Interactive LinkedIn Links
- **Hidden Text**: Displays team names (Richard Jhang, Anton Borzov, Summer Kim, Arie Fisher) in 4 columns when holding/pressing on logo area.
- **Two-step interaction**: Hold to reveal names, then click/tap on a name to open LinkedIn (prevents accidental navigation).
- **Ripple behavior**: Fixed ripple staying open after maximizing hold duration.
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
- Team page: `public/stratminds-team.html`
- Media:
  - `public/media/audio/` (mp3)
  - `public/media/logo/StratMinds.png`
  - `public/media/icon/StratMinds Video Logo.png`
  - `public/media/video/` (mp4 + icon jpg)
  - `public/media/image/` (unused backgrounds)
  - `public/media/team/` (profile photos: richard-jhang.png, anton-borzov.png, summer-kim.png, arie-fisher.png, mike-mortensen.png, arnold-liwanag.png)

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

### Release Cleanup
Firebase Hosting keeps all previous versions by default, consuming significant storage (~800MB per release with videos).

**Cleanup script**: `scripts/cleanup-firebase-releases.sh`
- Deletes old releases, keeps last N (default: 2)
- Shows storage consumed and freed
- Requires: `gcloud auth login` (one-time setup)

**Usage**:
```bash
./scripts/cleanup-firebase-releases.sh      # Keep last 2 releases
./scripts/cleanup-firebase-releases.sh 3    # Keep last 3 releases
```

**Reminder**: Run after deploying to free storage. Each deploy adds ~800MB.

## Git / Large Files
- MP4s are large and tracked via Git LFS (`.gitattributes` includes `*.mp4`).
- If pushes fail with HTTP 400, use:
  - `git config --global http.postBuffer 524288000`
  - then `git push`.

## Notes / Pitfalls
- If the live site shows Firebase default, deploy from the repo root with correct `public/` assets.
- If media fails to load, verify paths are `media/...` relative to `public/index.html`.
- For local testing, serve via HTTP (e.g., `python3 -m http.server`) so audio can load.

