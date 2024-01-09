function _is_work
    if test -n "$MACCODA_ENV" -a "$MACCODA_ENV" = work
        echo "In work environment"
        true
    else
        echo "Not in work environment"
        false
    end
end
