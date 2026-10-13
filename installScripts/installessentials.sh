#!/usr/bin/env bash
set -euo pipefail

# apt update ger fel för repon med gamla nycklar, men det ska inte stoppa scriptet
sudo apt update || true

# npm ingår i NodeSource-paketet nodejs, ta inte med Debians npm (krockar)
sudo apt install -y tmux ripgrep fd-find nodejs unzip build-essential xclip

# fd heter fdfind på Debian/Ubuntu
mkdir -p ~/.local/bin
ln -sf "$(command -v fdfind)" ~/.local/bin/fd

# Lägger till en rad i en fil om den inte redan finns
ensure_line() {
    local line="$1"
    local file="$2"
    touch "$file"
    grep -qF -- "$line" "$file" || echo "$line" >> "$file"
}

# --- tmux-config ---
TMUX_CONF=~/.tmux.conf
if [ -f "$TMUX_CONF" ]; then
    cp "$TMUX_CONF" "$TMUX_CONF.bak"
fi

cat > "$TMUX_CONF" <<'EOF'
# --- Terminal och färger ---
set -g default-terminal "tmux-256color"
set -as terminal-features ",xterm-256color:RGB"
set -sg escape-time 50
set -g focus-events on

# --- Allmänt ---
set -g mode-keys vi
set -g set-clipboard on
set -g mouse on
set -g history-limit 50000
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on
set -g repeat-time 600

# --- Dela paneler (behåller aktuell katalog) ---
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"
bind '"' split-window -v -c "#{pane_current_path}"
bind c new-window -c "#{pane_current_path}"

# --- Flytta mellan paneler med vim-tangenter ---
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# --- Ändra storlek med prefix (repeterbart) ---
# Prefix, sedan Shift+H/J/K/L
bind -r H resize-pane -L 2
bind -r J resize-pane -D 2
bind -r K resize-pane -U 2
bind -r L resize-pane -R 2

# Prefix, sedan Shift+piltangenter
bind -r S-Left  resize-pane -L 2
bind -r S-Down  resize-pane -D 2
bind -r S-Up    resize-pane -U 2
bind -r S-Right resize-pane -R 2

# --- Ändra storlek utan prefix: Alt+Shift+H/J/K/L ---
bind -n M-H resize-pane -L 2
bind -n M-J resize-pane -D 2
bind -n M-K resize-pane -U 2
bind -n M-L resize-pane -R 2

# --- Copy mode som i vim ---
bind -T copy-mode-vi v send -X begin-selection
bind -T copy-mode-vi y send -X copy-selection-and-cancel

# Markeringen ligger kvar när du släpper musknappen
unbind -T copy-mode-vi MouseDragEnd1Pane

# --- Ladda om config med Prefix, r ---
bind r source-file ~/.tmux.conf \; display "Config omladdad"
EOF

# --- Shell ---
ensure_line 'export NVIM_LOG_LEVEL=info' ~/.bashrc
ensure_line 'export PATH="$HOME/.local/bin:$PATH"' ~/.bashrc

echo "Klart. Kör 'tmux kill-server' och starta tmux på nytt (eller Prefix, r i en körande session)."
