# Fuzzy Navigation

# cd to repo - Fuzzy search in ~/repos
# Usage: cr [search_term]
cr() {
    local dir
    # Find directories in ~/repos, minus the root itself, then fuzzy find
    dir=$(find ~/repos -maxdepth 2 -mindepth 1 -type d | sed "s|${HOME}/repos/||" | fzf --query="$1" --preview "ls -F ~/repos/{}" --select-1 --exit-0)
    
    if [[ -n "$dir" ]]; then
        cd "$HOME/repos/$dir"
    fi
}

# Fuzzy history search (if not already handled by a plugin)
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -rl 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}
