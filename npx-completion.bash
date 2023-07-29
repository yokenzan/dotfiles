_npx() {
  local dir=$(pwd -P)
  while [[ -n "$dir" ]]; do
    if [[ ! -d $dir/node_modules/.bin ]]; then
      dir=${dir%/*}
      continue
    fi
    local execs=( `cd $dir/node_modules/.bin; find -L . -type f -executable` )
    execs=( ${execs[@]/#.\//} )
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${execs[*]}" -- "$cur" ) )
    break
  done
}

complete -F _npx npx
