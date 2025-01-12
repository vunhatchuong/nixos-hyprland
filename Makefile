.PHONY: wsl
wsl:
	sudo nix run .#nixosConfigurations.wsl.config.system.build.tarballBuilder
