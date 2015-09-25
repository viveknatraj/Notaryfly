class String
#truncate(text, length = 30, truncate_string = "...")
#If text is longer than length, text will be truncated to the length of
#length (defaults to 30) and the last characters will be replaced with
#the truncate_string (defaults to "...").

def truncate(length = 20, truncate_string = "...")
  text = self
  if text
    l = length - truncate_string.length
    chars = text.split('')
    (chars.length > length ? chars[0...l].join + truncate_string : text).to_s
  end
end
end
