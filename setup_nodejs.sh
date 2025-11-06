#!/bin/bash

echo "🚀 Node.js Setup for Neovim Diagnostics"
echo "========================================"
echo ""

# Check if Node.js is already installed
if command -v node &> /dev/null; then
    echo "✅ Node.js is already installed!"
    echo "   Version: $(node --version)"
    echo ""
    exit 0
fi

echo "Node.js is not found in WSL."
echo ""
echo "Please choose an option:"
echo ""
echo "1) Install Node.js using nvm (Recommended)"
echo "   - Cleanest approach"
echo "   - Easy to manage multiple versions"
echo "   - No sudo required"
echo ""
echo "2) Create symlink to Windows Node.js (Quick fix)"
echo "   - Requires sudo"
echo "   - Uses your existing Windows Node.js"
echo "   - Faster but less clean"
echo ""
echo "3) Cancel"
echo ""

read -p "Enter your choice (1/2/3): " choice

case $choice in
    1)
        echo ""
        echo "📦 Installing Node.js via nvm..."
        echo ""

        # Install nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

        # Detect shell
        SHELL_RC="$HOME/.bashrc"
        if [ -n "$ZSH_VERSION" ]; then
            SHELL_RC="$HOME/.zshrc"
        elif [ -f "$HOME/.zshrc" ]; then
            SHELL_RC="$HOME/.zshrc"
        fi

        # Load nvm
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

        # Install Node.js LTS
        echo ""
        echo "📦 Installing Node.js LTS..."
        nvm install --lts

        # Verify
        echo ""
        echo "✅ Node.js installation complete!"
        echo "   Node version: $(node --version)"
        echo "   npm version: $(npm --version)"
        echo ""
        echo "⚠️  IMPORTANT: Please restart your terminal or run:"
        echo "   source $SHELL_RC"
        echo ""
        ;;

    2)
        echo ""
        echo "🔗 Creating symlinks to Windows Node.js..."
        echo ""

        # Check if Windows Node.js exists
        if [ ! -f "/mnt/c/nvm4w/nodejs/node.exe" ]; then
            echo "❌ Windows Node.js not found at /mnt/c/nvm4w/nodejs/node.exe"
            echo "   Please install Node.js on Windows first or choose option 1"
            exit 1
        fi

        # Create symlinks (requires sudo)
        echo "Creating symlinks (requires sudo)..."
        sudo ln -sf /mnt/c/nvm4w/nodejs/node.exe /usr/local/bin/node
        sudo ln -sf /mnt/c/nvm4w/nodejs/npm /usr/local/bin/npm

        # Verify
        if command -v node &> /dev/null; then
            echo ""
            echo "✅ Symlinks created successfully!"
            echo "   Node version: $(node --version)"
            echo "   npm version: $(npm --version)"
            echo ""
        else
            echo ""
            echo "❌ Failed to create symlinks. Please try option 1 instead."
            exit 1
        fi
        ;;

    3)
        echo ""
        echo "Setup cancelled."
        exit 0
        ;;

    *)
        echo ""
        echo "❌ Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo "🎉 Setup complete!"
echo ""
echo "Next steps:"
echo "1. Restart Neovim"
echo "2. Open a TypeScript/JavaScript file"
echo "3. You should now see real-time diagnostics!"
echo ""
echo "To set up AI assistant (Claude/Gemini), see:"
echo "   ~/.config/nvim/SETUP_AI_AND_DIAGNOSTICS.md"
