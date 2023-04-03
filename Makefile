EMACS_DIR := $(abspath $(CURDIR)/.emacs.d)
VIMRC_FILE := $(abspath $(CURDIR)/.vimrc)
TMUX_CONF_FILE := $(abspath $(CURDIR)/.tmux.conf)

.PHONY: install_emacs install_vimrc install_tmux_conf install_bash_aliases install_bashrc install

install_emacs:
	ln -sf $(EMACS_DIR) $(HOME)/.emacs.d

install_vimrc:
	ln -sf $(VIMRC_FILE) $(HOME)/.vimrc

install_tmux_conf:
	ln -sf $(TMUX_CONF_FILE) $(HOME)/.tmux.conf

install_bash_aliases:
	cat .bash_aliases >> $(HOME)/.bash_aliases

install_bashrc:
	cat .bashrc >> $(HOME)/.bashrc

install: install_emacs install_vimrc install_tmux_conf install_bash_aliases install_bashrc
