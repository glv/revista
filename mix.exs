defmodule Revista.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        revista_unified: [
          applications: [
            admin: :permanent,
            auth: :permanent,
            cms: :permanent,
            twitter: :permanent,
            web: :permanent
          ],
          steps: [:assemble, :tar]
        ]
      ],
      default_release: :revista_unified
    ]
  end

  defp deps,
    do: []
end
