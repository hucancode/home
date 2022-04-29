function docker-arch --wraps='docker run --rm -it archlinux bash' --description 'alias docker-arch docker run --rm -it archlinux bash'
  docker run --rm -it $argv archlinux bash; 
end
