#!/usr/bin/env bash
# macOS / Linux kurulumu: yetenekler, CLAUDE.md kuralları, araçlar.
# Tekrar çalıştırmak güvenli; güncellemek için: git pull && ./install.sh
set -uo pipefail
cd "$(dirname "$0")"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
warn() { echo "  ! $*" >&2; }
has() { command -v "$1" >/dev/null 2>&1; }

echo "==> Yetenekler -> $CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/skills"
for d in skills/*/; do
  n=$(basename "$d")
  rm -rf "$CLAUDE_DIR/skills/$n"   # sadece bu repodaki isimler değiştirilir
  cp -R "$d" "$CLAUDE_DIR/skills/$n"
done
echo "  $(ls skills | wc -l | tr -d ' ') yetenek kopyalandı"

echo "==> CLAUDE.md kuralları"
md="$CLAUDE_DIR/CLAUDE.md"; touch "$md"
if grep -q 'claude-setup:start' "$md"; then
  awk -v f=CLAUDE.rules.md 'BEGIN{while((getline l<f)>0) r=r l "\n"}
    /claude-setup:start/{printf "%s", r; skip=1; next}
    /claude-setup:end/{skip=0; next} !skip' "$md" > "$md.tmp" && mv "$md.tmp" "$md"
  echo "  güncellendi"
else
  printf '\n' >> "$md"; cat CLAUDE.rules.md >> "$md"; echo "  eklendi"
fi

[ -n "${SKIP_TOOLS:-}" ] && { echo "Araçlar atlandı (SKIP_TOOLS)."; exit 0; }
PY=$(has python3 && echo python3 || echo python)

echo "==> graphify"
if has uv; then uv tool install --upgrade graphifyy
elif has pipx; then pipx install --force graphifyy
else $PY -m pip install --user --upgrade graphifyy || warn "graphifyy kurulamadı (uv önerilir: https://docs.astral.sh/uv/)"
fi
if has graphify; then graphify install; else $PY -m graphify install || warn "graphify install çalışmadı"; fi

echo "==> agent-browser"
if has npm; then
  npm i -g agent-browser && agent-browser install || warn "agent-browser kurulamadı (Linux'ta npm global için sudo gerekebilir)"
else warn "npm yok, agent-browser atlandı (Node.js kurun)"; fi

echo "==> Playwright (webapp-testing)"
$PY -m pip install --user --upgrade playwright && $PY -m playwright install chromium \
  || warn "Playwright kurulamadı (Homebrew Python'da: pipx/uv veya venv kullanın)"

echo
echo "Bitti. Claude Code'u yeniden başlatın."
