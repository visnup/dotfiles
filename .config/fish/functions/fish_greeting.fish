function fish_greeting
  test -s ~/.motd; or return
  random choice (cat ~/.motd) | fold -s -w $COLUMNS
end
