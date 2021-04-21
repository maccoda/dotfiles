# Remove files with `orig` in name. Usually occured during conflicts
function rm_orig
  fd -I orig -x rm
end
