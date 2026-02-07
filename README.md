# minetimer
Detects when minecraft is started and stops minecraft when a timer runs out.

## Setup

Create a startup item that runs `minetimer.sh` in the background.

```bash
sudo cp minetimer.sh /usr/local/minetimer.sh
sudo chmod 755 /usr/local/minetimer.sh
sudo chown root:wheel /usr/local/minetimer.sh
```

```bash
sudo nano /Users/restrictedusername/Library/LaunchAgents/com.minecraft.timer.plist
```
Paste the following:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
 "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.minecraft.timer</string>

    <key>ProgramArguments</key>
    <array>
      <string>/bin/bash</string>
      <string>/usr/local/minetimer.sh</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>KeepAlive</key>
    <true/>

    <key>StandardOutPath</key>
    <string>/var/log/minetimer.out</string>

    <key>StandardErrorPath</key>
    <string>/var/log/minetimer.err</string>
  </dict>
</plist>
```

```bash
sudo chown restrictedusername \
  /Users/restrictedusername/Library/LaunchAgents/com.minecraft.timer.plist

sudo -u restrictedusername launchctl unload \
  /Users/restrictedusername/Library/LaunchAgents/com.minecraft.timer.plist

sudo -u restrictedusername launchctl load \
  /Users/restrictedusername/Library/LaunchAgents/com.minecraft.timer.plist
```
