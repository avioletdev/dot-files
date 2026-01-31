is_git_repo() {
    git rev-parse --is-inside-work-tree &> /dev/null
}

git_info() {
    local ref status indicators ahead_behind
    
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    ref=${ref#refs/heads/}

    # Collect indicators in an array for clean spacing
    local -a indicators_list
    
    # Status indicators
    local git_status=$(command git status --porcelain 2> /dev/null)
    if [[ -n $(echo "$git_status" | grep -E '^.[M?D]') ]]; then
        indicators_list+=("${symbol_list[dirty]}")
    fi
    if [[ -n $(echo "$git_status" | grep -E '^[MADRC]') ]]; then
        indicators_list+=("${symbol_list[staged]}")
    fi
    if [[ -n $(echo "$git_status" | grep -E '^\?\?') ]]; then
        indicators_list+=("${symbol_list[untracked]}")
    fi

    # Stash count
    local stash_count=$(command git stash list 2>/dev/null | grep -c .)
    if [[ "$stash_count" -gt 0 ]]; then
        indicators_list+=("${symbol_list[stash]}$stash_count")
    fi

    # Ahead/Behind
    local branch_info=$(command git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
    if [[ -n "$branch_info" ]]; then
        local counts=$(command git rev-list --left-right --count HEAD...@{u} 2>/dev/null)
        local ahead=$(echo $counts | cut -f1)
        local behind=$(echo $counts | cut -f2)
        [[ "$ahead" -gt 0 ]] && ahead_behind+=" ↑$ahead"
        [[ "$behind" -gt 0 ]] && ahead_behind+=" ↓$behind"
    fi

    # Join indicators with a single space
    local indicators_joined="${(j: :)indicators_list}"
    echo -n "($ref$ahead_behind) ${indicators_joined}"
}
