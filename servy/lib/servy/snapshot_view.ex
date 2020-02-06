defmodule Servy.SnapshotView do
  require EEx

  @templates_path Path.expand("templates", File.cwd!())

  EEx.function_from_file(:def, :index, Path.join(@templates_path, "snapshot/index.eex"), [:snapshots, :locations])
end
