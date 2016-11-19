function fish_prompt --description 'Write out the prompt'
  z --add $PWD

  set git_sha (git rev-parse --short HEAD 2>/dev/null)
  set git_branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
  set git " $git_sha $git_branch "
  if [ $git = '   ' ]
    set git ''
  end

  set length (echo [ 00:00 AM -$git(prompt_pwd) ] | wc -c | tr -d ' ')
  set fill (printf '%*s\n' (math (tput cols)-$length) '' | tr ' ' –)

  set_color $fish_color_autosuggestion
  echo ''
  echo [ (date +'%H:%M %p') –(set_color $fish_color_param)$git(set_color $fish_color_autosuggestion)$fill (set_color $fish_color_cwd)(prompt_pwd)(set_color $fish_color_autosuggestion) ]

  switch $USER
  case root toor
    echo '# '
  case '*'
    echo '$ '
  end
end
