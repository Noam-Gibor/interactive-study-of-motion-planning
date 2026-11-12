# CLAUDE.md - Micromouse Motion Planning Talk

## What this project is
An interactive, visual-first presentation for Noam's motion planning course (Prof. Zvi Shiller, Mechanical Engineering and Mechatronics, Ariel University).
Topic: how speed-run maze-solving robots (Micromouse) plan their motion: turn shapes, speed and acceleration through corners, diagonals, and the speed profile.
Inspiration: Veritasium, "The Fastest Maze-Solving Competition On Earth" https://www.youtube.com/watch?v=ZMQbHMgK2rw
The key part of the video for this talk is around 16:00 to 16:30 (optimal ways to take a turn, the turn library, the command chain).

Deliverable: `index.html`, one self-contained file that runs offline in a browser on the classroom projector.

## The #1 rule: visuals do the talking
Noam presents the talk out loud, so the screen should not repeat what he says.
- One idea per scene. The visual carries it. The text is a caption, not an explanation.
- **Text budget per scene: a title of 6 words or fewer, plus at most ONE caption line of 12 words or fewer.** No paragraphs or bullet lists on screen.
- Numbers and labels go *inside* the drawing (a radius written next to its arc, a speed next to the mouse), not in side panels.
- Anything that needs explaining is animated: draw the path, move the mouse, grow the wave, fill the graph in real time.
- If a scene needs more than one caption line, split it into two scenes.
- Speaker notes (optional) go in a hidden panel toggled with `N`. That's where the longer explanation lives.
- Earlier versions failed because they were text-heavy web pages with cards. Do NOT make cards, stat tiles, or long explainer sections.

## Format: a scene-by-scene deck, not a scrolling page
- Full-screen scenes, 16:9, scaled to fit the window.
- Navigate with Right/Left arrows, Space and click. Show a small progress dot row at the bottom.
- Inside a scene, extra steps ("builds") reveal on the next arrow press before moving to the next scene, like the video revealing one arc at a time.
- `R` replays the current scene's animation.
- Interactive controls (sliders) appear only in scenes that need them: big, few, placed at the bottom edge.
- Respect `prefers-reduced-motion` (jump to the final frame).

## Visual language (copy the video's style)
Taken from the frames at 16:00 to 16:30:
- **Background:** warm parchment/beige paper (around `#EFE3CF` with a soft vignette), like the video.
- **Maze boards:** black floor (`#0B0B0B`) inside a thick red frame, red walls (`#E8302F`) with slightly darker posts, a faint grey cell grid. Boards look like hand-cut cards with a subtle drop shadow and slightly rough edges.
- **Paths:** thick, rounded strokes in bright saturated colours with a slight hand-drawn wobble:
  - straight = lime/yellow-green `#B5D334`
  - 45° / gentle turns = blue `#4C8BE8`
  - 90° = orange `#F28C28`
  - 135°/180° = magenta `#C93FD3`
  - diagonal run = red `#E94545`
  - extra colours for overlays: teal `#22B8C8`, yellow `#F2D33A`, green `#3CC35A`, purple `#8E5BE8`
- **Arrows:** path pieces drawn as fat arrows (like the video's command-chain diagram), each piece coloured by its move type.
- **Labels:** big serif display type in red or blue, sitting on the parchment beside the board (like "Minimum 90°", "Diagonal Long 180°"). Suggested font: a serif with character from Google Fonts (e.g. "Fraunces" or "DM Serif Display"), fallback Georgia. Numbers in a clean mono.
- **The mouse:** a small cute top-down sprite (white/grey body, clear nose direction). Not a blue rectangle.
- **Command letters:** F / R / L in circles, drawn on the maze like the video (yellow `F` arrows, red circled `R`).
- Overall feel: bright, playful, colourful, slightly hand-made. Emoji are fine as small accents. NOT dark/cyberpunk/futuristic UI, no neon glows, no glassmorphism.

## Storyboard (target: about 10 scenes, 5 to 7 minutes)
Each scene: [visual] / caption / course link (for speaker notes only).

1. **Title.** A maze board; a mouse zips through on a smooth path, leaving a coloured trail. Title: "How fast can a mouse turn?"
2. **The challenge.** A top view of a 16×16 board with the centre goal highlighted, cell size marked "18 cm". Two runs shown back to back: a slow wandering search (online) then a fast clean run (offline). Caption: "Search slowly. Then race."
   - Course: Lecture 1, online vs offline.
3. **Flood fill = Dijkstra from the goal.** The goal cell gets 0; a colour wave spreads cell by cell writing numbers. Then the mouse "rolls downhill" from the start. Interactive: click a gap to drop a wall and watch it re-flood instantly. Caption: "Every cell knows its distance to the goal."
   - Course: Lectures 2-3, Bellman principle, Dijkstra opened from G with u_G = 0, "cost from ALL nodes to G". Note: with unit edges it's BFS; real mice use time costs.
4. **Shortest is not fastest.** Two routes on the same board: fewer cells but many turns vs more cells with long straights. Race them; the longer one wins. Caption: "Optimise time, not distance."
   - Course: Lecture 1 slide "Optimal trajectory planning (time, energy, not distance)".
5. **Ways to take ONE corner (the 16:00 moment).** One corner on a board. Build 1: stop and spin (mouse halts, rotates). Build 2: small search turn r = 90 mm. Build 3: large turn cutting the inner corner. Each arc drawn in a different colour, with its radius and corner speed written by the arc. Three mice run them side by side with timers. Caption: "Bigger radius, higher speed."
6. **Corner lab (interactive).** A radius slider and a grip slider ("no fan" ↔ "fan"). Live: the arc on the board, the mouse running it, and a big number "v = √(a·r)" updating. A small live speed-over-time graph under the board. Clothoid toggle: the curvature ramps in, shown with a sideways-force graph that ramps instead of jumping. Caption: "v = √(a·r)".
7. **The turn library.** All library moves drawn from ONE entry point, overlaid on one board (like the video's overlay of coloured arcs), revealed one per click with the big serif label: Search 90°, Large 90°, Long 180°, 45° in, 135° in, Diagonal V90. Caption: "Pre-tuned moves, stored in memory."
8. **Zigzag vs diagonal.** A long corridor of zigzag cells (like the video's long strip): first the stair-step path with many turns (teal), then one straight diagonal line through the posts (orange). Race them. Caption: "Cut straight through the posts."
   - Course: Lecture 2, C-space: mouse width plus walls decide whether the diagonal fits; on a diagonal the robot is rotated, so (x, y, θ).
9. **Command chain.** The raw command string `F F R F L F R …` appears as letter chips on the maze, then morphs into coloured arrow pieces (straight / 45 / 90 / diagonal) along the path, like the video's arrow-chain image. Caption: "Compile cells into moves."
10. **Speed plan in the phase plane.** Graph s on x, speed on y. Animate: the grip limit curve (dashed), the forward pass (accelerate, orange) sweeping right, the backward pass (brake, pink) sweeping left, then the final green profile as the lower of the two. A mouse on a mini maze above moves in sync. Caption: "Accelerate forward. Brake backward. Take the minimum."
    - Course: Lectures 1+3, path-velocity decomposition; the time-optimal along-path problem (Bobrow, Dubowsky & Gibson 1985; Shin & McKay 1985), Prof. Shiller's research area.
11. **The race.** Same maze, three mice: stop and spin / smooth 90s / large turns + diagonals. Big timers above each. A live speed-vs-time graph draws underneath. Caption: "Same cells. 3× faster."
12. **The honest limit.** Split screen: "path first, then speed" vs "optimise both together", with a question mark. Caption: "Fast to compute. Near-optimal, not optimal."

Optional bonus scene: a fan mouse (downforce arrows) and the grip slider pushing the speed curve up.

## Physics and algorithms (reuse these, they work)
A working reference implementation is in `reference_v2.html` (the old text-heavy version). REUSE its logic, NOT its layout or styling. Useful functions:
- `buildPath(pts, rFor)`: fillets a polyline with arcs; `rFor(angle, available)` returns the radius (0 = stop and spin). Produces samples with x, y, heading h, and curvature k.
- `turnPoly(cells)`: polyline through the centres of turning cells (used for stop-and-spin and search turns).
- `midPoly(cells)`: polyline through the midpoints of crossed cell edges. Zigzags automatically become diagonal lines, and single turns become large turns. Fillet with the largest radius that fits (cap around 420 mm).
- `profilePath(segs)`: builds a path from a curvature profile (straight / arc / linear clothoid ramp), used for the clothoid comparison.
- `topp(S, a_g, v_max)`: time-optimal speed along a fixed path:
  - `vlim = min(v_top, sqrt(a / |k|))`, 0 at spin points
  - forward pass: `v[i+1] = min(vlim, sqrt(v[i]^2 + 2*a_free*ds))`
  - backward pass: the same in reverse (braking)
  - `a_free = sqrt(a^2 - (v^2*k)^2)` (friction circle: grip is shared between braking and turning)
  - spin time = `2*sqrt(|θ|/α)`, with α = a / (track/2), track = 70 mm
  - also returns forward-only and backward-only arrays for the phase plane animation
- Flood fill: BFS from the goal over the wall set; the descent path prefers going straight.

Constants: cell 180 mm, wall/post thickness about 12 mm, g = 9810 mm/s².
Defaults: grip 1.5 g, top speed 4 m/s. With these on the 6×6 race maze: stop and spin ≈ 4.0 s, smooth 90s ≈ 1.9 s, large turns + diagonals ≈ 1.2 s.
Grip ranges: no fan ≈ 1 g; suction fan → several g (keep claims qualitative).

Race maze (6×6, cells as [x, y], y up):
`[[0,0],[0,1],[0,2],[1,2],[2,2],[2,1],[3,1],[3,0],[4,0],[5,0],[5,1],[5,2],[4,2],[4,3],[3,3],[3,4],[3,5]]`
For the flood scene, design a NEW maze where most cells are reachable (the old one left half the cells closed off, which looked wrong).

## Course mapping (for speaker notes; NOT on the slides as text)
| Concept | Lecture | Where it appears |
|---|---|---|
| Trajectory = path + velocity profile | L1 | the whole talk's structure |
| Online vs offline planning | L1 | search run vs speed run |
| Optimal = time, not distance | L1 | scenes 4, 11 |
| C-space, C-space obstacles | L2 | diagonal fit, mouse width, (x, y, θ) |
| Uniform grid cell decomposition | L2 | the maze itself is the grid |
| Bellman principle, Dijkstra from G | L2-L3 | flood fill scene |
| A* | L3 | mention: speeds up the search with time costs |
| Path-velocity decomposition | L1, L3 | turn library + speed plan |
| Kinodynamic / state space (x, ẋ) | L3 | phase plane scene |
| Potential fields: local minima | L1, L3 | one spoken line: a maze is the classic local-minimum trap |

## Facts (state carefully)
- Classic Micromouse maze: 16×16 cells, 18 cm per cell, goal in the centre. Search run(s) then speed run(s) within a time limit.
- Top mice use suction fans for downforce, IR wall sensors, a gyro and wheel encoders.
- Diagonal runs through the zigzag posts are shorter by about √2 and avoid repeated turns.
- The model here is simplified (point mass, one grip number, perfect tracking). Say so on scene 12 or in the notes.
- Verify anything not listed here against the video before putting it on a slide.

## Tech rules
- One `index.html`, vanilla JS + Canvas 2D. No build step, no frameworks. Google Fonts allowed, with fallbacks.
- Draw with canvas, scaled for devicePixelRatio. Keep a 16:9 stage and letterbox it.
- 60 fps animations driven by `requestAnimationFrame` and a time variable, so they can be replayed and scrubbed.
- Separate modules inside the file: `physics` (paths, topp, flood), `draw` (board, walls, paths, mouse sprite, arrows, labels), `scenes` (an array of `{title, caption, builds, setup, draw(t), notes}`), `deck` (navigation).
- Make it test at 1920×1080 and at a laptop size. Check every scene with a screenshot before calling it done.

## Writing style rules (Noam's preferences)
- Never use em dashes or en dashes anywhere (text, comments, captions). Use a simple hyphen or rephrase.
- Short, plain words. English on the slides.
- Bright, lively, colourful, emoji welcome as accents. Never dark-mode or gloomy UI chrome (the black maze boards from the video are fine; they sit on bright parchment).

## Done means
- [ ] Every scene passes the text budget (title of 6 words or fewer, one caption of 12 words or fewer).
- [ ] Every scene has motion or interaction that explains the idea without the caption.
- [ ] The style matches the video: parchment, black boards, red walls, thick colourful arcs, serif labels.
- [ ] Arrow-key navigation, builds, replay (R), notes (N) all work.
- [ ] Physics numbers come from `topp` (no hard-coded fake numbers).
- [ ] No em dashes anywhere in the file.
