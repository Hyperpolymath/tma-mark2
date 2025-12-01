defmodule EtmaHandler.MixProject do
  use Mix.Project

  @version "2.0.0"
  @description "eTMA Handler - Open University Marking Tool (BEAM Edition)"

  def project do
    [
      app: :etma_handler,
      version: @version,
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      description: @description,
      # Tier 2: The Burrito Wrapper (Cross-Platform Binaries)
      releases: releases()
    ]
  end

  def application do
    [
      mod: {EtmaHandler.Application, []},
      extra_applications: [:logger, :runtime_tools, :os_mon, :crypto]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # --- The Core Engine ---
      {:phoenix, "~> 1.7"},
      {:phoenix_live_view, "~> 0.19"},
      {:bandit, "~> 1.0"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:floki, ">= 0.30.0", only: :test},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:heroicons, "~> 0.5"},
      {:jason, "~> 1.4"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},

      # --- The "Magic Bullet" Data Layer ---
      # CubDB: Pure Elixir, crash-proof, append-only B-Tree database
      # Runs everywhere the BEAM runs (RISC-V, Minix, etc.)
      {:cubdb, "~> 2.0"},
      # Ecto for validation logic (schemaless changesets)
      {:ecto, "~> 3.10"},
      # SweetXml for parsing legacy .fhi and .docx files
      {:sweet_xml, "~> 0.7"},

      # --- The Fort Knox Vault (Security) ---
      # Argon2id for password hashing (memory-hard, side-channel resistant)
      {:argon2_elixir, "~> 3.0"},

      # --- System Integration ---
      # Watch Downloads folder for automatic file ingestion
      {:file_system, "~> 1.0"},

      # --- Optional/Experimental (dev only) ---
      # miniKanren for relational/logic programming ("What-If" calculator)
      # {:mini_kanren, "~> 0.3", only: :dev},
      # Optimist for strict CLI argument parsing
      # {:optimist, "~> 0.2", only: :dev},
      # BLAKE3 - blazing fast, secure hash function
      # {:blake3, "~> 1.0", only: :dev},
      # Post-quantum cryptography (ML-KEM-1024 / CRYSTALS-Kyber)
      # {:pqclean, "~> 0.1", only: :dev, github: "potatosalad/erlang-pqclean"},
      # CBOR encoding for WebAuthn attestation parsing
      # {:cbor, "~> 1.0", only: :dev},
      # WASM plugins (sandboxed execution)
      # {:wasmex, "~> 0.8", only: :dev},
      # Binary wrapper for cross-platform distribution
      {:burrito, "~> 1.0", only: :dev}
    ]
  end

  # Burrito Configuration (The "Chimichanga")
  defp releases do
    [
      etma_handler: [
        steps: [:assemble] ++ burrito_steps(),
        burrito: [
          targets: [
            # Linux (x86_64) - For Fedora/Ubuntu/Debian
            linux: [os: :linux, cpu: :x86_64],
            # Linux (ARM64) - For Raspberry Pi, Apple Silicon VMs
            linux_arm: [os: :linux, cpu: :aarch64],
            # Linux (RISC-V) - For development boards
            riscv: [os: :linux, cpu: :riscv64],
            # Windows (x86_64) - For work laptops
            windows: [os: :windows, cpu: :x86_64],
            # macOS (Intel)
            macos_intel: [os: :darwin, cpu: :x86_64],
            # macOS (Apple Silicon)
            macos_arm: [os: :darwin, cpu: :aarch64]
          ]
        ]
      ]
    ]
  end

  defp burrito_steps do
    if Code.ensure_loaded?(Burrito) do
      [&Burrito.wrap/1]
    else
      []
    end
  end

  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"],
      test: ["test"]
    ]
  end
end
