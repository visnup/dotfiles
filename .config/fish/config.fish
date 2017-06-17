if which rbenv >/dev/null
  status --is-interactive; and . (rbenv init -|psub)
end
