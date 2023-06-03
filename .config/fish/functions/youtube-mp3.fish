function youtube-mp3 --wraps='yt-dlp --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"' --description 'alias youtube-mp3-pl youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'
  yt-dlp --download-archive downloaded.txt --no-post-overwrites --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" $argv; 
end
