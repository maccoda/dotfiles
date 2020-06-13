#!/bin/bash
case "$(uname -s)" in

   Darwin)
     echo 'Detected Mac OS'
     source "./macos_bootstrap.sh"
     ;;

   Linux)
     echo 'Detected Linux OS'
     source "./linux_bootstrap.sh"
     ;;

   *)
     echo 'Other OS not sure how to set this up'
     exit 1
     ;;
esac
