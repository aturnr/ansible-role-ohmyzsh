ansible-role-ohmyzsh
====================

[![Build Status](https://travis-ci.com/lineguy/ansible-role-ohmyzsh.svg?branch=master)](https://travis-ci.com/lineguy/ansible-role-ohmyzsh)
[![Build Status](https://img.shields.io/badge/Version-1.0.0-green)](https://github.com/lineguy/ansible-role-ohmyzsh/releases/tag/1.0.0)

A ansible role to install and configure oh-my-zsh.

Requirements
------------

* Ansible >= 2.10
* Ubuntu 20.04

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Here is a list of all the variables for this role. The variables which are not commented are the defaults that are set in `defaults/main.yml`.

```yaml
# This role takes advantage of oh-my-zsh's default configuration and naming scheme.
# @see templates/zshrc.j2
#
# Please see example configuration below:
---
ohmyzsh_default_install: true

ohmyzsh_default_theme: robbyrussell
ohmyzsh_default_theme_random_candidates:
  - agnoster
  - robbyrussell
ohmyzsh_default_case_sensitive: false
ohmyzsh_default_hyphen_insensitive: false
ohmyzsh_default_disable_auto_update: false
ohmyzsh_default_disable_update_prompt: false
ohmyzsh_default_update_zsh_days: 13
ohmyzsh_default_disable_magic_functions: false
ohmyzsh_default_disable_ls_colors: false
ohmyzsh_default_disable_auto_title: false
ohmyzsh_default_enable_correction: false
ohmyzsh_default_completion_waiting_dots: false
ohmyzsh_default_disable_untracked_files_dirty: false
ohmyzsh_default_history_stamps: mm/dd/yyyy
ohmyzsh_default_zsh_custom: $ZSH/custom
ohmyzsh_default_plugins:
  - git
ohmyzsh_default_user_configuration: |
  # export MANPATH="/usr/local/man:$MANPATH"

  # You may need to manually set your language environment
  # export LANG=en_US.UTF-8

  # Preferred editor for local and remote sessions
  # if [[ -n $SSH_CONNECTION ]]; then
  #   export EDITOR='vim'
  # else
  #   export EDITOR='mvim'
  # fi

  # Compilation flags
  # export ARCHFLAGS="-arch x86_64"

  # Set personal aliases, overriding those provided by oh-my-zsh libs,
  # plugins, and themes. Aliases can be placed here, though oh-my-zsh
  # users are encouraged to define aliases within the ZSH_CUSTOM folder.
  # For a full list of active aliases, run `alias`.
  #
  # Example aliases
  # alias zshconfig="mate ~/.zshrc"
  # alias ohmyzsh="mate ~/.oh-my-zsh"

#ohmyzsh_default_custom_plugins:
#  - name: zsh-syntax-highlighting
#    repo: https://github.com/zsh-users/zsh-syntax-highlighting.git
#    update: no
#    version: master

#ohmyzsh_default_custom_themes:
#  - name: powerlevel9k
#    repo: https://github.com/bhilburn/powerlevel9k.git
#    update: no
#    version: master

#ohmyzsh_users:
#  - username: user1
#    oh_my_zsh:
#      install: true
#      theme: cordial
#      theme_random_candidates:
#        - agnoster
#        - robbyrussell
#        - simple
#        - sunrise
#      plugins:
#        - docker
#        - ansible
#        - git
#        - zsh-syntax-highlighting
#        - zsh-completions
#      custom_plugins:
#        - name: zsh-syntax-highlighting
#          repo: https://github.com/zsh-users/zsh-syntax-highlighting.git
#          update: false
#          version: master
#        - name: zsh-completions
#          repo: https://github.com/zsh-users/zsh-completions
#          update: true
#          version: master
#      custom_themes:
#        - name: powerlevel9k
#          repo: https://github.com/bhilburn/powerlevel9k.git
#          update: false
#          version: master
#        - name: cordial
#          repo: https://github.com/stevelacy/cordial-zsh-theme
#          update: false
#          version: master
#      case_sensitive: true
#      hyphen_insensitive: true
#      disable_auto_update: true
#      disable_update_prompt: true
#      update_zsh_days: 30
#      disable_magic_functions: true
#      disable_ls_colors: true
#      disable_auto_title: true
#      enable_correction: true
#      completion_waiting_dots: true
#      disable_untracked_files_dirty: true
#      history_stamps: yyyy/mm/dd
#      zsh_custom: $ZSH/custom
#      user_configuration: |
#          # Example aliases
#          alias zshconfig="vim ~/.zshrc"
#          alias ohmyzsh="vim ~/.oh-my-zsh"
```

Dependencies
------------

None.

Example Playbook
----------------

This is an example playbook of using this role:

```yaml
- hosts: all
  roles:
    - ansible-role-ohmyzsh
  vars:
    ohmyzsh_users:
      - username: user1
        oh_my_zsh:
          install: true
          theme: cordial
          theme_random_candidates:
            - agnoster
            - robbyrussell
          plugins:
            - ansible
            - git
            - zsh-syntax-highlighting
            - zsh-completions
          custom_plugins:
            - name: zsh-syntax-highlighting
              repo: https://github.com/zsh-users/zsh-syntax-highlighting.git
              update: false
              version: master
            - name: zsh-completions
              repo: https://github.com/zsh-users/zsh-completions
              update: true
              version: master
          custom_themes:
            - name: powerlevel9k
              repo: https://github.com/bhilburn/powerlevel9k.git
              update: false
              version: master
            - name: cordial
              repo: https://github.com/stevelacy/cordial-zsh-theme
              update: false
              version: master
          case_sensitive: false
          hyphen_insensitive: false
          disable_auto_update: false
          disable_update_prompt: false
          update_zsh_days: 7
          disable_magic_functions: false
          disable_ls_colors: false
          disable_auto_title: false
          enable_correction: false
          completion_waiting_dots: false
          disable_untracked_files_dirty: false
          history_stamps: dd/mm/yyyy
          zsh_custom: $ZSH/custom
          user_configuration: |
              # Example aliases
              alias zshconfig="vim ~/.zshrc"
              alias ohmyzsh="vim ~/.oh-my-zsh"
```

Development & Testing
---------------------

Automated testing is performed by [TravisCI](https://www.travis-ci.com/) using [molecule](http://molecule.readthedocs.io/) framework.

To develop and test locally, you will need the following:

* \*nix Based Machine (Ubuntu, MacOS etc...)
* [Python](https://www.python.org/) (also python-pip)
* [Ansible](https://www.ansible.com/)
* [Molecule](http://molecule.readthedocs.io/)
* [Docker](https://www.docker.com/)

Installing Ansible, Molecule and dependancies:

```bash
pip install -r requirements.txt
```

Building and testing locally:

```bash
molecule converge             # Build hosts using docker
molecule login --host $host   # Logs into host
```

```bash
molecule test                 # Runs all tests, linting etc...
```

License
-------

MIT

Author Information
------------------

This role was created in 2021 by [Aaron Turner](https://github.com/lineguy).

