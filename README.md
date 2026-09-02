# MacHotkeyWindowManagement

Hammerspoon window management. All logic lives in `init.lua`.

## Keybindings

| Shortcut | Action |
| --- | --- |
| `⌘⌥ctrl` + arrow | Move focus to the window in that direction (reversible, see below) |
| `⌘⌥` + ←/→ | Step the focused window left/right along its row of the slot grid |
| `⌘⌥` + ↑/↓ | Step the focused window between full-height / top half / bottom half |

## The slot grid (2-column monitors)

Every slot is a **column** (x and width) crossed with a **row** (y and height).
`⌘⌥`←/→ moves along the current row; `⌘⌥`↑/↓ moves between rows in the current
column. Horizontal moves never change the row, vertical moves never change the
column.

Columns are ordered by their **center**, which is what makes `⌘⌥→` sweep the
window evenly left to right rather than jumping around:

| # | Column | Span | Center |
| --- | --- | --- | --- |
| 1 | q1 | 0–25% | 12.5 |
| 2 | left ⅓ | 0–33% | 16.7 |
| 3 | left ½ | 0–50% | 25 |
| 4 | left ⅔ | 0–67% | 33.3 |
| 5 | q2 | 25–50% | 37.5 |
| 6 | mid ⅓ | 33–67% | 50 |
| 7 | center ½ | 25–75% | 50 |
| 8 | q3 | 50–75% | 62.5 |
| 9 | right ⅔ | 33–100% | 66.7 |
| 10 | right ½ | 50–100% | 75 |
| 11 | right ⅓ | 67–100% | 83.3 |
| 12 | q4 | 75–100% | 87.5 |

Rows, in the order `⌘⌥↑` walks them: full height → top half → bottom half,
then wrapping. `⌘⌥↓` walks the same three backwards.

That is 12 × 3 = 36 slots. Complementary columns tile exactly, so `left ⅔` +
`right ⅓` covers the screen.

Two exceptions, both preserving older behaviour:

* **Full screen** is a 13th stop on the full-height row only, sitting between
  q4 and q1 as the wrap. The half-height rows have no full-width slot.
* **From full screen**, `⌘⌥↑`/`⌘⌥↓` split into the left/right half rather than
  the top/bottom half.

4-column monitors (the ultrawides) keep their own cycle in the branch cascade:
quarters interleaved with thirds, no halves.

## Reversible focus movement

`hs.window`'s `:windowsToEast` / `:windowsToWest` pick a neighbour by angle and
distance, and those picks are not symmetric: `⌘⌥ctrl→` from A can land on C
while `⌘⌥ctrl←` from C lands on B, so the arrows do not undo each other.

`focusWindowInDirection` therefore records each jump it makes, and the opposite
arrow retraces that trail rather than re-running the geometry. Multi-hop paths
retrace in full, including paths that mix axes (right, down, then up, left).

The trail self-heals — it is discarded whenever focus changes by any other
means (a click, cmd-tab) or the window it points back to is closed or
minimised, at which point the arrows fall back to plain geometry. It is capped
at 25 hops (`FOCUS_TRAIL_MAX`).

Trade-off: after jumping right, the opposite arrow is committed to going back
where you came from, so a window that sits *between* the two is not reachable
with one keypress. To get one-level undo instead of a full path retrace, clear
the trail after retracing instead of popping a single entry.

## Slot naming

The frame variables in `init.lua` read confusingly. For the thirds:

| Variable | Actually means |
| --- | --- |
| `one_third` | left ⅓ |
| `two_third` | **middle** ⅓ |
| `three_third` | **right** ⅓ |
| `one_two_third` | left ⅔ |
| `two_three_third` | right ⅔ |

## Development

`local dev = true` at the top of `init.lua` prints the current frame and each
transition to the Hammerspoon console.

Syntax-check before reloading (`brew install lua`):

```sh
luac -p init.lua
```

`init.lua` has no pathwatcher, so changes need a manual **Reload Config** from
the Hammerspoon menu bar item.
