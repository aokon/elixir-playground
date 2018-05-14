defmodule Issues.GithubIssues do
  @user_agent [ {"User-agent", "Elixir"} ]
  @api_url"https://api.github.com"

  def fetch(user, project) do
    project_issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> IO.inspect()
  end

  defp project_issues_url(user, project),
    do: "#{@api_url}/repos/#{user}/#{project}/issues"
end
