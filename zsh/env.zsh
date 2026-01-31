get_rust_version() {
    local version=$(rustc --version 2> /dev/null | cut -d' ' -f2)
    [[ -n "$version" ]] && echo -n "${symbol_list[rust]} v$version"
}

get_node_version() {
    local version=$(node -v 2> /dev/null | sed 's/v//')
    [[ -n "$version" ]] && echo -n "${symbol_list[node]} v$version"
}

get_python_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo -n "${symbol_list[python]} ($(basename $VIRTUAL_ENV))"
    elif [ -f 'Pipfile' ] || [ -f 'requirements.txt' ] || [ -f 'pyproject.toml' ]; then
        local version=$(python3 --version 2> /dev/null | cut -d' ' -f2)
        [[ -n "$version" ]] && echo -n "${symbol_list[python]} v$version"
    fi
}

get_go_version() {
    local version=$(go version 2> /dev/null | cut -d' ' -f3 | sed 's/go//')
    [[ -n "$version" ]] && echo -n "${symbol_list[go]} v$version"
}

get_ruby_version() {
    local version=$(ruby -v 2> /dev/null | cut -d' ' -f2)
    [[ -n "$version" ]] && echo -n "${symbol_list[ruby]} v$version"
}

project_info() {
    if [ -f "Cargo.toml" ]; then
        get_rust_version
    elif [ -f "package.json" ]; then
        get_node_version
    elif [ -f "go.mod" ]; then
        get_go_version
    elif [ -f "Gemfile" ]; then
        get_ruby_version
    else
        # Default fallback if no specific project file found but we are in a folder
        echo -n "${symbol_list[arrow]} ${symbol_list[folder]}"
    fi
    
    # Always append python info if in venv or python project
    local py=$(get_python_info)
    [[ -n "$py" ]] && echo -n " $py"
}
