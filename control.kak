# Tips:
# - Be aware of comments inside strings in Kakoune's language!
#   Because Kakoune does string expansion, comments can get a bit weird...


# if-then-else
# ------------

define-command if \
  -docstring "if <test> <then-cmd> <else-cmd>: check if <test> results in true (0) or false (1) using `test` and run <then-cmd> or <else-cmd> accordingly" \
  -params 3 %{eval %sh{
    if [ $1 ]
    then
      # Note we need quotes here to make sure the newlines are not swallowed
      echo "$2" | tr "\n" ";"
    else
      echo "$3" | tr "\n" ";"
    fi
  }}

define-command if-available \
  -docstring "if-available <executable> <then-cmd> <else-cmd>: check if <executable> exists on the system using `which` and run <then-cmd> or <else-cmd> accordingly" \
  -params 3 %{eval %sh{
    if which $1 >/dev/null
    then
      # Note we need quotes here to make sure the newlines are not swallowed
      echo "$2" | tr "\n" ";"
    else
      echo "$3" | tr "\n" ";"
    fi
  }}


# case-of
# -------

define-command case-2 \
  -docstring "case <value> <pat-1> <cmd-1> ... <pat-n> <cmd-n>: match <value> against <pat-i> and run <cmd-i> if the match succeeds" \
  -params 5 %{eval %sh{
    case $1 in
    $2)
      # Note we need quotes here to make sure the newlines are not swallowed
      echo "$3" | tr "\n" ";";;
    $4)
      echo "$5" | tr "\n" ";";;
    esac
  }}

define-command case-3 \
  -docstring "case <value> <pat-1> <cmd-1> ... <pat-n> <cmd-n>: match <value> against <pat-i> and run <cmd-i> if the match succeeds" \
  -params 7 %{eval %sh{
    case $1 in
    $2)
      # Note we need quotes here to make sure the newlines are not swallowed
      echo "$3" | tr "\n" ";";;
    $4)
      echo "$5" | tr "\n" ";";;
    $6)
      echo "$7" | tr "\n" ";";;
    esac
  }}

define-command case-4 \
  -docstring "case <value> <pat-1> <cmd-1> ... <pat-n> <cmd-n>: match <value> against <pat-i> and run <cmd-i> if the match succeeds" \
  -params 9 %{eval %sh{
    case $1 in
    $2)
      # Note we need quotes here to make sure the newlines are not swallowed
      echo "$3" | tr "\n" ";";;
    $4)
      echo "$5" | tr "\n" ";";;
    $6)
      echo "$7" | tr "\n" ";";;
    $8)
      echo "$9" | tr "\n" ";";;
    esac
  }}

define-command case-5 \
  -docstring "case <value> <pat-1> <cmd-1> ... <pat-n> <cmd-n>: match <value> against <pat-i> and run <cmd-i> if the match succeeds" \
  -params 11 %{eval %sh{
    case $1 in
    $2)
      # Note we need quotes here to make sure the newlines are not swallowed
      echo "$3" | tr "\n" ";";;
    $4)
      echo "$5" | tr "\n" ";";;
    $6)
      echo "$7" | tr "\n" ";";;
    $8)
      echo "$9" | tr "\n" ";";;
    $10)
      echo "$11" | tr "\n" ";";;
    esac
  }}


# Experiments
# -----------
 
# define-command test \
#   -params 1 %sh{
#     test $1
#     echo $?
#   }

# define-command run \
#   -params 1 %{eval %sh{
#     $1
#   }}


# Examples
# --------

define-command example-expansions %{
  echo %opt{tabstop} %{ %opt{tabstop} } "%opt{tabstop}" '%opt{tabstop}' %{ "%opt{tabstop}" } %{ '%opt{tabstop}' } "%{%opt{tabstop}}" '%{%opt{tabstop}}'
}

define-command example-if-for-kakrc %{
  if "-f kakrc" %{
    echo '`kakrc` exists in current directory'
  } %{
    echo '`kakrc` does not exist in current directory'
  }
}

declare-option str colorscheme_mode 'light'
define-command example-switch-colorscheme \
  -docstring 'switch colorscheme between light and dark modes' %{
    if "%opt{colorscheme_mode} = light" %{
      colorscheme solarized-dark-termcolors
      set-option current colorscheme_mode 'dark'
    } %{
      colorscheme solarized-light-termcolors
      set-option current colorscheme_mode 'light'
    }
  }

define-command example-if-for-git %{
  if-available "git" %{
    echo '`git` is available'
  } %{
    echo '`git` is not available'
  }
}

declare-option int example_number 0
define-command example-if-for-number %{
  if "%opt{example_number} -lt 0" %{
    echo 'negative number'
  } %{if "%opt{example_number} -gt 0" %{
      echo 'positive number'
    } %{
      echo 'number equals zero'
    }
  }
}
define-command example-case-for-number %{
  case-3 %opt{example_number} \
    "0" %{
      echo 'number equals zero'
    } "-*" %{
      echo 'negative number'
    } "*" %{
      echo 'positive number'
    }
}


