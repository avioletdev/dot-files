# segment helper
wrap_segment() {
    local start=$1 # "true" or "false"
    local segment_color=$2 # color key or hex
    local content=$3
    local text_color=${4:-$prompt_colors[white]}

    local segment="%f"
    if [[ $start == "true" ]]; then
        segment+="%F{$segment_color}$symbol_list[round_left]"
    else
        segment+="%k%F%K{$segment_color}${symbol_list[slash]}"
    fi
    segment+="%K{$segment_color}%F{$text_color} $content %k%F{$segment_color}${symbol_list[slash]}"
    
    echo -n $segment
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

path_info() {
    local raw_path
    if git rev-parse --is-inside-work-tree &> /dev/null; then
        raw_path="$(basename $(git rev-parse --show-toplevel))"
    else
        raw_path="${(%):-%~}"
    fi
    shrink_path "$raw_path"
}

get_project_subfolder() {
    local segmentsToShow=$1
    local removeString=$2
    local subpath=${(%):-%${segmentsToShow}~}
    subpath=$(echo -n "$subpath" | sed -e "s/.*${removeString}//g")
    shrink_path "$subpath"
}
