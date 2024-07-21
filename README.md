# My Neovim Config

I made this following a YouTube series, and I like it so far.

Probably the main highlights are:

- Modular config built around lazy.nvim
- Telescope for finding things (and for code actions)
- neo-tree for navigating
- tree-sitter highlighting
- gitsigns with inline blame
- Full LSP setup with completions through Mason (and a variety of languages auto-installed)
- null-ls (really none-ls, the fork) setup for formatting/linting as lsp (and some auto-installed through Mason)
- Debugging setup with nvim-dap (only gdb is set up)

I didn't set up any completions besides lsp because it seemed like kind of a mess tbh. I might still do it tho.

## External requirements

The language servers and such may rely on fairly arbitrary external dependencies entirely based on which language was used to write the language server (which need not have any relation to the language it provides).

On Fedora it's pretty straightforward, you just need:

```
dnf install -y git python golang lua luarocks lua5.1 tar curl nodejs neovim cargo ripgrep fd-find
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit -y
```

RHEL/Rocky Linux is a bit more complicated, mostly because Epel has a Neovim version that is too old. The full script to get it up-and running on a bare Rocky Linux 9 install is:

```
dnf install -y epel-release
dnf install -y git python golang lua luarocks lua5.1 tar curl nodejs cargo ripgrep fd-find

curl -LO https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz
tar -xzvf nvim-linux64.tar.gz -C .local/ --strip-components=1

sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit -y
```
