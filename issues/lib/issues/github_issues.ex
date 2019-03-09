defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir learning"}]
  @github_url Application.get_env(:issues, :github_url)

  require Logger

  def fetch(user, project) do
    Logger.info("Fetching #{user}'s project #{project}...")

    project_issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Got response: status code=#{status_code}")

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
