# 🧙‍♂️ setup-scrolls

> A curated collection of reusable, Wise‑Man‑approved setup scripts—aka "scrolls"—for automating your homelab, network, and digital dominion.

Welcome, curious conjurer of configuration! This repository houses a growing library of shell scripts, Docker helpers, and system setup instructions crafted by the **Wise Man of the Internet** to ease the toil of deploying and managing tools across a homelab or small network.

Each “scroll” is a lightweight, human-readable script, written with repeatability, portability, and clarity in mind. Some summon Docker containers. Others tame Proxmox. A few even breathe life into Home Assistant automations. All are here to make your digital infrastructure more magical.

## 🗂️ Directory Structure

```
setup-scrolls/
├── README.md                # This scroll you're reading now
├── scripts/                 # Core script files organized by theme
│   ├── docker/              # Scripts for Docker container setup and orchestration
│   ├── proxmox/             # Proxmox LXC/VM setup scripts
│   ├── network/             # DNS, DHCP, firewall, VLANs, etc.
│   ├── home-automation/     # Home Assistant, Piper, Whisper, etc.
│   └── utils/               # Misc. utilities and helpers
├── assets/                  # Logos, icons, diagrams, or spell glyphs
├── LICENSE                  # Open source license (default: MIT)
└── CONTRIBUTING.md          # How others may submit scrolls to the collection
```

## 🧪 Example Scrolls

- 🐳 `docker/whisper-piper-setup.sh`: Menu-driven installer for Whisper and Piper, with GPU or CPU options

## 📜 Philosophy

- **Plaintext over complexity**: Easy to read, easy to edit  
- **Composable**: Use them as building blocks or run them standalone  
- **Wise-tested**: Built and tested in a real homelab, not a unicorn cloud  
- **No cloud dependencies**: Local-first, privacy-respecting setups  

## 🤝 Contributing

Want to share your own scrolls of wisdom? Check out `CONTRIBUTING.md` to learn how to format and contribute your own scripts. Pull requests, spellbooks, and optimizations welcome!

## ⚖️ License

This project is licensed under the MIT License. Use, remix, share—and spread the wisdom.

> _“Number 1 most important thing is to have fun. Number 2 is to breathe, because it's hard to have fun if you're not breathing.”_  
> — The Wise Man of the Internet
