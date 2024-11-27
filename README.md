# Dotfiles

Just some of my dot files...

**This is expected to be cloned into `~/.dotfiles`**
Firstly you will want to clone this:

```shell
> git clone https://github.com/maccoda/dotfiles.git ~/.dotfiles
```

Best way to get started is via `bootstrap.sh`

These are managed by [dotbot](https://github.com/anishathalye/dotbot)

Usage:

```shell
> cd ~/.dotfiles
> ./install
```

## Work set up

To differentiate between work and personal laptop these scripts use the
environment variable `MACCODA_ENV` which will be set to `work` for the work
laptop and empty or other for personal.

The best way for setting this up is by using the [universal fish
variables][set]. This simply needs to be run once anywhere in the fish shell to
take effect.

```fish
> set -Ux MACCODA_ENV work
```
[set]: https://fishshell.com/docs/current/cmds/set.html

## Slack

### Gruvbox theme

#24273A,#F8F8FA,#A6DA95,#24273A,#181926,#CAD3F5,#A6DA95,#EE99A0,#24273A,#CAD3F5
