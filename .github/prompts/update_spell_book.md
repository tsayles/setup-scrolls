# Update Spell Book Agent Instructions

## Purpose

This agent prompt is designed to automatically scan the repository for
new, modified, or removed scrolls (shell scripts) and update the
spell_book.md file accordingly.

## Task Overview

Scan through the repository's `scripts/` directory and its
subdirectories to identify all shell scripts (`.sh` files). For each
script found, ensure it is properly documented in the `spell_book.md`
file with:

1. An appropriate emoji that matches the scroll's purpose
2. A clear, 1-2 sentence description extracted from the script's
   header comments
3. The correct bash download-and-run command using the proper path
4. Any relevant features or highlights from the script

## Instructions

### 1. Scan for Scrolls

- Search all subdirectories under `scripts/` for `.sh` files
- Identify the category based on directory name:
  - `scripts/docker/` → Docker Scrolls 🐳
  - `scripts/home-automation/` → Home Automation Scrolls 🏠
  - `scripts/network/` → Network Scrolls 🌐
  - `scripts/proxmox/` → Proxmox Scrolls 🖥️
  - `scripts/utils/` → Utility Scrolls 🛠️

### 2. Extract Script Information

For each script, read the header comment block (typically lines 1-20)
and extract:
- **Script name** (from `# Script:` line)
- **Purpose** (from `# Purpose:` line)
- **Description** (from `# Description:` section)
- **Features** (from `# Features:` section if present)
- **Prerequisites** (from `# Prerequisites:` line)

### 3. Generate Download Command

For each script at path `scripts/<category>/<script-name>.sh`, create
the download command:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tsayles/setup-scrolls/refs/heads/main/scripts/<category>/<script-name>.sh)"
```

### 4. Update spell_book.md

- Maintain the existing structure and style of spell_book.md
- Add new scrolls to the appropriate category section
- Update descriptions for modified scrolls
- Remove entries for deleted scrolls
- Keep placeholder text for empty categories
- Preserve the header, footer, and "How to Use" sections
- Maintain the emoji decorations and formatting style
- **Important:** Always include the security warning in the "How to
  Use These Scrolls" section to remind users to review scripts before
  execution

### 5. Preserve Style Guidelines

- Use 80-column line width for markdown text
- Maintain consistent emoji usage:
  - 🐳 for Docker
  - 🏠 for Home Automation
  - 🌐 for Network
  - 🖥️ for Proxmox
  - 🛠️ for Utilities
  - Choose contextual emojis for individual scripts (🎙️, 🔊, 🎯,
    etc.)
- Keep the mystical/magical theme in descriptions
- Use proper markdown formatting with headers, code blocks, and lists

### 6. Handle Edge Cases

- If a script has no header comments, add it with a generic
  description and note that it needs documentation
- If a script is found but cannot be parsed, include it with a note to
  review manually
- Maintain alphabetical order within each category section
- Ensure all bash commands are properly formatted and escaped

## Example Entry Format

```markdown
### 🎯 Script Display Name

**Script:** `scripts/category/script-name.sh`

**Description:** Brief 1-2 sentence description of what the script
does and why it's useful.

**Download & Run:**
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/tsayles/setup-scrolls/refs/heads/main/scripts/category/script-name.sh)"
```

**Features:**
- 🎯 First key feature
- 🚀 Second key feature
- ✅ Third key feature
```

## Automation Triggers

This agent should be invoked when:
- New `.sh` files are added to the `scripts/` directory
- Existing scripts are modified (especially header comments)
- Scripts are deleted from the repository
- The spell_book.md is out of sync with the actual scripts

## Success Criteria

- All scripts in `scripts/` directory are documented in spell_book.md
- Each entry has accurate information matching the script's header
- Download commands are correct and point to the main branch
- The file maintains its mystical theme and formatting style
- No broken links or incorrect paths
- Empty categories show placeholder text indicating more scrolls are
  coming

## Notes

- Always preserve the repository's whimsical "Wise Man of the Internet"
  tone
- The spell_book.md is a user-facing document, so clarity and
  aesthetics matter
- When in doubt about categorization, default to the directory
  structure
- Maintain backward compatibility with existing scroll entries
