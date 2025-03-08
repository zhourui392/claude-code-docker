# 🤖 Claude Code CLI Container

A containerized version of the Claude Code CLI by Anthropic, allowing you to interact with Claude's powerful AI assistance for coding tasks in any project.

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](https://www.docker.com/)
[![Anthropic](https://img.shields.io/badge/Powered%20by-Claude-9B59B6)](https://www.anthropic.com/)

## 🌟 Features

- **Ready-to-use Claude Code CLI** - No local installation required
- **Works on any platform** with Docker installed
- **Project isolation** - Access your code without installing globally
- **Simple commands** through the Makefile interface
- **Extensible architecture** with initialization scripts
- **Secure container** with proper health checks

## 📋 Requirements

- Docker installed on your system
- A project directory you want to analyze with Claude

## 🚀 Quick Start

1. **Build the container**:
   ```bash
   make build
   ```

2. **Run Claude on your current directory**:
   ```bash
   make run
   ```

3. **Use Claude with a specific project**:
   ```bash
   make run-dir DIR=/path/to/your/project
   ```

## 🔄 Updating Claude

The container **always installs the latest Claude Code CLI version** when it starts, so you're always using the most recent Claude capabilities without rebuilding.

To update the container itself (base image and scripts):

```bash
# Pull the latest changes
git pull

# Rebuild the container from scratch
make build
```

The build process uses `--no-cache` and `--pull` flags to ensure a completely fresh build with the latest base images.

## 💻 Developer Alias (Recommended)

Add this alias to your shell configuration (`.bashrc`, `.zshrc`, etc.) for quick access:

```bash
# Add Claude Code container alias
alias claude='docker run --rm -it -v "$(pwd):/app" claude-code'
```

With this alias, you can simply use:

```bash
claude
```

And the container will launch with your current directory mounted, ready to help!

## 🛠️ Available Commands

| Command | Description |
|---------|-------------|
| `make build` | Build the Docker image |
| `make run` | Run Claude in the current directory |
| `make run-dir DIR=/path` | Run Claude in a specific directory |
| `make clean` | Remove the Docker image |
| `make help` | Display help information |

## 🧰 Container Structure

```
/
├── docker-entrypoint.sh     # Main entry point script
├── docker-entrypoint.d/     # Initialization scripts
│   └── 001_claude_code.sh   # Installs Claude Code CLI
└── app/                     # Mount point for your code
```

## 🔒 Security

The container:
- Uses a Debian slim base image
- Contains only the necessary dependencies (Node.js, npm)
- Runs initialization scripts with proper error handling
- Includes health checks for container monitoring

## 🤝 Contributing

Contributions are welcome! Feel free to submit pull requests or open issues.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Built with ❤️ for developers who love AI assistance.