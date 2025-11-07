# Contributing to setup-scrolls

Thank you for considering contributing to the **setup-scrolls** repository! We welcome scripts, improvements, and documentation that help others automate their homelab and network setups.

## 🧙‍♂️ How to Contribute

### 1. Fork and Clone
Fork this repository and clone it to your local machine:
```bash
git clone https://github.com/YOUR_USERNAME/setup-scrolls.git
cd setup-scrolls
```

### 2. Create a Branch
Create a new branch for your contribution:
```bash
git checkout -b feature/my-awesome-scroll
```

### 3. Add Your Script
Place your script in the appropriate directory:
- `scripts/docker/` - Docker container setup and orchestration
- `scripts/proxmox/` - Proxmox LXC/VM setup scripts
- `scripts/network/` - DNS, DHCP, firewall, VLANs, etc.
- `scripts/home-automation/` - Home Assistant, Piper, Whisper, etc.
- `scripts/utils/` - Miscellaneous utilities and helpers

### 4. Script Guidelines
- **Use descriptive names**: `service-name-setup.sh` is better than `setup.sh`
- **Add comments**: Include a header describing what the script does
- **Make it portable**: Avoid hardcoded paths when possible
- **Test it**: Ensure your script works as expected before submitting
- **Use shellcheck**: Validate your bash scripts with shellcheck if possible

Example script header:
```bash
#!/bin/bash
#
# Script: example-setup.sh
# Description: Sets up Example Service with Docker
# Author: Your Name
# Date: YYYY-MM-DD
#
```

### 5. Documentation
If your script requires specific setup or dependencies, document them:
- Add a comment block at the top of the script
- Or create a README.md in the same directory

### 6. Commit and Push
Commit your changes with a clear message:
```bash
git add .
git commit -m "Add example-setup.sh for Docker"
git push origin feature/my-awesome-scroll
```

### 7. Open a Pull Request
Go to the original repository and open a Pull Request with:
- A clear title
- A description of what your script does
- Any prerequisites or special instructions

## 📜 Code of Conduct
- Be respectful and constructive
- Help others learn and grow
- Have fun and spread the wisdom!

## 🤝 Questions?
Feel free to open an issue if you have questions or need guidance.

> _"Number 1 most important thing is to have fun. Number 2 is to breathe, because it's hard to have fun if you're not breathing."_  
> — The Wise Man of the Internet
