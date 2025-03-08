
# Claude Code Container
# Makefile for building and managing the Claude Code Docker container

# Variables
IMAGE_NAME := claude-code
CONTAINER_NAME := claude-code-instance

# Default target
.PHONY: all
all: build ## Build the Docker image (default target)

# Build the Docker image
.PHONY: build
build: ## Build the Docker image without using cache (ensures fresh npm packages)
	@echo "Building Docker image $(IMAGE_NAME) without cache..."
	docker build --no-cache --pull -t $(IMAGE_NAME) .
	@echo "Build complete."

# Run the container
.PHONY: run
run: ## Run the Docker container with current directory mapped to /app
	@echo "Starting container $(CONTAINER_NAME)..."
	docker run --name $(CONTAINER_NAME) -it --rm -v "$$(pwd):/app" $(IMAGE_NAME)

# Run with a specified directory
.PHONY: run-dir
run-dir: ## Run with a specified directory mapped to /app (usage: make run-dir DIR=/path/to/directory)
	@if [ -z "$(DIR)" ]; then \
		echo "Error: DIR parameter is required. Usage: make run-dir DIR=/path/to/directory"; \
		exit 1; \
	fi
	@echo "Starting container $(CONTAINER_NAME) with $(DIR) mapped to /app..."
	docker run --name $(CONTAINER_NAME) -it --rm -v "$(DIR):/app" $(IMAGE_NAME)

# Clean up resources
.PHONY: clean
clean: ## Remove the Docker image
	@echo "Cleaning up resources..."
	docker rmi $(IMAGE_NAME) || true

# Help command
.PHONY: help
help: ## Display this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'
