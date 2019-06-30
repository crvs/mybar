# MyBar

A simple systembar for DWM using xsetroot and nothing else.

### Dependencies

probably nothing. It only uses coreutils and runs on POSIX compliant shell.

### Installation

> $ make install

Note that the installation is not as root, so it will only affect the current user. It pre-suposes that the paths `$HOME/.local/systemd/user` and `$HOME/.config/bin` exist and will install there the necessary `service` file and the script.

### Configuration

The configuration is rather straight forward. You just change `mybar.sh` until it is outputing what you want on the `xsetroot -name` lines.

The function `bar_redraw` gets run once a period (in the vanilla case, once a minute).

The function `bar_force_redraw` gets run every time the process gets `kill`ed with signal `SIGUSR`

The `PID` of the process is written to `/tmp/barsh_id` and can be retried by other programs to issue the kill signal to force the bar to update with `kill -12 $(PID)`.

### Notes

The only thing that is running is the `mybar.sh` script. This should be copied into your path and invoked in the background to keep updating your status bar **once a minute**.

If you have systemd installed then you can enable clipsync as a user service after having installed it with `make install` by running.

> $ systemctl --user enable mybar.service
>
> $ systemctl --user start mybar.service

**These instructions work on arch linux, I'm not sure how they would port to other distributions**

