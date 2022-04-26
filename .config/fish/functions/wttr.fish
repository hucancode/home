function wttr --wraps='curl "wttr.in/Kagawa?format=3" -s' --description 'alias wttr curl "wttr.in/Kagawa?format=3" -s'
  curl "wttr.in/Kagawa?format=3" -s $argv; 
end
