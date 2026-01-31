# Avery's Dot Files

A lightweight, modular, and performant ZSH configuration focused on productivity and clear visual feedback without the bloat of frameworks.

## Showcase

<p align="center">
  <br><em>Welcome Screen</em>
  <img width="903" height="484" alt="welcome_screen" src="https://github.com/user-attachments/assets/2263ab06-866a-4ea8-aae9-df6d58072926" />
</p>

<p align="center">
  <br><em>Prompt Overview & Precision Timer</em>
  <img width="1024" alt="prompt_overview" src="https://github.com/user-attachments/assets/196ac55b-fdc1-452c-af61-7f3bb5043d69" />
</p>

<p align="center">
  <br><em>Project Context & Git Info</em>
  <img width="1024" alt="project_context" src="https://github.com/user-attachments/assets/98024a8b-5e8c-4e9b-affb-93b2897c0077" />
</p>

<p align="center">
<br><em>Fuzzy Repo Search (cr)</em>
  <img width="1024" alt="cr_preview" src="https://github.com/user-attachments/assets/a71bda69-7061-487d-b545-3fde9565c689" />
</p>

<p align="center">
  <br><em>Fuzzy History Search (fh)</em>
  <img width="1024" alt="fuzzy_history" src="https://github.com/user-attachments/assets/ea181b78-5f02-4e49-ab84-490b46be2a72" />
</p>

## Overview

This setup provides a highly customized Zsh prompt split into thematic modules. It emphasizes direct control over your shell environment, offering real-time Git status, environment detection, and smart navigation.

## Key Features

### 🚀 Modular Configuration
The configuration is organized into a `zsh/` directory for easy maintenance:
- **[theme.zsh](zsh/theme.zsh)**: Centralized symbols and hand-picked color palette.
- **[git.zsh](zsh/git.zsh)**: Detailed status (staged, dirty, untracked) and ahead/behind tracking.
- **[env.zsh](zsh/env.zsh)**: Smart detection for Node.js, Rust, Python (including VirtualEnvs), Go, and Ruby.
- **[utils.zsh](zsh/utils.zsh)**: Helper functions, path shrinking, and command duration tracking.
- **[nav.zsh](zsh/nav.zsh)**: Fuzzy navigation tools.

### 🔍 Smart Navigation
- **Zoxide Integration**: Uses `z` for jumping to frequent directories based on history.
- **`cr` (CD to Repo)**: Fuzzy search and jump to any repository in `~/repos/` with a live preview.
- **`fh` (Fuzzy History)**: Quickly search and execute commands from your history.

### 📍 Deep Repo Path Navigation
- **Repo-First Layout**: Inside Git repositories, the prompt prioritizes the project name and hides the username for a cleaner workspace.
- **Breadcrumb Depth**: Shows exactly how many levels deep you are from the repo root (e.g., `2 ➜`) using a concise numeric indicator.
- **Leaf-Only Focus**: Suppresses intermediate directory names to keep the focus on the current subfolder.

### 🖱️ Interactive Segments (OSC 8)
- **Clickable Leaf**: Inside repositories, the "Leaf" folder segment is an active hyperlink.
- **Cmd/Ctrl+Click**: Jump directly from your terminal to the current directory in Finder/Explorer using native terminal hyperlink support.
- **Underline Suppression**: Uses special ANSI sequences to maintain a clean, solid look in supported terminal emulators.

## Usage

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/dot-files.git ~/repos/dot-files
   ```

2. **Source the configuration**:
   Add the following line to your `~/.zshrc`:
   ```bash
   source ~/repos/dot-files/.prompt-setup
   ```

3. **Optional Configuration**:
   To hide the one-time welcome and health check message, add this to your `~/.zshrc`:
   ```bash
   export ZSH_PROMPT_SKIP_CHECK=1
   ```

4. **Requirements**:
   - **[Nerd Fonts](https://www.nerdfonts.com/)**: Required for the icons (e.g., JetBrainsMono Nerd Font).
   - **[fzf](https://github.com/junegunn/fzf)**: Required for fuzzy navigation.
   - **[zoxide](https://github.com/ajeetdsouza/zoxide)**: Optional but recommended for the `z` command.

## Utility Aliases

Included in [.aliases](.aliases) are shortcuts for common Git commands:
- `gs`: git status
- `ga`: git add
- `gc`: git commit -m
- `gp`: git push
- ...and more.

---
*Inspired by the M365 Princess theme, rebuilt for speed and modularity.*
