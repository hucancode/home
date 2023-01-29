function youtube-mp3 --wraps='youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"' --description 'alias youtube-mp3-pl youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'
  youtube-dl --download-archive downloaded.txt --no-post-overwrites --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" $argv; 
end
