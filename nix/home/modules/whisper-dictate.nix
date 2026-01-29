# Whisper-based speech-to-text dictation
# Script is in ~/bin/whisper-dictate (stowed from dotfiles)
{ pkgs, ... }:
{
  home.packages = [
    pkgs.whisper-cpp # Provides whisper-server, whisper-cli
    pkgs.wl-clipboard # Clipboard access on Wayland
    pkgs.libnotify # notify-send for notifications
    pkgs.sound-theme-freedesktop # Notification sounds
    pkgs.ydotool # Input simulation for auto-paste
    pkgs.kdotool # For detecting focused window on KDE
  ];

  # KDE hotkey to trigger dictation
  programs.plasma.hotkeys.commands.whisper-dictate = {
    name = "Whisper Dictate";
    key = "Meta+Delete";
    command = "/home/luke/bin/whisper-dictate";
  };

  # Whisper server systemd service (with CUDA)
  systemd.user.services.whisper-server =
    let
      modelDir = "%h/.local/share/whisper";
      modelName = "base.en";
      modelFile = "${modelDir}/ggml-${modelName}.bin";
    in
    {
      Unit = {
        Description = "Whisper.cpp speech-to-text server";
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStartPre = "${pkgs.writeShellScript "whisper-download-model" ''
          set -euo pipefail
          MODEL_DIR="$HOME/.local/share/whisper"
          MODEL_FILE="$MODEL_DIR/ggml-${modelName}.bin"

          if [[ ! -f "$MODEL_FILE" ]]; then
            echo "Downloading whisper model ${modelName}..."
            mkdir -p "$MODEL_DIR"
            ${pkgs.whisper-cpp}/bin/whisper-cpp-download-ggml-model ${modelName} "$MODEL_DIR"
          fi
        ''}";
        ExecStart = "${pkgs.whisper-cpp}/bin/whisper-server --model ${modelFile} --host 0.0.0.0 --port 8080";
        Restart = "on-failure";
        RestartSec = 5;
        Environment = [
          "CUDA_VISIBLE_DEVICES=0"
        ];
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };

  # ydotool daemon for input simulation (used by whisper-dictate for auto-paste)
  systemd.user.services.ydotoold = {
    Unit = {
      Description = "ydotool daemon for input simulation";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.ydotool}/bin/ydotoold";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
