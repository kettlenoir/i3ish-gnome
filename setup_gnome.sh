#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Fedora GNOME 画面制御・ショートカット・画面回転 設定スクリプト
# ==============================================================================

echo "================================================================================"
echo " GNOME 画面制御・ショートカット・画面回転の設定を開始します"
echo "================================================================================"

# ------------------------------------------------------------------------------
# 1. 画面回転ツール (gnome-monitor-config) の確認・自動インストール
#    ※ このスクリプトでインストールするパッケージはこれ1つのみです
# ------------------------------------------------------------------------------
if ! command -v gnome-monitor-config >/dev/null 2>&1; then
    echo ">>> 画面回転ツール (gnome-monitor-config) をインストール中..."
    sudo dnf install -y gnome-monitor-config
fi

# ------------------------------------------------------------------------------
# 2. モニター名 & スケールの自動検出 / 対話確認
# ------------------------------------------------------------------------------
DETECTED_MONITOR=""
DETECTED_SCALE=""

if command -v gnome-monitor-config >/dev/null 2>&1; then
    MONITOR_LIST=$(gnome-monitor-config list 2>/dev/null || true)
    # プライマリモニターのコネクタ名（DP-1, eDP-1 等）を抽出
    DETECTED_MONITOR=$(echo "$MONITOR_LIST" | awk '/Logical monitor.*PRIMARY/ {getline; print $1; exit}')
    [ -z "$DETECTED_MONITOR" ] && DETECTED_MONITOR=$(echo "$MONITOR_LIST" | awk '/Monitor \[.*\] ON/ {print $2; exit}')
    
    # 現在のスケール値（1, 1.25, 1.666667, 2 等）を抽出
    DETECTED_SCALE=$(echo "$MONITOR_LIST" | awk -F'scale = ' '/Logical monitor.*PRIMARY/ {split($2, a, "[, ]"); print a[1]; exit}')
fi

MONITOR="${DETECTED_MONITOR:-DP-1}"
SCALE="${DETECTED_SCALE:-1.666667}"

echo "--------------------------------------------------------------------------------"
echo " 画面回転用ディスプレイ情報の確認:"
echo "   ・検出されたモニター名: $MONITOR"
echo "   ・検出されたスケール比: $SCALE"
echo "--------------------------------------------------------------------------------"

# ターミナルで対話実行されている場合は確認プロンプトを表示（Enterで検出値をそのまま採用）
if [ -t 0 ]; then
    read -r -p "モニター名を入力 [Enterで '$MONITOR']: " INPUT_MONITOR
    [ -n "$INPUT_MONITOR" ] && MONITOR="$INPUT_MONITOR"

    read -r -p "スケール比を入力 [Enterで '$SCALE']: " INPUT_SCALE
    [ -n "$INPUT_SCALE" ] && SCALE="$INPUT_SCALE"

    echo ">>> 使用する設定: モニター=[$MONITOR] / スケール=[$SCALE]"
fi

# ------------------------------------------------------------------------------
# 3. ウィンドウ操作・全画面・スクリーンショット
# ------------------------------------------------------------------------------
echo ">>> ウィンドウ操作・全画面・キャプチャショートカットを設定中..."
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"
gsettings set org.gnome.desktop.wm.keybindings unmaximize "['<Alt>F5']"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "['<Alt>Escape', '<Super>Down']"
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Super><Shift>s']"

# ------------------------------------------------------------------------------
# 4. ワークスペース固定化（10画面固定）
# ------------------------------------------------------------------------------
echo ">>> 10画面固定ワークスペースを設定中..."
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

# ドック競合解除（1〜9番目）
for i in $(seq 1 9); do
    gsettings set org.gnome.shell.keybindings "switch-to-application-$i" "[]"
done

# ワークスペース直接切り替え & ウィンドウ移動 (Super + 1〜9, 0)
for i in $(seq 1 9); do
    gsettings set org.gnome.desktop.wm.keybindings "switch-to-workspace-$i" "['<Super>$i']"
    gsettings set org.gnome.desktop.wm.keybindings "move-to-workspace-$i" "['<Super><Shift>$i']"
done
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>0']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Shift>0']"

# ------------------------------------------------------------------------------
# 5. 外観設定 & 入力切替競合解除
# ------------------------------------------------------------------------------
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"

# ------------------------------------------------------------------------------
# 6. カスタムショートカット登録 (WezTerm起動, 画面回転)
# ------------------------------------------------------------------------------
echo ">>> カスタムショートカット（WezTerm起動 / 画面回転）を登録中..."
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
  "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', \
    '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', \
    '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

# custom0: WezTerm 起動 (Super + Return)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Launch WezTerm'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'wezterm'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>Return'

# custom1: 画面縦回転 (Super + Shift + V)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name '画面を縦回転'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "gnome-monitor-config set -LpM $MONITOR -t left -s $SCALE"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding '<Super><Shift>v'

# custom2: 画面横復帰 (Super + Shift + N)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ name '画面を横に戻す'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ command "gnome-monitor-config set -LpM $MONITOR -t normal -s $SCALE"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/ binding '<Super><Shift>n'

echo "================================================================================"
echo " GNOME ショートカット・画面回転の設定が完了しました！"
echo "   ・縦回転ショートカット: Super + Shift + V (モニター: $MONITOR / スケール: $SCALE)"
echo "   ・横復帰ショートカット: Super + Shift + N"
echo "================================================================================"
