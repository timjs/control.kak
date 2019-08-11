
# define-command test \
#   -params 1 %sh{
#     test $1
#     echo $?
#   }

# define-command run \
#   -params 1 %{eval %sh{
#     $1
#   }}


# if-then-else
# ------------

define-command if \
  -params 3 %{eval %sh{
    if [ $1 ]
    then
      echo $2
    else
      echo $3
    fi
  }}

define-command if-available \
  -params 3 %{eval %sh{
    if which $1 >/dev/null
    then
      echo $2
    else
      echo $3
    fi
  }}

define-command case-3 \
  -params 7 %{eval %sh{
    case $1 in
    $2)
      echo $3;;
    $4)
      echo $5;;
    $6)
      echo $7;;
    esac
  }}


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


