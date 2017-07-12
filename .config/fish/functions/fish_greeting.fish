function fish_greeting
  set line (random 1 (cat ~/.motd | wc -l))
  awk "NR==$line" ~/.motd | fold -s
end
