# i3ish-gnome

[English](#english) | [日本語](#japanese)

---

<a name="english"></a>
## English

A setup script that brings the keyboard-centric workflow and keybindings of **i3 / Sway** to the GNOME desktop environment.  
Engineered for pivot (display rotation) monitors, allowing seamless, high-speed window and workspace management without touching the mouse.

> [!NOTE]
> **Target Environment**: This project is developed and optimized specifically for **Fedora** (Fedora Workstation / GNOME). While other GNOME-based distributions may work, Fedora is the author's primary target.

### Key Concepts & Features

- **2-Pane Focus Toggling (`Super + ↓`)**:
  Window cycling on the active monitor is unified into a single key: **`Super + ↓`** (or `Alt + Escape`). Tailored for 1-screen 2-window tiled layouts (split view), enabling instant back-and-forth focus toggling between the two windows.
- **10 Fixed Workspaces with Dual-Path Navigation**:
  - **Direct Warp**: Jump immediately to any screen using `Super + 1` through `9`, and `Super + 0` (10th workspace).
  - **Sequential Navigation**: GNOME's native **`Super + PageDown` / `Super + PageUp`** remains fully supported for step-by-step scrolling.
- **Pivot (Screen Rotation) Monitor Ready**:
  Automatically detects connected primary display connector (`DP-1`, `eDP-1`, etc.) and current fractional scale ratio (`100%`, `125%`, `166%`, etc.). Rotate between portrait and landscape in a split second via hotkeys while preserving the exact scale.
- **Fully Self-Contained**:
  Automatically installs only the required CLI display utility (`gnome-monitor-config`). No unwanted applications or heavy dependencies are introduced.

### Quick Start (One-Liner)

Run the following command directly in your terminal:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kettlenoir/i3ish-gnome/main/setup_gnome.sh)
```

*During execution, display details are auto-detected. Simply press **Enter** at the confirmation prompt to apply all configurations instantly.*

### Keybindings Reference

#### 1. Window Management & Focus (Optimized for 2-Pane View)
| Keybinding | Action |
| :--- | :--- |
| **`Super + ↓`** | **Toggle Window Focus** (Instant back-and-forth toggle between 2 windows / cycle-windows) |
| **`Super + Q`** | Close active window (Fast i3-like kill) |
| **`Super + F`** | Toggle Fullscreen (Browser F11 equivalent) |
| **`Super + Return`** | Launch WezTerm |
| **`Super + Shift + S`** | Interactive Screenshot UI (Windows Snipping Tool style) |
| `Alt + Escape` | Toggle Window Focus (Alternative to `Super + ↓`) |

#### 2. Workspace Navigation (10 Fixed Workspaces)
| Keybinding | Action |
| :--- | :--- |
| **`Super + 1 〜 9`** | Switch directly to workspace 1 〜 9 |
| **`Super + 0`** | Switch directly to workspace 10 |
| **`Super + PageDown`** | Next workspace (GNOME native sequential) |
| **`Super + PageUp`** | Previous workspace (GNOME native sequential) |
| **`Super + Shift + 1 〜 9`** | Move active window to workspace 1 〜 9 |
| **`Super + Shift + 0`** | Move active window to workspace 10 |

#### 3. Display Rotation (Pivot Support)
| Keybinding | Action |
| :--- | :--- |
| **`Super + Shift + V`** | **Rotate Portrait** (90° left rotation, preserving current scale) |
| **`Super + Shift + N`** | **Restore Landscape** (Normal orientation, preserving current scale) |

#### Automated GNOME Environment Tuning
- **Static Workspaces**: Configures `dynamic-workspaces false` & `num-workspaces 10` so all 10 screens are permanently available.
- **Eliminate Dock Clashes**: Clears GNOME dock application launching shortcuts (`Super + 1..9`) to prevent workspace switching interference.
- **Dark Theme**: Applies `prefer-dark` globally.
- **Input Method Safety**: Disables GNOME's default input source switcher to prevent shortcut conflicts with IMEs like Fcitx5.

---

<a name="japanese"></a>
## 日本語 (Japanese)

GNOME デスクトップ環境で **i3 / Sway の操作感とキーバインド** を再現するセットアップスクリプトです。  
ピボット（画面回転）モニターに対応し、キーボードから手を離さずに高速かつ直感的に作業できる環境を構築します。

> [!NOTE]
> **対象環境**: 本スクリプトは作者のメイン環境である **Fedora**（Fedora Workstation / GNOME）を前提に設計・最適化されています。

### コンセプトと特徴

- **1画面2ウィンドウ（2ペイン）を想定したフォーカス切り替え**:
  アクティブモニター上のウィンドウ切り替えは **`Win + ↓`**（または `Alt + Escape`）のみに絞り込んでいます。左右や上下の2分割配置において、1つのキーで瞬時にフォーカスを反転・交互切り替えできます。
- **10画面固定ワークスペース ＆ 2系統の移動手段**:
  - **ダイレクト移動**: `Win + 1〜9` および `Win + 0`（10番目）で目的の画面へ一発ワープ。
  - **順送り移動**: GNOME 標準の **`Win + PageUp` / `Win + PageDown`** による前後の画面送りもそのまま併用可能。
- **ピボット（画面回転）モニター完全対応**:
  接続されているモニター（`DP-1`, `eDP-1` 等）とスケール値（100%, 125%, 166% 等）を自動検出し、ショートカットから一瞬で縦画面・横画面を切り替えられます。
- **完全自己完結型**:
  必要なツール（`gnome-monitor-config`）のみを自動導入し、余計なアプリや重い依存関係は一切インストールしません。

### クイックスタート（1行で実行）

端末で以下をそのまま貼り付けて実行します：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/kettlenoir/i3ish-gnome/main/setup_gnome.sh)
```

実行時にモニター情報が自動検出され、確認プロンプトで **Enter キーを押すだけ** で全設定が即時反映されます。

### ショートカットキー一覧

#### 1. ウィンドウ操作・フォーカス（1画面2ウィンドウ想定）
| ショートカットキー | 動作内容 |
| :--- | :--- |
| **`Super + ↓`** | **ウィンドウフォーカス切り替え**（2ウィンドウ間の交互反転 / cycle-windows） |
| **`Super + Q`** | アクティブなウィンドウを閉じる（i3ライクな即時終了） |
| **`Super + F`** | 全画面（フルスクリーン）トグル（ブラウザの F11 相当） |
| **`Super + Return`** | WezTerm 起動 |
| **`Super + Shift + S`** | 範囲指定スクリーンショットUI起動 |
| `Alt + Escape` | ウィンドウフォーカス切り替え（`Super + ↓` の代替） |

#### 2. ワークスペース操作（10画面固定）
| ショートカットキー | 動作内容 |
| :--- | :--- |
| **`Super + 1 〜 9`** | ワークスペース 1 〜 9 へ直接切り替え |
| **`Super + 0`** | ワークスペース 10 へ直接切り替え |
| **`Super + PageDown`** | 次のワークスペースへ順送り（GNOME標準） |
| **`Super + PageUp`** | 前のワークスペースへ順戻し（GNOME標準） |
| **`Super + Shift + 1 〜 9`** | ウィンドウをワークスペース 1 〜 9 へ移動 |
| **`Super + Shift + 0`** | ウィンドウをワークスペース 10 へ移動 |

#### 3. ディスプレイ画面回転（ピボット対応）
| ショートカットキー | 動作内容 |
| :--- | :--- |
| **`Super + Shift + V`** | **画面を縦回転**（左90°回転・現在のスケール比を維持） |
| **`Super + Shift + N`** | **画面を横に戻す**（通常表示・現在のスケール比を維持） |

#### 自動構成される GNOME 環境
- **ワークスペース固定化**: `dynamic-workspaces false` & `num-workspaces 10` により、アプリの有無に関わらず 1〜10 の画面が常時スタンバイ。
- **ドック競合排除**: `Super + 1〜9` がドックのアプリ起動と干渉しないよう完全解除。
- **ダークテーマ適用**: デスクトップ全体を自動的に `prefer-dark` に設定。
- **IME競合防止**: GNOME 側の入力切り替えを無効化し、Fcitx5 等とのショートカット衝突を防止。
