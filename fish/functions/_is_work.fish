function _is_work
    if test -n "$MACCODA_ENV" -a "$MACCODA_ENV" = "work"
        echo "1"
    else
        echo "0"
    end
end
