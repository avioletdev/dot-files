# Stateless Powerline Segment Renderer
# Ensures seamless transitions by bridging current and next colors
render_segment() {
    local is_start=$1 # "true" or "false"
    local col=$2      # current segment background
    local content=$3  # segment text
    local next_col=$4 # next segment background (for the transition slash)
    local text_col=${5:-$prompt_colors[white]}

    local res=""
    
    # 1. Start of line: Round left cap
    if [[ "$is_start" == "true" ]]; then
        res+="%f%k%F{$col}$symbol_list[round_left]"
    fi

    # 2. Segment body
    res+="%K{$col}%F{$text_col} $content "

    # 3. Transition symbol (Powerline separator)
    if [[ -n "$next_col" ]]; then
        # Boundary junction: Bridges two colors with zero gaps
        # Conditionally choose the separator glyph
        local sep_glyph="$symbol_list[point_right]"
        if [[ "$content" == *"${symbol_list[folder]}"* ]]; then
            sep_glyph="$symbol_list[arrow]"
        fi

        res+="%K{$col}%F{$prompt_colors[white]}$sep_glyph"
        res+="%K{$next_col}%F{$col}$symbol_list[powerline]"
    else
        # Final segment: Angle out into the terminal background
        # We keep the slanted slash at the end as requested
        res+="%k%F{$col}$symbol_list[powerline]%f"
    fi
    
    echo -n "$res"
}

# Command duration tracking (requires zsh/datetime)
zmodload zsh/datetime 2>/dev/null

function timer_start() {
    timer=$EPOCHREALTIME
}

function timer_stop() {
    [[ -z "$timer" ]] && return
    
    local end=$EPOCHREALTIME
    local duration=$((end - timer))
    
    if (( duration >= 1.0 )); then
        # Show in seconds if >= 1s
        printf "${symbol_list[clock]} %.2fs" $duration
    elif (( duration >= 0.001 )); then
        # Show in ms if < 1s
        local ms=$(( duration * 1000 ))
        printf "${symbol_list[clock]} %.0fms" $ms
    fi
    unset timer
}

# Path formatting and shrinking
shrink_path() {
    local path_in=$1
    # Replace intermediate folders with first char: /longfolder/sub/ -> /l/sub/
    # Keeps the last segment intact.
    echo -n "$path_in" | sed -E 's|/([^/.])([^/]{2,})(/)|/\1\3|g'
}

# Git repository path helpers
get_git_root() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        basename "$(git rev-parse --show-toplevel)"
    fi
}

get_git_relative_path() {
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        git rev-parse --show-prefix | sed 's|/$||'
    fi
}

get_breadcrumb_info() {
    local rel_path=$(get_git_relative_path)
    if [[ -z "$rel_path" ]]; then
        echo "0"
        return
    fi
    
    # Count segments by counting slashes + 1
    local count=$(echo "$rel_path" | tr -cd '/' | wc -c)
    count=$((count + 1))
    echo "$count"
}

get_current_leaf() {
    basename "$PWD"
}

path_info() {
    local raw_path
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        # If in a repo, just return the root for the first segment
        get_git_root
    else
        raw_path="${(%):-%~}"
        shrink_path "$raw_path"
    fi
}

get_project_subfolder() {
    local segmentsToShow=$1
    local removeString=$2
    local subpath=${(%):-%${segmentsToShow}~}
    subpath=$(echo -n "$subpath" | sed -e "s/.*${removeString}//g")
    shrink_path "$subpath"
}
