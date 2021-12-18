function _is_work
    if test -n $MACCODA_ENV -a $MACCODA_ENV = "work"
        return true
    else
        return false
    end
end
