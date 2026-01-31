# Symbols
typeset -A symbol_list=(
    [powerline]=$'\ue0b0'
    [slash]=$'\ue0b8'
    [heart]=$'\u2764'
    [arrow]=$'\u279c'
    [stash]=$'\ueb4b'
    [node]=$'\ue718'
    [round_left]=$'\ue0b6'
    [round_right]=$'\ue0b4'
    [folder]=$'\uf07c'
    [git]=$'\ue725'
    [open_folder]=$'\uF115'
    [rust]=$'\ue7a8'
    [python]=$'\ue73c'
    [go]=$'\ue627'
    [ruby]=$'\ue21e'
    [clock]=$'\uf017'
    [staged]=$'\uf067'
    [dirty]=$'\uf040'
    [untracked]=$'\uf059'
)

# Colors with fallback for 256 colors
typeset -A prompt_colors
if [[ "$COLORTERM" == "truecolor" ]] || [[ "$TERM" == *"24bit"* ]]; then
    prompt_colors=(
        [white]='#FFFFFF'
        [red]='#FF0000'
        [one]='#D52D00'
        [two]='#EF7627'
        [three]='#FF9A56'
        [four]='#D162A4'
        [five]='#B55690'
        [six]='#A30262'
        [green]='#4CAF50'
        [yellow]='#FFEB3B'
    )
else
    prompt_colors=(
        [white]='255'
        [red]='160'
        [one]='160'
        [two]='208'
        [three]='215'
        [four]='169'
        [five]='132'
        [six]='125'
        [green]='76'
        [yellow]='220'
    )
fi
