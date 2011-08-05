require 'ruble'

bundle do |bundle|
  bundle.display_name = 'My Ruble'
end
 
command 'Start of line' do |cmd|
  cmd.key_binding.mac = 'CTRL+A' # uncomment for a key binding
  cmd.invoke do |context|
    start = Hash[:column,1]
    Ruble::Editor.go_to(start)
  end
end

command 'End of line' do |cmd|
  cmd.key_binding.mac = 'CTRL+E' # uncomment for a key binding
  cmd.invoke do |context|
    editor = Ruble::Editor.active
    line = ENV['TM_LINE_NUMBER'];
    region = editor.document.getLineInformation(ENV['TM_LINE_NUMBER'].to_i - 1)
    length = region.length.to_i + 1
    end_line = Hash[:column, length]
    Ruble::Editor.go_to(end_line)
  end
end