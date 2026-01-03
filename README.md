# 🎨 Claude Code Art Gallery

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude-Code-blueviolet)](https://claude.com/claude-code)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-orange.svg)](CONTRIBUTING.md)
[![GitHub Stars](https://img.shields.io/github/stars/yksanjo/claude-code-art-gallery?style=social)](https://github.com/yksanjo/claude-code-art-gallery)

> Customize your Claude Code startup experience with beautiful ASCII art! A community-driven collection of creative terminal artwork.

## ✨ Features

- 🎭 **16+ Stunning Artworks** - From cyberpunk cities to neural networks
- 🔄 **Easy Switching** - Change artwork anytime with one command
- 🚀 **Simple Installation** - One script, instant setup
- 🎨 **Community Driven** - Submit your own creations!
- 🔧 **Non-invasive** - Works with Claude Code's SessionStart hooks
- 💾 **Backup Safety** - Automatically backs up your existing settings

## 🖼️ Gallery Preview

### Neon Wave
```
╔═══════════════════════════════════════════════════════════════╗
║  ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗           ║
║  ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗          ║
║            ～～～  Neon Wave Edition  ～～～                  ║
╚═══════════════════════════════════════════════════════════════╝
```

### ASCII Robot
```
    ╔═══════════════════════════════════════════╗
    ║         ___                               ║
    ║        /   \                              ║
    ║       | O O |    Claude Code              ║
    ║       |  ^  |    Ready to build!          ║
    ║    "Beep boop, let's code!"               ║
    ╚═══════════════════════════════════════════╝
```

### Minimalist
```
    ┌─────────────────────────────────────┐
    │   claude code                       │
    │   > ready                           │
    │   > focused                         │
    │   > building                        │
    └─────────────────────────────────────┘
```

**[View all 16 artworks →](artwork/)**

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/yksanjo/claude-code-art-gallery.git
cd claude-code-art-gallery

# Make scripts executable
chmod +x install.sh switch-art.sh

# Install an artwork (interactive mode)
./install.sh

# Or install directly by name
./install.sh neon-wave
```

### Usage

```bash
# Switch to a different artwork
./switch-art.sh

# Preview before installing
./switch-art.sh
# Then type 'p' when prompted

# Install specific artwork
./switch-art.sh
# Then enter artwork name or number
```

## 📦 Available Artworks

### 🔥 Premium Collection

| Name | Style | Description |
|------|-------|-------------|
| `cyberpunk-city` | Futuristic | Neon cityscape with towering buildings |
| `synthwave-sunset` | Retro | 80s retrowave with gradient sunset |
| `rocket-launch` | Dynamic | Rocket ship launching into space |
| `neural-network` | AI | Neural network visualization |
| `code-wave` | Creative | Animated code wave pattern |
| `circuit-board` | Tech | Electronic circuit board design |
| `galaxy-explorer` | Cosmic | Spaceship exploring the galaxy |
| `hacker-terminal` | Elite | Professional hacker terminal UI |
| `geometric-pattern` | Modern | Clean geometric shapes |
| `developer-desk` | Realistic | Developer workspace scene |

### 🎨 Classic Collection

| Name | Style | Description |
|------|-------|-------------|
| `neon-wave` | Bold | Vibrant neon-style box drawing |
| `ascii-robot` | Fun | Friendly robot companion |
| `minimalist` | Clean | Simple, distraction-free |
| `retro-computer` | Nostalgic | Classic terminal vibes |
| `cosmic` | Ethereal | Space-themed with stars |
| `matrix` | Tech | Binary code matrix style |

## 🛠️ How It Works

Claude Code Art Gallery uses Claude Code's built-in **SessionStart hooks** to display custom ASCII art when you launch Claude Code.

The installation script:
1. Copies your chosen artwork to `~/.claude/custom-art.txt`
2. Configures a SessionStart hook in `~/.claude/settings.json`
3. Backs up your existing settings automatically

**Your `.claude/settings.json` will include:**
```json
{
  "hooks": {
    "SessionStart": [
      {
        "type": "command",
        "command": "cat ~/.claude/custom-art.txt"
      }
    ]
  }
}
```

## 🎨 Contributing

We **love** community contributions! Share your ASCII art with the world!

### Quick Contribution

1. Fork this repository
2. Create your artwork in `artwork/community-submissions/your-name-theme.txt`
3. Submit a pull request
4. See your art in the gallery!

**Read our [Contributing Guide](CONTRIBUTING.md) for detailed instructions.**

### Contribution Ideas

- 🌈 Colorful ANSI art
- 🤖 AI/ML themed designs
- 🎮 Gaming references
- 🌌 Space/sci-fi themes
- ⚡ Minimalist designs
- 🎭 Seasonal/holiday art

## 📖 Documentation

### Requirements

- Claude Code CLI installed
- Bash shell (macOS, Linux, WSL on Windows)
- `~/.claude/` directory (created automatically if missing)

### Uninstallation

To remove custom artwork and restore defaults:

```bash
# Remove custom artwork
rm ~/.claude/custom-art.txt

# Restore backup settings (if you want to remove the hook)
cp ~/.claude/settings.json.backup ~/.claude/settings.json

# Or manually edit ~/.claude/settings.json to remove the SessionStart hook
```

### Troubleshooting

**Artwork not showing?**
- Ensure Claude Code is restarted after installation
- Check that `~/.claude/custom-art.txt` exists
- Verify `~/.claude/settings.json` contains the SessionStart hook

**Installation script fails?**
- Make sure scripts are executable: `chmod +x *.sh`
- Check that you're in the `claude-code-art-gallery` directory

**Want to reset everything?**
```bash
rm ~/.claude/custom-art.txt
cp ~/.claude/settings.json.backup ~/.claude/settings.json
```

## 🌟 Community Showcase

Have you created something amazing? [Submit your artwork](CONTRIBUTING.md) and get featured here!

*Coming soon: Community submissions will be showcased in this section!*

## 📜 License

MIT License - feel free to use, modify, and share!

## 🙏 Acknowledgments

- Built for [Claude Code](https://claude.com/claude-code) by Anthropic
- Inspired by the amazing ASCII art community
- Thanks to all contributors who share their creativity!

## 🔗 Links

- [Claude Code Documentation](https://code.claude.com/docs)
- [Report an Issue](https://github.com/yksanjo/claude-code-art-gallery/issues)
- [Submit Artwork](https://github.com/yksanjo/claude-code-art-gallery/pulls)
- [Discussions](https://github.com/yksanjo/claude-code-art-gallery/discussions)

## 📊 Stats

![GitHub repo size](https://img.shields.io/github/repo-size/yksanjo/claude-code-art-gallery)
![GitHub contributors](https://img.shields.io/github/contributors/yksanjo/claude-code-art-gallery)
![GitHub last commit](https://img.shields.io/github/last-commit/yksanjo/claude-code-art-gallery)
![GitHub issues](https://img.shields.io/github/issues/yksanjo/claude-code-art-gallery)

---

<div align="center">

**Made with ❤️ by the Claude Code community**

[⭐ Star this repo](https://github.com/yksanjo/claude-code-art-gallery) • [🐛 Report Bug](https://github.com/yksanjo/claude-code-art-gallery/issues) • [✨ Request Feature](https://github.com/yksanjo/claude-code-art-gallery/issues)

</div>
