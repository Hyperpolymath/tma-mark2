# SPDX-FileCopyrightText: 2024 Panoptes Contributors
# SPDX-License-Identifier: MIT
{
  description = "Panoptes - AI-powered local file scanner using Moondream via Ollama";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, crane }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "clippy" "rustfmt" ];
          targets = [ "wasm32-unknown-unknown" "x86_64-unknown-linux-musl" ];
        };

        craneLib = (crane.mkLib pkgs).overrideToolchain rustToolchain;

        # Common build inputs
        commonBuildInputs = with pkgs; [
          openssl
          pkg-config
          sqlite
        ];

        # Development inputs
        devInputs = with pkgs; [
          # Rust tooling
          rustToolchain
          cargo-watch
          cargo-tarpaulin
          cargo-audit
          cargo-outdated
          cargo-deny
          cargo-udeps
          cargo-nextest

          # Build tools
          just
          nickel

          # Documentation
          asciidoctor
          lychee

          # Containers
          podman
          buildah
          skopeo

          # Development
          direnv
          watchexec

          # AI/ML
          ollama
        ];

        # Source filtering
        src = pkgs.lib.cleanSourceWith {
          src = craneLib.path ./.;
          filter = path: type:
            (craneLib.filterCargoSources path type)
            || (builtins.match ".*\\.adoc$" path != null)
            || (builtins.match ".*\\.ncl$" path != null)
            || (builtins.match ".*\\.html$" path != null);
        };

        # Build arguments
        commonArgs = {
          inherit src;
          strictDeps = true;
          buildInputs = commonBuildInputs;
          nativeBuildInputs = with pkgs; [ pkg-config ];

          # Environment
          OPENSSL_NO_VENDOR = "1";
        };

        # Build only dependencies (for caching)
        cargoArtifacts = craneLib.buildDepsOnly commonArgs;

        # Full package
        panoptes = craneLib.buildPackage (commonArgs // {
          inherit cargoArtifacts;

          # Run tests
          doCheck = true;
        });

        # Clippy checks
        panoptesClippy = craneLib.cargoClippy (commonArgs // {
          inherit cargoArtifacts;
          cargoClippyExtraArgs = "--all-targets -- --deny warnings -W clippy::pedantic";
        });

        # Format check
        panoptesFmt = craneLib.cargoFmt {
          inherit src;
        };

        # Documentation
        panoptesDoc = craneLib.cargoDoc (commonArgs // {
          inherit cargoArtifacts;
        });

        # Audit
        panoptesAudit = craneLib.cargoAudit {
          inherit src;
          advisory-db = pkgs.fetchFromGitHub {
            owner = "rustsec";
            repo = "advisory-db";
            rev = "main";
            sha256 = pkgs.lib.fakeSha256;
          };
        };

      in
      {
        # Packages
        packages = {
          default = panoptes;
          panoptes = panoptes;
          panoptes-doc = panoptesDoc;
        };

        # Checks
        checks = {
          inherit panoptes panoptesClippy panoptesFmt;
        };

        # Apps
        apps = {
          default = flake-utils.lib.mkApp {
            drv = panoptes;
          };
          panoptes = flake-utils.lib.mkApp {
            drv = panoptes;
          };
        };

        # Development shell
        devShells.default = craneLib.devShell {
          checks = self.checks.${system};

          packages = devInputs;

          # Shell hook
          shellHook = ''
            echo "🔭 Panoptes Development Environment"
            echo ""
            echo "Available commands:"
            echo "  just --list    Show all tasks"
            echo "  cargo build    Build the project"
            echo "  cargo test     Run tests"
            echo "  ollama serve   Start Ollama"
            echo ""

            # Set up environment
            export RUST_BACKTRACE=1
            export RUST_LOG=info
            export PANOPTES_OLLAMA_URL="http://localhost:11434"

            # Ensure Ollama model is available
            if command -v ollama &> /dev/null; then
              if ! ollama list | grep -q moondream; then
                echo "⚠️  Moondream model not found. Run: ollama pull moondream"
              fi
            fi
          '';

          # Environment variables
          RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
        };

        # Formatter
        formatter = pkgs.nixpkgs-fmt;
      }
    ) // {
      # Overlays
      overlays.default = final: prev: {
        panoptes = self.packages.${prev.system}.default;
      };

      # NixOS module
      nixosModules.default = { config, lib, pkgs, ... }:
        with lib;
        let
          cfg = config.services.panoptes;
        in
        {
          options.services.panoptes = {
            enable = mkEnableOption "Panoptes file scanner service";

            package = mkOption {
              type = types.package;
              default = self.packages.${pkgs.system}.default;
              description = "Panoptes package to use";
            };

            user = mkOption {
              type = types.str;
              default = "panoptes";
              description = "User to run panoptes as";
            };

            group = mkOption {
              type = types.str;
              default = "panoptes";
              description = "Group to run panoptes as";
            };

            dataDir = mkOption {
              type = types.path;
              default = "/var/lib/panoptes";
              description = "Data directory for panoptes";
            };

            watchDirs = mkOption {
              type = types.listOf types.path;
              default = [ ];
              description = "Directories to watch for new files";
            };

            ollamaUrl = mkOption {
              type = types.str;
              default = "http://localhost:11434";
              description = "Ollama API URL";
            };

            webEnable = mkOption {
              type = types.bool;
              default = false;
              description = "Enable web dashboard";
            };

            webPort = mkOption {
              type = types.port;
              default = 8080;
              description = "Web dashboard port";
            };
          };

          config = mkIf cfg.enable {
            users.users.${cfg.user} = {
              isSystemUser = true;
              group = cfg.group;
              home = cfg.dataDir;
              createHome = true;
            };

            users.groups.${cfg.group} = { };

            systemd.services.panoptes = {
              description = "Panoptes AI File Scanner";
              wantedBy = [ "multi-user.target" ];
              after = [ "network.target" "ollama.service" ];

              serviceConfig = {
                Type = "simple";
                User = cfg.user;
                Group = cfg.group;
                ExecStart = "${cfg.package}/bin/panoptes watch ${concatStringsSep " " cfg.watchDirs}";
                Restart = "on-failure";
                RestartSec = "5s";

                # Hardening
                NoNewPrivileges = true;
                ProtectSystem = "strict";
                ProtectHome = "read-only";
                PrivateTmp = true;
                ReadWritePaths = [ cfg.dataDir ] ++ cfg.watchDirs;
              };

              environment = {
                PANOPTES_OLLAMA_URL = cfg.ollamaUrl;
                PANOPTES_DATABASE = "${cfg.dataDir}/panoptes.db";
                RUST_LOG = "info";
              };
            };

            systemd.services.panoptes-web = mkIf cfg.webEnable {
              description = "Panoptes Web Dashboard";
              wantedBy = [ "multi-user.target" ];
              after = [ "panoptes.service" ];

              serviceConfig = {
                Type = "simple";
                User = cfg.user;
                Group = cfg.group;
                ExecStart = "${cfg.package}/bin/panoptes web --port ${toString cfg.webPort}";
                Restart = "on-failure";

                # Hardening
                NoNewPrivileges = true;
                ProtectSystem = "strict";
                PrivateTmp = true;
              };

              environment = {
                PANOPTES_DATABASE = "${cfg.dataDir}/panoptes.db";
              };
            };
          };
        };
    };
}
