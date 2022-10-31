# Script to run at start of work day or log in to upgrade
# packages and check current status of work.
function good-morning
    set start_dir (pwd)
    upgrade

    if test $MACCODA_ENV = "work"
        heading "Tasks remaining"
        task due.before:eoww
        if test (date | cut -f 1 -d ' ') = "Mon"
            heading "Journal entries from last week"
            jrnl -from "last week"
        else
            heading "Journal entries from yesterday"
            jrnl -on yesterday
        end
        dev pr
    end
    cd $start_dir
end
