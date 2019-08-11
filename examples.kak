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


