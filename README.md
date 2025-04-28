# Omakub

Turn a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. That's the one-line pitch for Omakub. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Omakub is an opinionated take on what Linux can be at its best.

Watch the introduction video and read more at [omakub.org](https://omakub.org).

## Changes in this fork

- Makes it compatible with Pop OS 24.04 (There is no theming of Cosmic as it happens with Gnome)
- Adds Virtualbox 7.1 optional installation
- Migrates `pinta` install to flatpak
- Migrates `OBS Studio` install to Official PPA
- Adds `JetBrains Toolbox` optional install (in the Dev Editor menu)
- Improves `Cursor` install, by extracting appimage for better compatibility e.g., with mise
- Fix `omakub` script main menu quit behavior
- Adds `Zsh` optional installation with `oh-my-zsh` and `starship` prompt (allows custom .zshrc.local and aliases to be provided)

  Various useful zsh functions are provided (change-extension, envup, fs, cs, g, genpass)

- Adds `replace` python script for replacing strings in multiple files.
- Adds `Keyd` a key remapping daemon optional install, to remap CAPS LOCK to ESC (tap) & CTRL (hold). Can be used for much more.

## Contributing to the documentation

Please help us improve Omakub's documentation on the [basecamp/omakub-site repository](https://github.com/basecamp/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)
