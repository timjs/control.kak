# Get in Control!

This is a plugin for the [Kakoune]() text editor.
It aims in simplifying Kakoune scripts.
Kakoune does not have built in capabilities to 
Because Kakoune does not have built in [control statements]().
Users should escape into the shell to use basic control flow, variables, etc.
This ping-ponging between Kakoune editor commands and Bash control flow can be quite tiresome:

```sh
declare-option str colorscheme_mode 'light'
define-command switch-colorscheme \
  -docstring 'switch colorscheme between light and dark modes' %eval{ %sh{
    # We need to use special variables Kakoune created for us
    if [ $kak_opt_colorscheme_mode = light ]
    then
      # We have to `echo` the commands Kakoune has to evaluate back
      echo "colorscheme solarized-dark-termcolors; 
        powerline-theme solarized-dark-termcolors; 
        set-option current colorscheme_mode 'dark'"
    else
      echo "colorscheme solarized-light-termcolors; 
        powerline-theme solarized-light-termcolors; 
        set-option current colorscheme_mode 'light'"
    fi
  }}
```

Using this plugin you can make use of normal `%opt{..}` and `%val{..}` expansions
and usual Kakoune command blocks:

```sh
declare-option str colorscheme_mode 'light'
define-command switch-colorscheme \
  -docstring 'switch colorscheme between light and dark modes' %{
    # Normal usage of %opt{..} and friends!
    # Full power of `test(1)`!
    # Kakoune `%{..}` blocks!
    if "%opt{colorscheme_mode} = light" %{
      colorscheme solarized-dark-termcolors
      powerline-theme solarized-dark-termcolors
      set-option current colorscheme_mode 'dark'
    } %{
      colorscheme solarized-light-termcolors
      powerline-theme solarized-light-termcolors
      set-option current colorscheme_mode 'light'
    }
  }
```

And this is just a simple example...


## Toolbox

* `if <test> <then-cmd> <else-cmd>`: check if `<test>` results in true or false using [`test(1)`](http://man.he.net/?topic=test&section=all) and run `<then-cmd>` or `<else-cmd>` accordingly
* `if-available <executable> <then-cmd> <else-cmd>`: check if `<executable>` exists on the system using [`which(1)`](http://man.he.net/?topic=which&section=all) and run `<then-cmd>` or `<else-cmd>` accordingly
* `case-i <value> <pat-1> <cmd-1> ... <pat-n> <cmd-n>`: match `<value>` against `<pat-i>` and run `<cmd-i>` if the match succeeds
  * These are defined for `i = 2, 3, 4, 5`

More to come...


## Install

```sh
git clone https://github.com/timjs/control.kak.git
cd ~/.config/kak/autoload
ln -s /path/to/control.kak/control.kak .
```

Enjoy!
