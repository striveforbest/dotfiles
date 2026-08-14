######
README
######

Personal dotfiles for macOS + zsh.

Layout
======

``.zshrc``
    Shell config. Sourced files, PATH, build flags, oh-my-zsh, powerlevel10k.
``.aliases`` / ``.functions``
    Sourced by ``.zshrc``.
``.gitconfig`` / ``.gitignore_global``
    Git config. Commits and annotated tags are GPG-signed.
``.gnupg/``
    **Config only.** ``gpg.conf`` and ``gpg-agent.conf`` are tracked; everything
    else in that directory is ignored by ``.gitignore`` (deny-all + allow-list).
``.vimrc``
    Vim config (Vundle).

Machine-local settings
======================

Anything containing a personal path, email address, account name or token goes
in ``~/.zshrc.local``, which is git-ignored and sourced last::

    cat > ~/.zshrc.local <<'EOF'
    export SOMETHING=personal
    EOF

Notes
=====

- ``PATH`` deliberately excludes ``.`` and ``$HOME``.
- ``sudo`` is deliberately **not** aliased to ``sudo -E``; use ``sudoe``.
- ``rsync`` is deliberately **not** aliased; macOS ships rsync 2.6.9 which has
  no ``--info`` flag. Use ``rs``.
