# Base64 decode
function decode
  echo `echo $argv | base64 --decode`
end
