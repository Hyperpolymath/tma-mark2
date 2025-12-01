# SPDX-FileCopyrightText: 2024 eTMA Handler Contributors
# SPDX-License-Identifier: MIT
{
  description = "eTMA Handler - Open University Marking Tool (BEAM Edition)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Elixir/Erlang versions
        erlang = pkgs.erlang_26;
        elixir = pkgs.elixir_1_16;

        # Build dependencies
        buildInputs = with pkgs; [
          erlang
          elixir
          nodejs_20
          git
          # For native extensions
          gcc
          gnumake
        ];

        # Development tools
        devTools = with pkgs; [
          # Elixir tools
          elixir_ls
          # Database tools (for inspection)
          sqlite
          # Documentation
          asciidoctor
          # Testing
          chromium  # For Wallaby/browser tests
        ];
      in
      {
        # Development shell
        devShells.default = pkgs.mkShell {
          buildInputs = buildInputs ++ devTools;

          shellHook = ''
            echo "eTMA Handler Development Environment"
            echo "Elixir: $(elixir --version | head -1)"
            echo "Erlang: $(erl -eval 'io:format("~s~n", [erlang:system_info(otp_release)]), halt().' -noshell)"

            # Set up local hex/rebar
            export MIX_HOME=$PWD/.nix-mix
            export HEX_HOME=$PWD/.nix-hex
            export PATH=$MIX_HOME/bin:$HEX_HOME/bin:$PATH

            # Install hex and rebar if not present
            if [ ! -d "$MIX_HOME" ]; then
              mix local.hex --force
              mix local.rebar --force
            fi

            # ERL_AFLAGS for better shell experience
            export ERL_AFLAGS="-kernel shell_history enabled"
          '';
        };

        # Package definition
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "etma-handler";
          version = "2.0.0";

          src = ./.;

          buildInputs = buildInputs;

          buildPhase = ''
            export MIX_ENV=prod
            export MIX_HOME=$TMPDIR/mix
            export HEX_HOME=$TMPDIR/hex

            mix local.hex --force
            mix local.rebar --force
            mix deps.get --only prod
            mix compile
            mix assets.deploy
            mix release
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp -r _build/prod/rel/etma_handler/* $out/
            ln -s $out/bin/etma_handler $out/bin/etma
          '';

          meta = with pkgs.lib; {
            description = "Open University Marking Tool (BEAM Edition)";
            homepage = "https://github.com/Hyperpolymath/tma-mark2";
            license = licenses.mit;
            platforms = platforms.unix;
            maintainers = [];
          };
        };

        # Docker/OCI image
        packages.docker = pkgs.dockerTools.buildLayeredImage {
          name = "etma-handler";
          tag = "latest";

          contents = [
            self.packages.${system}.default
            pkgs.cacert
            pkgs.tzdata
          ];

          config = {
            Cmd = [ "/bin/etma_handler" "start" ];
            Env = [
              "PHX_HOST=localhost"
              "PHX_PORT=4000"
              "MIX_ENV=prod"
            ];
            ExposedPorts = {
              "4000/tcp" = {};
            };
            WorkingDir = "/app";
          };
        };

        # Checks
        checks = {
          format = pkgs.runCommand "check-format" {
            buildInputs = [ elixir ];
          } ''
            cd ${self}
            mix format --check-formatted
            touch $out
          '';

          credo = pkgs.runCommand "check-credo" {
            buildInputs = buildInputs;
          } ''
            cd ${self}
            export MIX_HOME=$TMPDIR/mix
            export HEX_HOME=$TMPDIR/hex
            mix local.hex --force
            mix deps.get
            mix credo --strict
            touch $out
          '';
        };

        # Apps
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/etma_handler";
        };
      }
    );
}
