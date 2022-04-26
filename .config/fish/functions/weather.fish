function weather --wraps='while true; set weather (curl "wttr.in/Kagawa?format=3" -s); clear; echo $weather; sleep 5s; end;' --description 'alias weather while true; set weather (curl "wttr.in/Kagawa?format=3" -s); clear; echo $weather; sleep 5s; end;'
  while true; set weather (curl "wttr.in/Kagawa?format=3" -s); clear; echo $weather; sleep 5s; end; $argv; 
end
