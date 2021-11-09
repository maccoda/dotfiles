# Wraps provided text in bars to look as a heading

function heading
    set text_length (echo $argv[1] | wc -m)
    set bars (string repeat --count $text_length '=')
    echo -e "\n$bars"
    echo $argv[1]
    echo -e "$bars\n"

end
