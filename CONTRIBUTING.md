# Contributing to Setup Scrolls

Thank you for your interest in contributing to the **setup-scrolls** repository! This project thrives on community wisdom and shared knowledge. Whether you're submitting a brand new scroll, improving an existing one, or fixing a bug, your contributions are welcome!

## 🧙‍♂️ How to Contribute

### 1. Fork and Clone

Fork this repository to your own GitHub account and clone it locally:

```bash
git clone https://github.com/YOUR_USERNAME/setup-scrolls.git
cd setup-scrolls
```

### 2. Create a Branch

Create a feature branch for your contribution:

```bash
git checkout -b feature/my-awesome-scroll
```

### 3. Add Your Script

Place your script in the appropriate directory:

- **Docker-related scripts** → `scripts/docker/`
- **Proxmox LXC/VM scripts** → `scripts/proxmox/`
- **Network configuration** → `scripts/network/`
- **Home automation** → `scripts/home-automation/`
- **Utilities and helpers** → `scripts/utils/`

### 4. Script Guidelines

Every scroll should follow these principles:

- **Clear and documented**: Include comments explaining what the script does
- **Header section**: Add a header comment block with:
  - Script name and purpose
  - Author/contributor (optional)
  - Usage instructions
  - Dependencies or prerequisites
- **Error handling**: Check for required tools/permissions before proceeding
- **Idempotent where possible**: Scripts should be safe to run multiple times
- **Portable**: Minimize dependencies on specific distributions when possible

#### Example Header Format

```bash
#!/bin/bash
#
# Script: whisper-piper-setup.sh
# Purpose: Menu-driven installer for Whisper and Piper with GPU or CPU options
# Author: The Wise Man of the Internet
# Usage: ./whisper-piper-setup.sh
# Prerequisites: Docker, docker-compose
#
```

### 5. Test Your Changes

Before submitting:

- Test your script in a clean environment (VM or container recommended)
- Verify it works as documented
- Check for any hardcoded paths or values that should be variables

### 6. Update Documentation

If your script adds new functionality:

- Update the README.md to list your new scroll in the "Example Scrolls" section
- Add any relevant notes or warnings

### 7. Submit a Pull Request

Commit your changes with a clear message:

```bash
git add .
git commit -m "Add whisper-piper-setup.sh Docker installation script"
git push origin feature/my-awesome-scroll
```

Then open a Pull Request on GitHub with:

- A clear title describing what you've added
- A description of what the script does and why it's useful
- Any special instructions for testing or usage

## 📋 Code of Conduct

- Be respectful and constructive in discussions
- Focus on making homelab life easier for everyone
- Share knowledge freely and learn from others
- Have fun! (It's the #1 most important thing)

## 🐛 Reporting Issues

Found a bug or have a suggestion? Open an issue on GitHub with:

- A clear description of the problem or suggestion
- Steps to reproduce (for bugs)
- Your environment details (OS, Docker version, etc.)

## 📜 License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

---

> _"Number 1 most important thing is to have fun. Number 2 is to breathe, because it's hard to have fun if you're not breathing."_  
> — The Wise Man of the Internet
