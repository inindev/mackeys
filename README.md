# keyguard

Disable or debounce keyboard keys on macOS. Suppress keys entirely or require a long press to activate.

    ./keyguard dnd                     # fully disable the Focus/DND key
    ./keyguard capslock:debounce       # caps lock only activates on 1s hold
    ./keyguard dnd capslock:debounce   # mix both modes

## Build

    make

## Usage

Keys can be specified by name or raw keycode:

    ./keyguard f6 capslock          # disable by name
    ./keyguard 178                  # disable by keycode

### Debounce mode

Append `:debounce` to require a sustained press before a key activates.
Short or accidental taps are silently suppressed.

    ./keyguard capslock:debounce          # default 1000ms
    ./keyguard capslock:debounce=500      # 500ms hold required
    ./keyguard capslock:debounce=2000     # 2s hold required

### Supported key names

`dnd` / `focus`, `capslock`, `escape`, `f1`-`f12` -- or any raw macOS
virtual keycode as a number.

## Finding keycodes

Use the included `snoop-key` utility to identify any key:

    ./snoop-key

Press a key and it prints the keycode. For example, the Do Not Disturb
(half-moon) key on a MacBook shows:

    [KeyDown] keycode=178  flags=0x800100
    [KeyUp] keycode=178  flags=0x800100

Then use the keycode directly:

    ./keyguard 178
    ./keyguard 178:debounce=500

Press Ctrl+C to stop. snoop-key is listen-only and won't affect normal
keyboard operation.

## Install as a login service

Run keyguard automatically at login:

    sudo make install
    cp com.local.keyguard.plist ~/Library/LaunchAgents/
    launchctl load ~/Library/LaunchAgents/com.local.keyguard.plist

Edit the `ProgramArguments` array in the plist to change which keys are
managed, then reload:

    launchctl unload ~/Library/LaunchAgents/com.local.keyguard.plist
    launchctl load ~/Library/LaunchAgents/com.local.keyguard.plist

### Uninstall

    launchctl unload ~/Library/LaunchAgents/com.local.keyguard.plist
    rm ~/Library/LaunchAgents/com.local.keyguard.plist
    sudo rm /usr/local/bin/keyguard

## Accessibility permission

keyguard needs Accessibility access to intercept keyboard events.
macOS will prompt on first run, or add it manually:

**System Settings > Privacy & Security > Accessibility**

Add either the `keyguard` binary or Terminal (if running from terminal).
