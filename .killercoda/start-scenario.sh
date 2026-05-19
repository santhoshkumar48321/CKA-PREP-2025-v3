#!/usr/bin/env bash
set -euo pipefail

scenario_dir="${1:-$PWD}"
if [[ ! -f "$scenario_dir/LabSetUp.bash" ]]; then
  echo "ERROR: LabSetUp.bash not found in scenario directory: $scenario_dir" >&2
  exit 1
fi

question_file="$scenario_dir/Questions.bash"

chmod +x "$scenario_dir/LabSetUp.bash" "$scenario_dir/validate.bash" "$scenario_dir/cleanup.bash" 2>/dev/null || true

echo "==> Initializing scenario: $(basename "$scenario_dir")"
bash "$scenario_dir/LabSetUp.bash"

echo
echo "==> Task"
if [[ -f "$question_file" ]]; then
  sed -E 's/^# ?//' "$question_file"
else
  echo "Questions.bash not found; use scenario files directly."
fi

echo
echo "==> Useful commands"
echo "bash ./validate.bash"
echo "bash ./cleanup.bash"
