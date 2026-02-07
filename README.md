# minetimer
Detects when minecraft is started and stops minecraft when a timer runs out.

## Setup

Create a startup item that runs `minetimer.sh` in the background.

```bash
mkdir -p ~/Library/LaunchAgents
nano ~/Library/LaunchAgents/com.user.minecraft.timer.plist
```
Paste the following (replace YOUR_USERNAME with your actual username):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.minecraft.timer</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>/Users/YOUR_USERNAME/projects/minetimer/minetimer.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/tmp/minetimer.out</string>

    <key>StandardErrorPath</key>
    <string>/tmp/minetimer.err</string>
</dict>
</plist>
```

