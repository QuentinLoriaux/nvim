# nvim
My personal configuration for neovim

And some bash configs

## Installation

Dependencies for all features :

- install neovim LTS
- Have a Github copilot license
- install fdfind as fd
- install ripgrep
- install tmux
- install nodejs


```
git clone git@github.com:QuentinLoriaux/nvim.git ~/.config
ln -s ~/.config/nvim/tmux.conf ~/.tmux.conf
```

## Plugins

### For comfort
- lazy
- hydra
- which-key
- copilot

### For navigation

- tmux navigation
- harpoon
- telescope

### For development

- treesitter
- treesitter-textobjects
- lspconfig
- dap
- deoplete
- ultisnips
- snippets

### Others
- vimtex

## Bash files

Feel free to copy them to your home or copy some parts

- install xclip for the c command. Example : 
```
c pwd
```
- There are configs for Rust, node (nvm), ocaml, anaconda and TeX Live

