echo "[Unit]
Description=bar for DWM

[Service]
ExecStart=${HOME}/.local/bin/mybar.sh
Restart=on-failure
SystemCallArchitectures=native

[Install]
WantedBy=default.target"
