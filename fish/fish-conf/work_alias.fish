# Aliases only useful for current place of work
alias b='brazil'

function bb
  brazil-build $argv &| tee build.out
end

function wk
    cd ~/workplace
end

function sage
    set search_term ""
    for word in $argv
        if test -z "$search_term"
            set search_term "$word"
        else
            set search_term "$search_term+$word"
        end
    end
    open "https://sage.amazon.com/search?q=$search_term"
end

function mcp
    if test "$argv[1]" = 'lpt'
        cd ~/workplace/PrimeMCPLpt/src/PrimeMCPLpt
    else if test "$argv[1]" = 'test'
        cd ~/workplace/PrimeMCPService/src/PrimeMCPIntegrationTests
    else if test "$argv[1]" = 'client'
        cd ~/workplace/PrimeMCPService/src/PrimeMCPClient
    else if test "$argv[1]" = 'model'
        cd ~/workplace/PrimeMCPService/src/PrimeMCPModel
    else if test "$argv[1]" = 'tps'
        cd ~/workplace/PrimeMCPService/src/PrimeMCPLoadTests
    else
        cd ~/workplace/PrimeMCPService/src/PrimeMCPService
    end
end

function magpie
    set -l workspace ~/workplace/Magpie/src
    if test "$argv[1]" = 'lpt'
        cd ~/workplace/PrimeMCPLpt/src/PrimeMAGPIEServiceLpt
    else if test "$argv[1]" = 'test'
        cd ~/workplace/Magpie/src/PrimeMAGPIEServiceTests
    else if test "$argv[1]" = 'client'
        cd ~/workplace/PrimeMCPService/src/PrimeMCPClient
    else if test "$argv[1]" = 'model'
        cd ~/workplace/Magpie/src/PrimeMAGPIEServiceModel
    else if test "$argv[1]" = 'tps'
        cd ~/workplace/PrimeMCPService/src/PrimeMCPLoadTests
    else
        cd ~/workplace/Magpie/src/PrimeMAGPIEService
    end
end

alias cloud-debug='ssh -L 8123:localhost:9000 dev-dsk-dmaccora-2c-d42eefba.us-west-2.amazon.com -f -N '

alias changelog='cd ~/tools/changelog; and nv'

fish_add_path '/Volumes/unix/workplace/EnvImprovement/src/NinjaUtilsClojure/build/bin' $HOME/.toolbox/bin
# This is a hack to make the kotlin LSP work nicely with work build system
# This will need to be changed each time brew updates the version
fish_add_path /usr/local/cellar/kotlin/1.4.32/libexec/bin


set dev_desktop_hostname_1 'dev-dsk-dmaccora-2c-9b64e455.us-west-2.amazon.com'

if test $dev_desktop_hostname_1 = (hostname)
    functions -e vim
    functions -e cat
    functions -e grep
    functions -e find
    functions -e ls
    functions -e du
end
