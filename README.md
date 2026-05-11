# Kyndholm

A cozy dwarven farming & crafting RPG. Top-down 2D, pixel art, Godot 4.x.

> **Read first:** [`docs/Kyndholm_GDD_v0.3.txt`](docs/Kyndholm_GDD_v0.3.txt) is the Game Design Document. [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) explains the folder layout and conventions.

---

## 1. Prerequisites

Install these once per machine:

- **[Godot 4.x](https://godotengine.org/download)** — latest stable. Just unzip and run; no installer needed on Windows.
- **[Git](https://git-scm.com/downloads)** — on Windows, install Git for Windows (it includes Git Bash).
- **[Git LFS](https://git-lfs.com/)** — needed because images, audio, and 3D files are stored via LFS, not regular git. After installing:
  ```bash
  git lfs install
  ```
  (Run this once per machine. It sets up the LFS hooks in your global git config.)

---

## 2. GitHub access

You need to be a member of the [`hellochuckwallaworks`](https://github.com/hellochuckwallaworks) GitHub organization with at least **Write** access on this repo. If you're not sure, ask the repo owner to invite you.

You then need a way for your machine to authenticate to GitHub as your user. Pick **one** of these:

### Option A — SSH (recommended)

1. Generate a key (skip if you already have one you want to use):
   ```bash
   ssh-keygen -t ed25519 -C "your-email@example.com"
   ```
   Press Enter through the prompts to accept the defaults.
2. Print the public key:
   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```
3. Go to https://github.com/settings/keys → **New SSH key** → paste it → Add.
4. Test:
   ```bash
   ssh -T git@github.com
   ```
   You should see `Hi <your-username>! You've successfully authenticated…`

### Option B — HTTPS with a Personal Access Token

1. Create a PAT at https://github.com/settings/tokens?type=beta
   - Resource owner: `hellochuckwallaworks`
   - Repository access: select Kyndholm (or all repos)
   - Permissions: **Contents → Read and Write**, **Metadata → Read**
2. When you `git clone` or `git push` you'll be prompted for a username and password — paste the PAT as the password. Git for Windows will cache it automatically.

---

## 3. Clone the project

**SSH:**
```bash
git clone git@github.com:hellochuckwallaworks/Kyndholm.git
cd Kyndholm
git lfs pull   # fetch any LFS-tracked binaries
```

**HTTPS:**
```bash
git clone https://github.com/hellochuckwallaworks/Kyndholm.git
cd Kyndholm
git lfs pull
```

Then open the folder in Godot:
1. Launch Godot.
2. Click **Import**.
3. Select the `project.godot` file inside the cloned folder.
4. Click **Import & Edit**.

The `.godot/` cache folder will be generated locally on first open — that's normal, it's gitignored.

---

## 4. Daily workflow

### Pull before you work
```bash
git pull --rebase
```
The `--rebase` flag avoids creating noisy merge commits when both of you have been working in parallel.

### Commit and push
```bash
git add .
git commit -m "short description of what changed"
git push
```

### Check what's about to be committed
```bash
git status        # what's changed
git diff          # see the actual changes
git diff --staged # see what's staged for the next commit
```

---

## 5. Avoiding scene-merge pain

`.tscn` (scene) and `.tres` (resource) files are text and *technically* mergeable, but in practice two simultaneous edits to the same scene almost always conflict in ways that are painful to resolve by hand.

Conventions to keep things smooth:

1. **Coordinate in chat** before you do non-trivial work on a scene someone else might be touching.
2. **Pull frequently.** A 30-second `git pull --rebase` before you start saves an hour of conflict resolution later.
3. **Split big scenes into sub-scenes.** Smaller scope = fewer collisions. If two people need to edit the same scene, see if the work can be done on separate child scenes that get instanced in.
4. **Commit often, in small chunks.** A commit per logical change (one feature, one fix) is much easier to merge than one giant commit at end-of-day.
5. **Don't edit project settings simultaneously.** `project.godot`, input maps, autoloads — these merge poorly. Coordinate.

If you do hit a conflict in a `.tscn` file: it's often easier to pick one side (`git checkout --theirs path/to/scene.tscn` or `--ours`), then re-apply the other person's change manually in the Godot editor, than to merge by hand.

---

## 6. What's tracked vs. ignored

**Tracked (committed to git):**
- `project.godot` and all scene/script/resource files
- `.gitignore`, `.gitattributes`, `README.md`

**Tracked via Git LFS** (see `.gitattributes` for the full list):
- Images: `.png`, `.jpg`, `.jpeg`, `.gif`, `.bmp`, `.tga`, `.psd`, `.exr`, `.hdr`, `.webp`
- Audio: `.wav`, `.ogg`, `.mp3`, `.flac`
- Video: `.mp4`, `.mov`, `.webm`
- 3D: `.glb`, `.gltf`, `.fbx`, `.blend`, `.obj`
- Fonts: `.ttf`, `.otf`
- Archives: `.zip`, `.7z`

**Ignored** (never committed):
- `.godot/` — Godot's local cache and import data, regenerated automatically
- `.import/` — legacy import cache
- IDE folders (`.vscode/`, `.idea/`)
- OS junk (`.DS_Store`, `Thumbs.db`)
- Build/export output (`builds/`, `exports/`, `export_presets.cfg`)

If you add a new binary file type that should be in LFS, edit `.gitattributes`, commit it, then re-add the file so it gets stored via LFS.

---

## 7. Troubleshooting

**`git push` says "Permission denied"**
You're likely authenticating as the wrong GitHub user, or you don't have Write access to the repo. Check:
- `ssh -T git@github.com` (for SSH) — does it greet you with the right username?
- For HTTPS, your cached credentials may be stale. On Windows, open the **Credential Manager** and remove `git:https://github.com`, then `git push` again to be re-prompted.

**A binary file shows up as a tiny text file with `oid sha256:…` content**
That's an LFS pointer file. You forgot `git lfs pull`, or LFS isn't installed. Run:
```bash
git lfs install
git lfs pull
```

**Godot opens to a blank project / errors about missing UIDs**
Delete the local `.godot/` folder and re-open the project — Godot will rebuild its cache.

**Merge conflict in a `.tscn` you don't want to resolve by hand**
Pick one side and re-apply the other change in the editor:
```bash
git checkout --theirs path/to/scene.tscn   # keep the incoming version
# or
git checkout --ours path/to/scene.tscn     # keep your version
git add path/to/scene.tscn
git rebase --continue   # or git commit, depending on what you were doing
```
Then open Godot and manually redo the change you discarded.
