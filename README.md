# Installation

Clone to `~/.config/nvim`

```
git clone https://github.com/VictorVolovik/neovim-config.git ~/.config/nvim
```

# Prerequisites

## MacOS

```
brew install neovim ripgrep
```

## Linux (Ubuntu / Debian)

```
sudo apt install neovim ripgrep
```

## Linux (Fedora)

```
sudo dnf install neovim ripgrep
```

## Linux (Arch)

```
sudo pacman -S neovim ripgrep
```

## Fonts

[Nerdfonts](https://www.nerdfonts.com/)

## Language servers (auto-installed via Mason)

- `lua_ls` — Lua
- `ts_ls` — TypeScript / JavaScript / TSX / JSX
- `gopls` — Go
- `rust_analyzer` — Rust (clippy, allFeatures, procMacro)
- `astro` — Astro
- `eslint` — ESLint
- `emmet_language_server` — Emmet
- `tailwindcss` — Tailwind CSS
- `cssls` — CSS
- `html` — HTML
- `jsonls` — JSON (with package.json and tsconfig schemas)

## Formatters & linters (auto-installed via Mason)

- `stylua` — Lua formatter
- `prettier` — JS/TS/JSON/CSS/Markdown formatter
- `sqlfluff` — SQL linter & formatter (postgres dialect)
- `staticcheck` — Go static analysis
- `jsonlint` — JSON linter

SQL keyword completion is provided by the buffer source (no LSP needed).

# Shortcuts

Leader key is `Space`.

## General

| Key                               | Action                                         |
| --------------------------------- | ---------------------------------------------- |
| `Space Space`                     | Clear search highlight                         |
| `j` / `k`                         | Move by visual line                            |
| `Ctrl+h/j/k/l`                    | Navigate between windows                       |
| `ga`                              | Switch to last active buffer                   |
| `PageUp` / `PageDown`             | Previous / next buffer                         |
| `Delete`                          | Close buffer                                   |
| `Space PageUp` / `Space PageDown` | Previous / next tab                            |
| `gcc`                             | Toggle comment on current line                 |
| `gc` (visual)                     | Toggle comment on selection                    |
| `gc{motion}`                      | Comment with motion (e.g., `gcap` = paragraph) |

## File explorer (Neo-tree)

| Key | Action           |
| --- | ---------------- |
| `\` | Toggle file tree |

## Search (Telescope)

| Key       | Action                                   |
| --------- | ---------------------------------------- |
| `Space f` | Find files (hidden, respects .gitignore) |
| `Space F` | Find all files (hidden + ignored)        |
| `Space p` | Recent files (project)                   |
| `Space P` | Recent files (all)                       |
| `Space /` | Live grep                                |
| `Space b` | Open buffers                             |
| `Space g` | Changed files (git status)               |
| `Space d` | Buffer diagnostics                       |
| `Space D` | Workspace diagnostics                    |
| `Space j` | Jumplist                                 |
| `Space m` | Global marks (project)                   |
| `Space M` | All marks                                |
| `Space '` | Resume last picker                       |

## LSP — Goto

| Key  | Action                                       |
| ---- | -------------------------------------------- |
| `gd` | Go to definition (Telescope)                 |
| `gD` | Preview definition (Telescope, no auto-jump) |
| `gy` | Go to type definition (Telescope)            |
| `gI` | Go to implementation (Telescope)             |
| `gr` | Go to references (Telescope)                 |

## LSP — Info

| Key       | Action                                       |
| --------- | -------------------------------------------- |
| `K`       | Hover documentation (nvim default)           |
| `gsh`     | Signature help                               |
| `Ctrl+s`  | Signature help in insert mode (nvim default) |
| `Space s` | Document symbols (Telescope)                 |
| `Space S` | Workspace symbols (Telescope)                |

## LSP — Actions

| Key        | Action        |
| ---------- | ------------- |
| `Space a`  | Code action   |
| `Space r`  | Rename symbol |
| `Space lf` | Format file   |

## Diagnostics

| Key         | Action                                    |
| ----------- | ----------------------------------------- |
| `Space e`   | Show diagnostic float                     |
| `[d` / `]d` | Previous / next diagnostic (nvim default) |

## Navigation (Helix-style)

| Key         | Action                   |
| ----------- | ------------------------ |
| `]g` / `[g` | Next / previous git hunk |
| `]c` / `[c` | Next / previous comment  |

## Git (gitsigns)

| Key        | Action                |
| ---------- | --------------------- |
| `Space hs` | Stage hunk            |
| `Space hr` | Reset hunk            |
| `Space hS` | Stage buffer          |
| `Space hR` | Reset buffer          |
| `Space hp` | Preview hunk          |
| `Space hi` | Preview hunk inline   |
| `Space hb` | Blame line            |
| `Space hd` | Diff this             |
| `Space hD` | Diff this (~)         |
| `Space hq` | Hunks to quickfix     |
| `Space hQ` | All hunks to quickfix |

## Git toggles

| Key        | Action            |
| ---------- | ----------------- |
| `Space tb` | Toggle line blame |
| `Space td` | Toggle deleted    |
| `Space tw` | Toggle word diff  |

## Completion (insert mode)

| Key                 | Action                            |
| ------------------- | --------------------------------- |
| `Ctrl+x`            | Force open completion             |
| `Tab` / `Shift+Tab` | Navigate items / snippet jumps    |
| `Ctrl+j` / `Ctrl+k` | Next / previous item              |
| `Enter`             | Confirm (explicit selection only) |
| `Ctrl+e`            | Dismiss completion                |
| `Up` / `Down`       | Scroll documentation              |

## Auto behaviors

- Format on save for Go (`*.go`), Rust (`*.rs`), TypeScript (`*.ts`, `*.tsx`), Astro (`*.astro`), CSS (`*.css`), Markdown (`*.md`) and Lua (`*.lua`) files
- Web/doc/Lua files (TS, TSX, CSS, Astro, Markdown, Lua) are formatted exclusively via none-ls (Prettier/StyLua) to avoid conflicts with other LSP formatters
- Neo-tree follows current file
- Treesitter highlighting for all supported file types
