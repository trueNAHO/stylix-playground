#!/usr/bin/env bash

# Already cached.
# nix build .#get-maintainers

MAX_MAINTAINERS=5

# PR_NUM: ${{ github.event.pull_request.number }}
PR_NUMBER=1642

printf \
  'reviewers=%s\n' \
  "$(
    gh pr diff --name-only "$PR_NUMBER" |
      jq \
        --argjson max_maintainers "$MAX_MAINTAINERS" \
        --raw-input \
        --raw-output \
        --slurp \
        --slurpfile maintainers result '
          ($maintainers[0] | keys_unsorted) as $subsystems |
          split("\n") as $changed_files |
          [
            $changed_files[] as $changed_file |
            (
              $maintainers[0][
                $subsystems[] |
                select(. as $subsystem | $changed_file | startswith($subsystem))
              ]
            )[]
          ] |
          unique |
          if length <= $max_maintainers then
            . | join(",")
          else
            ""
          end
      '
  )"
