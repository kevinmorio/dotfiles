# Dotfiles

## Programs

- Zsh
- Neovim
- GnuPG
- youtube-dl
- Git
- SSH
- starship
- kitty

## Notes

### GnuPG

Due to the permissions imposed by GnuPG on the config files, they have to be copied and not symlinked to `$GNUPGHOME`.
On macOS it seems to be required to create the folder manually using `mkdir -p "$GNUPGHOME"`.
Moreover, the permissions have to be adapted using `chmod 700 "$GNUPGHOME"`.

See [StackOverflow](https://superuser.com/questions/954509/what-are-the-correct-permissions-for-the-gnupg-enclosing-folder-gpg-warning).

### Zsh

The paths used by `compinit` have insecure permissions according to `compaudit`.
They can be fixed by running `compaudit | xargs chmod 755`.

See [StackOverflow](https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories) for more information.
