function ls --wraps=ls --description 'alias ls=exa'
  exa --icons --group-directories-first $argv; 
end
