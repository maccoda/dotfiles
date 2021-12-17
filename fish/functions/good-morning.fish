# Script to run at start of work day or log in to upgrade
# packages and check current status of work.
function good-morning
    upgrade

    if test $MACCODA_ENV = "work"
        heading "Tasks remaining"
        task
        # FIXME: This obviously does not work on a Monday
        heading "Journal entries from yesterday"
        jrnl work -on yesterday
    end

end
