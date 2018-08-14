function fish_right_prompt
  set -l last_status $status

  set -l green (set_color -o green)
  set -l red (set_color -o red)
  set -l normal (set_color normal)

  if [ $last_status -ne 0 ]
    echo -n -s $red "[" $normal $last_status $red "]" $normal
  end
end