SHELL=/usr/bin/env bash
NAME=parking_lot
AUTHOR=tanmayj28
URL=https://github.com/$(AUTHOR)/$(NAME)

.PHONY: setup
setup: install_bundler bundle_install
install_bundler:
	gem install bundler:2.2.31
bundle_install:
	bundle check || bundle install
