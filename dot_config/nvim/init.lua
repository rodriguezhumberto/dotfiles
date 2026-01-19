-- nvim/init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--  Environment Detection logic
_G.env_type = "Host"
if vim.fn.filereadable("/.dockerenv") == 1 or vim.fn.isdirectory("/workspaces") == 1 then
    _G.env_type = "Container"
elseif vim.fn.has("mac") == 1 then
    _G.env_type = "macOS"
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("lazy").setup("plugins", {
  ui = {
    
    border = "rounded",
    
  }
})

