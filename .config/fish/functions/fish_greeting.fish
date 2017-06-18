function fish_greeting
  set r (random 1 1000)
  set word (curl -s https://unpkg.com/common-english-words@0.0.6/1000-common-words.txt | awk "NR==$r {print \$2}")
  curl -s "https://harpers.org/findings?search=$word" | pup '.findresult .data p text{}' > /tmp/findings.txt
  set r (random 1 (wc -l /tmp/findings.txt | awk '{print $1}'))
  awk "NR==$r" /tmp/findings.txt
end
