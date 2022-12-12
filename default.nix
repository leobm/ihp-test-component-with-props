let
    ihp = builtins.fetchGit {
        url = "https://github.com/leobm/ihp.git";
        ref = "97911b427b0df9793ea4afb0c88f35c282e47f95";
    };
    haskellEnv = import "${ihp}/NixSupport/default.nix" {
        ihp = ihp;
        haskellDeps = p: with p; [
            cabal-install
            base
            wai
            text
            hlint
            p.ihp
        ];
        otherDeps = p: with p; [
            # Native dependencies, e.g. imagemagick
        ];
        projectPath = ./.;
    };
in
    haskellEnv
