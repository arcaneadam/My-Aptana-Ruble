require 'ruble'

bundle do |bundle|
  bundle.display_name = 'My Ruble'
end
 
command 'Start of line' do |cmd|
  cmd.key_binding.mac = 'CTRL+A' # uncomment for a key binding
  cmd.output = :discard
  cmd.invoke do |context|
    start = Hash[:column, 1]
    got_to_pos(start)
    return nil
  end
end

command 'End of line' do |cmd|
  cmd.key_binding.mac = 'CTRL+E' # uncomment for a key binding
  cmd.output = :discard
  cmd.invoke do |context|
    editor = Ruble::Editor.active
    line = ENV['TM_LINE_NUMBER'];
    region = editor.document.getLineInformation(ENV['TM_LINE_NUMBER'].to_i - 1)
    length = region.length.to_i + 1
    end_line = Hash[:column, length]
    got_to_pos(end_line)
    return nil
  end
end

command 'Wrap in function' do |cmd|
  cmd.key_binding = 'M1+SHIFT+A' # uncomment for a key binding
  cmd.output = :replace_selection
  cmd.invoke do |context|
    word = ENV['TM_SELECTED_TEXT']
    context.exit_discard if word.nil?
    mname = {}
    mname[:title] = "Function Name"
    mname[:prompt] = "Enter the Function to wrap the selected text in"
    func = Ruble::UI.request_string(mname)
    func = func.strip
    context.exit_discard if func.empty? # exit if the selection is null
    print "#{func}(#{word})"
  end
end

def got_to_pos(pos)
  pos = {:file => nil, :line => ENV['TM_LINE_NUMBER'], :column => 1}.merge(pos)
  Ruble::Editor.go_to(pos)
end
