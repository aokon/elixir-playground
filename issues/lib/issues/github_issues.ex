defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir learning"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    project_issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_status(),
      body |> Poison.Parser.parse!()
    }
  end

  defp project_issues_url(user, project),
    do: "#{@github_url}/repos/#{user}/#{project}/issues"

  defp check_for_status(200), do: :ok
  defp check_for_status(_), do: :error
end
