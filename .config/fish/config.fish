if which rbenv >/dev/null
  status --is-interactive; and . (rbenv init -|psub)
end

if which docker-machine >/dev/null
  if docker-machine env 2>/dev/null
    eval (docker-machine env)
  end
end
