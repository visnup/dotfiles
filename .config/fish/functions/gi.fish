function gi --description 'Fix `git` typos'
  if test (count $argv) -gt 1
    git (string sub -s2 $argv[1]) $argv[2..-1]
  else
    git (string sub -s2 $argv[1])
  end
end
