function gi --description 'Fix `git` typos'
  if math (count $argv) "> 1" >/dev/null
    hub (string sub -s2 $argv[1]) $argv[2..-1]
  else
    hub (string sub -s2 $argv[1])
  end
end
