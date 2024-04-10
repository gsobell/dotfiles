vim.cmd[[colorscheme nord]]

-- LSP Servers
require'lspconfig'.ltex.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.texlab.setup{}
