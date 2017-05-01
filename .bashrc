# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    PS1='\[\033[0;32m\]\u\[\033[0;37m\]@\[\033[0;32m\]\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

#export TERM=linux

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#setterm -blength 0
xset b off 2>/dev/null

alias valgrind-unity='G_SLICE=always-malloc G_DEBUG=gc-friendly valgrind --tool=memcheck --num-callers=50 --leak-check=full --track-origins=yes --xml=yes --log-file=unity-valgrind.20120409T160245.xml compiz --replace 2>&1 | tee ~/unity-valgrind.20120409T160245.log'

alias valgrind-unity-test='G_SLICE=always-malloc G_DEBUG=gc-friendly valgrind --tool=memcheck --num-callers=50 --leak-check=full --track-origins=yes --xml=yes --xml-file="unity-valgrind.xml" --log-file=unity-valgrind.20120409T160245.xml compiz --replace 2>&1 | tee ~/unity-valgrind.20120409T160245.log'

alias gdb-compiz='gdb --args compiz --replace 2>&1 | tee /home/bschaefer/gdb-compiz-`date +%Y%m%dT%H%M%S`.txt'

alias compiz-reset='LD_LIBRARY_PATH=/home/bschaefer/staging/lib /home/bschaefer/staging/bin/compiz --replace core dbus composite opengl compiztoolbox decor vpswitch snap mousepoll resize place move wall grid regex imgpng session gnomecompat animation fade unitymtgrabhandles workarounds scale expo ezoom unityshell ccp'

alias compiz-reset1='LD_LIBRARY_PATH=/home/bschaefer/staging/lib /home/bschaefer/staging/bin/compiz --replace core dbus composite opengl compiztoolbox decor vpswitch snap mousepoll resize place wall grid regex imgpng session gnomecompat animation fade unitymtgrabhandles workarounds scale expo ezoom unityshell ccp'

alias ag='./autogen.sh --prefix=$PREFIX'

alias dist-upgrade='sudo apt-get update && sudo apt-get dist-upgrade'

alias clang-compile='cmake .. -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++'

alias start-vpn='sudo openvpn --config /etc/openvpn/qalab-vpn.config'

alias cm='cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX'

alias mi='make -j9 install'

alias largest_files="find . -printf '%s %p\n'| sort -nr | head -10"

alias bd="bzr diff --using=meld"

alias tag="~/tag.sh"

alias ..="cd .."

alias rmb="cd ..; rm -rf build; mkdir build; cd build"

m()
{
    g++ --std=c++1z -g3 "$@".cpp -o "$@" -pthread
}

f()
{
  find . -name "*$@*"
}

#g(){
  #grep -Hnri --color=always "$@"
#}

g(){
  if rg --version > /dev/null; then
      rg -j1 -i "$@"
  else
      grep -Hnri --color=always "$@"
  fi
}


f_files()
{
    grep -Hnirl --exclude='*.sw*' "$@" * 
}

vim_files()
{
    vi `grep -Hnirl --exclude='*.sw*' "$@" *`
}

export COMPIZ_CONFIG_PROFILE=ubuntu
export PREFIX=$HOME/staging
export DEBEMAIL="Brandon Schaefer <brandontschaefer@gmail.com>"
export DEBFULLNAME="Brandon Schaefer"
export PATH="/home/bschaefer/.cargo/bin:$PATH"
