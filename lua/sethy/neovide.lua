-- Neovide-specific configuration
if vim.g.neovide then
  -- Font configuration
  vim.o.guifont = "Monaspace Radon:h14" -- Adjust size (h14) as needed

  -- Neovide-specific settings
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_fullscreen = true

  -- Enable Option/Alt key as Meta on macOS
  vim.g.neovide_input_macos_option_key_is_meta = true
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true
  vim.g.neovide_cursor_vfx_mode = "railgun" -- Options: "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe"

  -- Refresh rate
  vim.g.neovide_refresh_rate = 60

  -- Padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Helper function to change scale
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  -- Keybindings for zooming
  vim.keymap.set("n", "<D-=>", function()
    change_scale_factor(1.1)
  end)
  vim.keymap.set("n", "<D-->", function()
    change_scale_factor(1/1.1)
  end)
end
