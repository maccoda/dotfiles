function select-tab
    # NOTE: Dasel is whitespace sensitive with arguments
    set tabs_to_choose (kitty @ ls | dasel -r json -w json --pretty=false 'all().filter(is_active).tabs.all().filter(not(is_active)).mapOf(id,id,title,title).merge()')
    set choice (echo $tabs_to_choose | dasel -r json -w csv | sed '1d' | tr ',' ' ' | fzf --reverse)
    kitty @ focus-tab --match "id:$(echo $choice | cut -w -f 1)"
end
