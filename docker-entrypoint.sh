set -e

if [ $# -eq 0 ]; then

  for scm in ./*.scm; do

    cat "$PWD/$scm" | gimp --no-interface --batch -

  done

else

  for scm in "$@"; do

    cat "$PWD/$scm" | gimp --no-interface --batch -

  done

fi
