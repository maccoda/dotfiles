function _is_work
    if test -n $MACCODA_ENV -a $MACCODA_ENV = "work"
        true
    else
        false
    end
end
