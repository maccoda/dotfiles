# Base64 encode
function encode
  echo -n $argv[1] | openssl base64 | pbcopy
end
