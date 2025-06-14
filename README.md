## run on windows
1. pull
docker pull ghcr.io/zeeno-atl/claude-code:latest

2、run and save claude login token after logged.
docker run -it --rm -v"$(pwd):/app" -v"D:/home/.claude:/root/.claude" claude_code:latest

3、mapping docker command to calude, using powershell script
```
notepad $PROFILE
```
add
```
function claude {
    $hostPath = (Get-Location).Path -replace '\\','/'
    docker run --rm -it `
        -v "$hostPath:/app" `
        -v "D:/home/.claude:/root/.claude" `
        claude_code:latest $Args
}
```
powershell run
```
claude
```


-------------------------------------------------------
# 🤖 Claude Code CLI Container (Unofficial) - fork

An unofficial containerized version of the Claude Code CLI, allowing you to interact with Claude's powerful AI assistance for coding tasks in any project. This is not an official Anthropic product. All the code is written by the Claude-code.

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker)](https://www.docker.com/)
[![Docker Image](https://github.com/Zeeno-atl/claude-code/actions/workflows/docker-build.yml/badge.svg)](https://github.com/Zeeno-atl/claude-code/actions/workflows/docker-build.yml)

## 🌟 Features

- **Ready-to-use Claude Code CLI** - No local installation required
- **Works on any platform** with Docker installed
- **Project isolation** - Access your code without installing globally
- **Simple commands** through the Makefile interface
- **Extensible architecture** with initialization scripts
- **Secure container** with proper health checks
- **Correct file permissions** - Container runs as your user ID
- **Performance optimized** - Uses npm cache volume for faster startups
- **Authentication support** - Easy API key configuration
- **Network resilience** - Automatic retries on installation failures

## 📋 Requirements

- Docker installed on your system
- A project directory you want to analyze with Claude

## 🚀 Quick Start

### Using Pre-built Image

```bash
# Pull the pre-built image
docker pull ghcr.io/Zeeno-atl/claude-code:latest

# Run with current directory
docker run -it --rm -v "$(pwd):/app" ghcr.io/Zeeno-atl/claude-code:latest

# Run with API key
docker run -it --rm -v "$(pwd):/app" -e ANTHROPIC_API_KEY="your_api_key" ghcr.io/Zeeno-atl/claude-code:latest
```

### Building Locally

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
# Add Claude Code container alias with npm cache volume and user ID mapping
alias claude='docker run --rm -it -v "$(pwd):/app" -v claude-code-npm-cache:/npm-cache -e CONTAINER_USER_ID=$(id -u) -e CONTAINER_GROUP_ID=$(id -g) claude-code'

# Add API authenticated version
alias claude-auth='docker run --rm -it -v "$(pwd):/app" -v claude-code-npm-cache:/npm-cache -e ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" -e CONTAINER_USER_ID=$(id -u) -e CONTAINER_GROUP_ID=$(id -g) claude-code'
```

With these aliases, you can simply use:

```bash
# Basic usage
claude

# When authentication is needed
claude-auth
```

The container will launch with your current directory mounted, ready to help! It will automatically detect and use your user ID and group ID, ensuring that any files created within the container will be owned by you.

## 🛠️ Available Commands

| Command | Description |
|---------|-------------|
| `make build` | Build the Docker image (clean build) |
| `make quick-build` | Build the Docker image using cache (faster) |
| `make run` | Run Claude in the current directory |
| `make run-dir DIR=/path` | Run Claude in a specific directory |
| `make run-auth KEY=your_api_key` | Run with Anthropic API key |
| `make clean` | Remove the Docker image |
| `make clean-all` | Remove image and cache volumes |
| `make help` | Display help information |

## 🧰 Container Structure

```
/
├── docker-entrypoint.sh            # Main entry point script
├── docker-entrypoint.d/            # Initialization scripts
│   └── 001_setup_claude_env.sh     # Sets up Claude environment
├── claude-wrapper.sh               # Installs Claude Code CLI
├── app/                            # Mount point for your code
└── npm-cache/                      # Persistent npm cache for faster startups
```

## 📦 CI/CD

This repository includes a GitHub Actions workflow that:
- Builds the Docker image on every push and tag
- Publishes it to GitHub Container Registry (ghcr.io)
- Tags the image based on git tags, branches, and commit SHAs
- Provides a `latest` tag for the main branch

To access the image, use:
```bash
docker pull ghcr.io/Zeeno-atl/claude-code:latest
```

## 🌐 Environment Variables

The container supports the following environment variables:

| Variable | Description |
|----------|-------------|
| `ANTHROPIC_API_KEY` | Your Anthropic API key for authentication |
| `CONTAINER_USER_ID` | User ID to run the container as (defaults to /app directory owner) |
| `CONTAINER_GROUP_ID` | Group ID to run the container as (defaults to /app directory group) |
| `CLAUDE_OFFLINE` | Set to any value to use offline pre-cached packages |

## 🔒 Security

The container:
- Uses a Debian slim base image
- Contains only the necessary dependencies (Node.js, npm) with default versions
- Runs initialization scripts with proper error handling
- Includes health checks for container monitoring
- Automatically runs as the host user's UID/GID to prevent permission issues with created files

## 🤝 Contributing

Contributions are welcome! Feel free to submit pull requests or open issues.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Built with ❤️ for developers who love AI assistance.
