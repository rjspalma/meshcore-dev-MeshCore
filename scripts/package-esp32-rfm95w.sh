#!/bin/sh
# Build and stage the combined ESP32 image. Does not flash or publish anything.
set -eu

env_name=esp32_rfm95w_companion_radio_ble
root=$(git rev-parse --show-toplevel)
cd "$root"
[ -f variants/esp32_rfm95w/platformio.ini ] || { echo 'Missing board variant.' >&2; exit 1; }
[ -f UPSTREAM-COMMIT.txt ] || { echo 'Missing UPSTREAM-COMMIT.txt.' >&2; exit 1; }
[ -z "$(git status --porcelain --untracked-files=normal)" ] || {
    echo 'Commit the reviewed source changes before packaging.' >&2; exit 1;
}
if command -v pio >/dev/null 2>&1; then
    pio_cmd=pio
else
    pio_cmd="$HOME/.platformio/penv/bin/pio"
fi
command -v "$pio_cmd" >/dev/null 2>&1 || { echo 'PlatformIO Core not found.' >&2; exit 1; }
[ "$#" -eq 1 ] || { echo 'Usage: sh scripts/package-esp32-rfm95w.sh /path/to/new-output-directory' >&2; exit 1; }
out=$1
case "$out" in /*) ;; *) echo 'Use an absolute output path outside the fork.' >&2; exit 1;; esac
parent=$(cd "$(dirname "$out")" && pwd -P)
out="$parent/$(basename "$out")"
case "$out/" in "$root/"*) echo 'Output directory must be outside the fork.' >&2; exit 1;; esac
mkdir -- "$out"
MERGED_BIN_PATH="$out/meshcore-esp32-rfm95w-companion-ble-merged.bin" \
    "$pio_cmd" run -e "$env_name" -t mergebin
[ -s "$out/meshcore-esp32-rfm95w-companion-ble-merged.bin" ] || {
    echo 'No merged image was produced. Check the upstream merge-bin.py.' >&2; exit 1;
}
cp license.txt "$out/MeshCore-license.txt"
{
    printf 'Environment: %s\n' "$env_name"
    printf 'Source commit: %s\n' "$(git rev-parse HEAD)"
    printf 'Upstream base: %s\n' "$(cat UPSTREAM-COMMIT.txt)"
    "$pio_cmd" --version
    printf 'Artifact: combined image, ESP32 flash offset 0x0\n'
} > "$out/BUILD-INFO.txt"
(cd "$out" && sha256sum meshcore-esp32-rfm95w-companion-ble-merged.bin > SHA256SUMS.txt)
printf 'Release candidate staged in %s\n' "$out"
