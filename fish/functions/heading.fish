# Wraps provided text in bars to look as a heading
#
# -n/no-trail: If set will not print a trailing new line

function heading
    argparse 'n/no-trail' -- $argv
    set text_length (echo $argv[1] | wc -m)
    set bars (string repeat --count $text_length '=')
    echo -e "\n$bars"
    echo $argv[1]
    echo -e "$bars"
    if ! set -q _flag_n
        echo
    end

end
