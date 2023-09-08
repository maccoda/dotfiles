function rm_exists
    set input_file $argv[1]
    if test -f $input_file
        rm $input_file
    end
end
