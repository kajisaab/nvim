#!/bin/bash

echo "🔧 Fixing wilder.nvim by updating remote plugins..."
echo ""

# Run UpdateRemotePlugins in headless mode
nvim --headless -c 'UpdateRemotePlugins' -c 'quit' 2>&1

# Check if rplugin.vim was created
if [ -f ~/.local/share/nvim/rplugin.vim ]; then
    echo "✅ Success! Remote plugins have been registered."
    echo ""
    echo "📝 Checking if wilder is registered..."
    if grep -q "wilder" ~/.local/share/nvim/rplugin.vim; then
        echo "✅ wilder.nvim is now registered!"
    else
        echo "⚠️  Warning: wilder not found in manifest. There might be an issue."
    fi
else
    echo "❌ Failed to create rplugin.vim manifest."
    echo "This might indicate an issue with the Python provider."
fi

echo ""
echo "🚀 Please restart Neovim and test search with '/' to verify the fix."
echo ""
echo "If the issue persists, you may need to update pynvim:"
echo "   sudo python3 -m pip install --upgrade pynvim"
