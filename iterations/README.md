# Iterations

How the talk got from a text-heavy web page to a 20-scene animated deck. Every version that still exists is here, and git tags `v2` to `v6` mark them in the history.

| Version | What it was | Files |
|---|---|---|
| v1 | First attempts: text-heavy pages with cards. | not preserved |
| v2 | "Micromouse Motion Lab": one scrolling lab-notebook page with live experiments. The physics worked; the format did not. | [`../context/reference_v2.html`](../context/reference_v2.html), [screenshot](v2-text-page.jpg) |
| v3 | First scene-by-scene deck, built from the brief in [`../context/CLAUDE.md`](../context/CLAUDE.md): 12 scenes, Veritasium look, physics reused from v2. | [screenshots](v3-first-deck/) (source was edited in place, so only images remain) |
| v4 | Phase-plane sequence after Shiller and Lu (1992): 6 new scenes, derivations in the speaker notes, 17 scenes in total. | [`v4-phase-plane.html`](v4-phase-plane.html) |
| v5 | B-spline speed profile: "Smooth it with a B-spline" and the "Smooth or fast?" slider. 19 scenes. | [`v5-bspline-speed.html`](v5-bspline-speed.html) |
| v6 | B-spline path: "Smooth the path, too". 20 scenes. **Current.** | [`../index.html`](../index.html), [screenshots](../docs/screenshots/) |

## v2: one long page

![v2 page](v2-text-page.jpg)

Everything was correct and interactive, but the screen repeated what the speaker says: cards, paragraphs, stat tiles. The lesson became rule #1 of the brief: *visuals do the talking*, with a title of 6 words or fewer and one caption line of 12 words or fewer per scene. The physics (`buildPath`, `midPoly`, `topp`, flood fill) carried over to every later version.

## v3: the first deck

![v3, all 12 scenes](v3-first-deck/scene-sheet.jpg)

Full-screen 16:9 scenes on parchment, black maze boards with red walls, thick colourful paths, a mouse sprite, builds on each arrow press. First review fixes: boards no longer collide with titles, flood-fill walls got a dark outline, the search maze got fewer loops so the search wanders, and the command chain merges 45° fillets into library moves (R135, L180).

## v4: the phase plane

Scenes 10 to 15 were added between the command chain and the race: *One path, one number*, *The acceleration window*, *The velocity limit curve*, *Full throttle or full brake*, *Sinks, sources, switches*, *Riding the limit*. They follow Shiller and Lu (1992) figure by figure, and the speaker notes carry the derivations with lecture-slide pointers.

## v5: B-spline speed profile

The bang-bang profile is time-optimal, but its acceleration jumps (infinite jerk). The speed plan b(s) = ṡ² became a cubic B-spline, with the control points as the variables. The convex hull keeps it under the velocity limit curve, and its derivative bounds the acceleration. A first attempt split grip into separate sideways and forward limits and reached 1.96 g. It was replaced by a loop that re-solves until the 1.5 g friction circle holds everywhere.

| Control points | Time | Peak jerk |
|---|---|---|
| 7 | 1.62 s | 89 m/s³ |
| 25 | 1.42 s | 121 m/s³ |
| 71 | 1.32 s | about 2200 m/s³ |
| bang-bang | 1.24 s | infinite |

## v6: B-spline path

Lines plus arcs make curvature jump, which puts cliffs into the velocity limit curve. A cubic B-spline path on the corridor centreline (one control point every 150 mm) has continuous curvature. It came out faster and safer: 1.22 s instead of 1.24 s, and 49 mm from the nearest wall instead of 39 mm. Spacing matters: one control point every 60 mm gives 1.51 s.
