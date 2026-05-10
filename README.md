# Hammerfel

A Godot 4.x project.

## Getting started

### Prerequisites
- [Godot 4.x](https://godotengine.org/download) (latest stable)
- [Git LFS](https://git-lfs.com/) installed (`git lfs install` once per machine)

### Clone
```bash
git clone https://github.com/hellochuckwallaworks/Hammerfel.git
cd Hammerfel
git lfs install   # one-time, per machine
git lfs pull      # fetch any LFS-tracked binaries
```

Then open the folder in Godot ("Import" → select `project.godot`).

## Collaboration workflow

- **Pull before you work:** `git pull --rebase` to avoid merge commits.
- **Commit small, often.** Scenes (`.tscn`) and resources (`.tres`) are text but merge poorly — coordinate before two people edit the same scene.
- **Don't commit `.godot/`** — it's local cache, regenerated on first open.
- **Binary assets** (images, audio, models, fonts) are tracked via Git LFS — see `.gitattributes` for the full list.
- **Push:** `git push origin main`

## Avoiding scene merge conflicts

`.tscn` files are diff-able but two simultaneous edits to the same scene will conflict in painful ways. Conventions to keep things smooth:
1. Use a chat or PR-based flow for any non-trivial scene changes.
2. Split big scenes into sub-scenes when you can — smaller scope means fewer conflicts.
3. If you suspect someone else is editing a scene, ask before touching it.
