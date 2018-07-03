#Coding:UTF-8
require 'date'


# Encoding.default_external = 'UTF-8'
# Encoding.default_internal = 'UTF-8'
# STDOUT.set_encoding('Windows-31J', 'UTF-8')
# STDIN .set_encoding('Windows-31J', 'UTF-8')



Pry.config.prompt = proc do | obj, nest_level, _pry_ |
  version   = ''
  version  << "\001\e[0;31m\002"
  version  << "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
  version  << "\001\e[0m\002"

  datetime =  "\001\e[0;32m\002"
  datetime << DateTime.now.strftime('%y/%m/%d %H:%M:%S')
  datetime << "\001\e[0m\002"

  " #{version} #{datetime} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})$ "
end

# Pry.config.editor = proc { | file, line | "sakura.exe -Y=#{line} #{file}" }

if defined? PryByebug
  Pry.commands.alias_command 'c',  'continue'
  Pry.commands.alias_command 's',  'step'
  Pry.commands.alias_command 'n',  'next'
  Pry.commands.alias_command 'bt', 'pry-backtrace'
  Pry.commands.alias_command 'b',  'break'
  Pry.commands.alias_command 'w',  'watch'
  Pry.commands.alias_command 'rm', 'reload-method'
  Pry.commands.alias_command 'rc', 'reload-code'
end

if defined? PryStackExplorer
  Pry.commands.alias_command 'st', 'show-stack'
end
