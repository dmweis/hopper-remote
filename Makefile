DEB_BUILD_PATH ?= target/debian/hopper-remote_*.deb


.PHONY: build
build:
	cargo build --release

.PHONY: build-xinput
build-xinput:
	cargo build --release --features xinput --no-default-features

.PHONY: install-xinput
install-xinput:
	cargo install --path . --features xinput --no-default-features

.PHONY: build-deb
build-deb: build
	cargo deb --no-build

.PHONE: install
install: build-deb
	sudo dpkg -i $(DEB_BUILD_PATH)

.PHONY: install-dependencies
install-dependencies:
	sudo apt update && sudo apt install libudev-dev
	cargo install cargo-deb

