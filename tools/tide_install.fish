function tide_install
    # If git isn't installed, there's nothing we can do
    if not command -q git
        printf '%s\n' 'Git must be installed to download Tide.'
        return 1
    end

    argparse --ignore-unknown 'l/local' -- $argv

    set -l location $argv[-1]
    if test -z "$location"
        set location 'master'
    end

    if set -q _flag_local
        source "$location/tools/tide_actual_install.fish"

        set -a flags '-l'
    else
        curl -s "https://raw.githubusercontent.com/IlanCosman/tide/$location/tools/tide_actual_install.fish" | source
    end

    tide_actual_install $flags $argv
end