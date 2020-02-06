defmodule Servy.BearsView do
  require EEx

  @templates_path Path.expand("templates", File.cwd!())

  EEx.function_from_file(:def, :index, Path.join(@templates_path, "bears/index.eex"), [:bears])

  EEx.function_from_file(:def, :show, Path.join(@templates_path, "bears/show.eex"), [:bear])
end
