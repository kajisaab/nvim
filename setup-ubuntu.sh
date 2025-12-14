#!/bin/bash

set -e

echo "=================================="
echo "Neovim Setup Script for Ubuntu"
echo "=================================="
echo ""

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_success() {
    echo -e "${BLUE}[SUCCESS]${NC} $1"
}

# Function to verify command exists
verify_command() {
    local cmd=$1
    local name=$2
    if command -v "$cmd" &> /dev/null; then
        local version=$("$cmd" --version 2>&1 | head -n 1)
        print_success "$name is installed: $version"
        return 0
    else
        print_error "$name verification failed: command '$cmd' not found"
        return 1
    fi
}

# Function to verify package is installed
verify_package() {
    local package=$1
    if dpkg -l | grep -q "^ii  $package"; then
        print_success "$package is installed"
        return 0
    else
        print_error "$package verification failed"
        return 1
    fi
}

# Function to verify file exists
verify_file() {
    local file=$1
    local name=$2
    if [ -f "$file" ]; then
        print_success "$name exists at $file"
        return 0
    else
        print_error "$name verification failed: $file not found"
        return 1
    fi
}

# Function to verify directory exists
verify_directory() {
    local dir=$1
    local name=$2
    if [ -d "$dir" ]; then
        print_success "$name exists at $dir"
        return 0
    else
        print_error "$name verification failed: $dir not found"
        return 1
    fi
}

# Check if running on Ubuntu/Debian
if ! command -v apt &> /dev/null; then
    print_error "This script requires apt package manager (Ubuntu/Debian)"
    exit 1
fi

print_info "Updating package lists..."
sudo apt update

# ================================
# Install and Setup Zsh
# ================================
install_zsh() {
    print_info "Installing Zsh..."
    sudo apt install -y zsh

    verify_command "zsh" "Zsh" || return 1

    ZSH_PATH=$(which zsh)
    print_info "Zsh path: $ZSH_PATH"

    # Change default shell to zsh
    if [ "$SHELL" != "$ZSH_PATH" ]; then
        print_info "Changing default shell to Zsh..."
        chsh -s "$ZSH_PATH"
        print_info "Default shell changed to Zsh. You'll need to log out and log back in for this to take effect."
    else
        print_info "Zsh is already your default shell."
    fi

    # Install Oh My Zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        print_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        print_info "Oh My Zsh is already installed."
    fi

    verify_directory "$HOME/.oh-my-zsh" "Oh My Zsh"
}

# ================================
# Install Core Dependencies
# ================================
install_core_dependencies() {
    print_info "Installing core dependencies..."
    sudo apt install -y \
        build-essential \
        git \
        curl \
        wget \
        unzip \
        software-properties-common \
        apt-transport-https \
        ca-certificates \
        gnupg \
        lsb-release

    verify_command "git" "Git" || return 1
    verify_command "curl" "curl" || return 1
    verify_command "wget" "wget" || return 1
    verify_command "unzip" "unzip" || return 1
}

# ================================
# Install Development Libraries
# ================================
install_dev_libraries() {
    print_info "Installing common development libraries..."
    sudo apt install -y \
        libssl-dev \
        libffi-dev \
        libreadline-dev \
        zlib1g-dev \
        libbz2-dev \
        libsqlite3-dev \
        libncurses5-dev \
        libgdbm-dev \
        libnss3-dev \
        libxml2-dev \
        libxmlsec1-dev \
        tk-dev \
        liblzma-dev

    verify_package "libssl-dev" || return 1
    verify_package "libffi-dev" || return 1
}

# ================================
# Install Neovim and Dependencies
# ================================
install_neovim() {
    print_info "Installing Neovim dependencies..."
    sudo apt install -y \
        ripgrep \
        fd-find \
        fzf \
        xclip \
        wl-clipboard \
        cmake \
        gettext \
        ninja-build \
        pkg-config \
        libtool \
        libtool-bin \
        autoconf \
        automake \
        g++ \
        unzip

    print_info "Installing Neovim (latest unstable)..."
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install -y neovim

    verify_command "nvim" "Neovim" || return 1
    verify_command "rg" "ripgrep" || return 1
    verify_command "fdfind" "fd-find" || return 1

    # Create symlink for fd
    sudo ln -sf $(which fdfind) /usr/local/bin/fd 2>/dev/null || true
    verify_command "fd" "fd symlink"
}

# ================================
# Install Text Editors
# ================================
install_editors() {
    print_info "Installing Vim and gedit..."
    sudo apt install -y vim gedit
    verify_command "vim" "Vim" || return 1

    print_info "Installing Visual Studio Code..."
    if ! command -v code &> /dev/null; then
        # Remove any conflicting repository configurations
        sudo rm -f /etc/apt/sources.list.d/vscode.list

        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
        echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
        rm -f packages.microsoft.gpg
        sudo apt update
        sudo apt install -y code
    else
        print_info "Visual Studio Code is already installed."
    fi

    verify_command "code" "Visual Studio Code"
}

# ================================
# Install Python
# ================================
install_python() {
    print_info "Installing Python..."
    sudo apt install -y python3 python3-pip python3-venv python3-dev

    verify_command "python3" "Python" || return 1
    verify_command "pip3" "pip" || return 1

    print_info "Installing Python packages for Neovim..."
    pip3 install --user --break-system-packages pynvim debugpy black isort pylint mypy ruff

    # Verify Python packages
    python3 -c "import pynvim" 2>/dev/null && print_success "pynvim is installed" || print_error "pynvim installation failed"
}

# ================================
# Install Node.js and npm
# ================================
install_nodejs() {
    print_info "Installing Node.js and npm..."
    if ! command -v node &> /dev/null; then
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt install -y nodejs
    else
        print_info "Node.js is already installed."
    fi

    verify_command "node" "Node.js" || return 1
    verify_command "npm" "npm" || return 1

    print_info "Installing global npm packages..."
    sudo npm install -g \
        typescript \
        typescript-language-server \
        vscode-langservers-extracted \
        @tailwindcss/language-server \
        emmet-ls \
        prettier \
        eslint \
        bash-language-server \
        dockerfile-language-server-nodejs \
        yaml-language-server \
        tree-sitter-cli

    verify_command "tsc" "TypeScript" || return 1
    verify_command "prettier" "Prettier" || return 1
}

# ================================
# Install Java
# ================================
install_java() {
    print_info "Installing Java (OpenJDK 17)..."
    sudo apt install -y openjdk-17-jdk openjdk-17-jre

    verify_command "java" "Java" || return 1
    verify_command "javac" "Java Compiler" || return 1
}

# ================================
# Install Go
# ================================
install_go() {
    print_info "Installing Go..."
    if ! command -v go &> /dev/null; then
        GO_VERSION="1.21.5"
        wget "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz"
        rm "go${GO_VERSION}.linux-amd64.tar.gz"

        # Add Go to PATH in .zshrc
        if ! grep -q "/usr/local/go/bin" "$HOME/.zshrc" 2>/dev/null; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >> "$HOME/.zshrc"
            echo 'export PATH=$PATH:$HOME/go/bin' >> "$HOME/.zshrc"
        fi
        export PATH=$PATH:/usr/local/go/bin
        export PATH=$PATH:$HOME/go/bin
    else
        print_info "Go is already installed."
    fi

    verify_command "go" "Go" || return 1

    print_info "Installing Go tools for debugging..."
    go install github.com/go-delve/delve/cmd/dlv@latest

    verify_file "$HOME/go/bin/dlv" "Delve debugger"
}

# ================================
# Install Rust
# ================================
install_rust() {
    print_info "Installing Rust..."
    if ! command -v rustc &> /dev/null; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"

        # Add Rust to PATH in .zshrc
        if ! grep -q ".cargo/env" "$HOME/.zshrc" 2>/dev/null; then
            echo 'source "$HOME/.cargo/env"' >> "$HOME/.zshrc"
        fi
    else
        print_info "Rust is already installed."
        source "$HOME/.cargo/env" 2>/dev/null || true
    fi

    verify_command "rustc" "Rust" || return 1
    verify_command "cargo" "Cargo" || return 1

    print_info "Installing Rust components..."
    rustup component add rust-analyzer rustfmt clippy

    verify_command "rustfmt" "rustfmt" || return 1
    verify_command "cargo-clippy" "clippy" || return 1
}

# ================================
# Install C/C++ Tools
# ================================
install_cpp_tools() {
    print_info "Installing C/C++ development tools..."
    sudo apt install -y gcc g++ clang clangd clang-format cppcheck cmake gdb

    verify_command "gcc" "GCC" || return 1
    verify_command "g++" "G++" || return 1
    verify_command "clang" "Clang" || return 1
    verify_command "clangd" "clangd LSP" || return 1
    verify_command "cmake" "CMake" || return 1
}

# ================================
# Install PostgreSQL 16
# ================================
install_postgresql() {
    print_info "Installing PostgreSQL 16..."
    sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    sudo apt update
    sudo apt install -y postgresql-16 postgresql-contrib-16 libpq-dev

    verify_command "psql" "PostgreSQL" || return 1

    # Start PostgreSQL service
    sudo systemctl start postgresql
    sudo systemctl enable postgresql

    # Verify service is running
    if systemctl is-active --quiet postgresql; then
        print_success "PostgreSQL service is running"
    else
        print_error "PostgreSQL service is not running"
        return 1
    fi

    # Create PostgreSQL role
    print_info "Creating PostgreSQL role 'aman' with password 'hello'..."
    sudo -u postgres psql -c "CREATE ROLE aman WITH LOGIN PASSWORD 'hello' CREATEDB CREATEROLE;" 2>/dev/null || print_warn "Role 'aman' may already exist"
}

# ================================
# Install AWS CLI
# ================================
install_aws_cli() {
    print_info "Installing AWS CLI..."
    if ! command -v aws &> /dev/null; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        rm -rf aws awscliv2.zip
    else
        print_info "AWS CLI is already installed."
    fi

    verify_command "aws" "AWS CLI"
}

# ================================
# Install AWS SAM CLI
# ================================
install_aws_sam() {
    print_info "Installing AWS SAM CLI..."
    if ! command -v sam &> /dev/null; then
        wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
        unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
        sudo ./sam-installation/install
        rm -rf sam-installation aws-sam-cli-linux-x86_64.zip
    else
        print_info "AWS SAM CLI is already installed."
    fi

    verify_command "sam" "AWS SAM CLI"
}

# ================================
# Install Additional CLI Tools
# ================================
install_cli_tools() {
    print_info "Installing bat (better cat)..."
    sudo apt install -y bat
    sudo ln -sf $(which batcat) /usr/local/bin/bat 2>/dev/null || true
    verify_command "bat" "bat" || return 1

    print_info "Installing lazygit..."
    if ! command -v lazygit &> /dev/null; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit lazygit.tar.gz
    else
        print_info "lazygit is already installed."
    fi
    verify_command "lazygit" "lazygit"
}

# ================================
# Install Image Support
# ================================
install_image_support() {
    print_info "Installing image support dependencies..."
    sudo apt install -y imagemagick libmagickwand-dev luarocks

    verify_command "convert" "ImageMagick" || return 1
    verify_command "luarocks" "LuaRocks" || return 1

    print_info "Installing magick luarock and luacheck..."
    sudo luarocks install magick
    sudo luarocks install luacheck

    verify_command "luacheck" "luacheck"
}

# ================================
# Install Nerd Fonts
# ================================
install_nerd_fonts() {
    print_info "Installing Nerd Fonts..."
    FONT_DIR="$HOME/.local/share/fonts"
    mkdir -p "$FONT_DIR"

    if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
        print_info "Downloading JetBrains Mono Nerd Font..."
        wget -O /tmp/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
        unzip -o /tmp/JetBrainsMono.zip -d "$FONT_DIR"
        rm /tmp/JetBrainsMono.zip
        fc-cache -fv
    else
        print_info "JetBrains Mono Nerd Font is already installed."
    fi

    verify_file "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" "JetBrains Mono Nerd Font"
}

# ================================
# Main Installation Flow
# ================================
main() {
    print_info "Starting installation process..."
    echo ""

    install_zsh
    echo ""

    install_core_dependencies
    echo ""

    install_dev_libraries
    echo ""

    install_neovim
    echo ""

    install_editors
    echo ""

    install_python
    echo ""

    install_nodejs
    echo ""

    install_java
    echo ""

    install_go
    echo ""

    install_rust
    echo ""

    install_cpp_tools
    echo ""

    install_postgresql
    echo ""

    install_aws_cli
    echo ""

    install_aws_sam
    echo ""

    install_cli_tools
    echo ""

    install_image_support
    echo ""

    install_nerd_fonts
    echo ""

    # ================================
    # Final Summary
    # ================================
    print_info "=================================="
    print_info "Installation Complete!"
    print_info "=================================="
    print_info ""
    print_info "Installed versions:"
    echo ""
    verify_command "nvim" "Neovim"
    verify_command "node" "Node.js"
    verify_command "python3" "Python"
    verify_command "go" "Go"
    verify_command "rustc" "Rust"
    verify_command "java" "Java"
    verify_command "gcc" "GCC"
    verify_command "clang" "Clang"
    verify_command "psql" "PostgreSQL"
    verify_command "aws" "AWS CLI"
    verify_command "sam" "AWS SAM CLI"
    echo ""
    print_info "Next steps:"
    print_info "1. Log out and log back in for Zsh to become your default shell"
    print_info "2. Copy your Neovim configuration to ~/.config/nvim (if not already there)"
    print_info "3. Set your terminal font to 'JetBrainsMono Nerd Font'"
    print_info "4. Open Neovim and run :Lazy sync to install plugins"
    print_info "5. Run :Mason to verify LSP servers are installed"
    print_info ""
    print_warn "Note: You may need to restart your terminal or run 'source ~/.zshrc' for PATH changes to take effect"
}

# Run main installation
main
