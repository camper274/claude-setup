# claude-setup

Claude Code için kişisel yetenek seti, global `CLAUDE.md` kullanım kuralları ve gereken araçlar. Aynı hesaptaki her bilgisayarda tek komutla kurulur.

## Kurulum

**Windows**
```powershell
gh repo clone camper274/claude-setup $HOME\claude-setup
cd $HOME\claude-setup
powershell -ExecutionPolicy Bypass -File install.ps1
```

**macOS / Linux**
```bash
gh repo clone camper274/claude-setup ~/claude-setup
cd ~/claude-setup && ./install.sh
```

Sonra Claude Code'u yeniden başlat. Gereken: git, Python 3.11+, Node.js (npm). macOS/Linux'ta `uv` varsa graphify onunla kurulur.

## Güncelleme

```bash
git pull   # ardından install.ps1 veya install.sh'i yeniden çalıştır
```

Script yalnızca bu repodaki yetenek klasörlerini değiştirir; `~/.claude/skills` içindeki başka yeteneklere ve `CLAUDE.md`'nin `<!-- claude-setup:start/end -->` dışındaki kısmına dokunmaz. Bir yeteneği yerelde düzenlediysen bir sonraki kurulumda üzerine yazılır; değişikliği bu repoya yap.

Yeni yetenek eklemek: klasörü `skills/` içine koy, `CLAUDE.rules.md`'deki sıraya ekle, commit + push.

## Ne kurar

| Parça | Ne yapar |
|---|---|
| `skills/` (39 yetenek) | `~/.claude/skills/` içine kopyalanır |
| `CLAUDE.rules.md` | Hangi yeteneğin hangi aşamada kullanılacağı; `~/.claude/CLAUDE.md` içine eklenir/güncellenir |
| graphify (`graphifyy`) | Kodu bilgi grafiğine çeviren CLI; `graphify install` yeteneğini o işletim sistemine göre üretir |
| agent-browser | Tarayıcı otomasyon CLI'ı + Chrome |
| Playwright + Chromium | `webapp-testing` yeteneği için |

## Yetenekler ve kaynakları

| Kaynak | Yetenekler | Lisans |
|---|---|---|
| [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) | ponytail, ponytail-audit, -debt, -gain, -help, -review | MIT |
| [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | 26 mühendislik yeteneği (spec, plan, TDD, debugging, review, güvenlik, performans, CI/CD, shipping…) | MIT |
| [anthropics/skills](https://github.com/anthropics/skills) | frontend-design, webapp-testing | her klasördeki LICENSE.txt |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | vercel-react-best-practices, web-design-guidelines | MIT |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | find-skills | MIT |
| [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) | agent-browser | Apache-2.0 |
| [safishamsi/graphify](https://github.com/safishamsi/graphify) | graphify (kurulumda üretilir) | MIT |
| [JDhruv14/line-art-animation](https://github.com/JDhruv14/line-art-animation) | line-art-animation | MIT |

claude.ai hesabına yüklenen yetenekler (`~/.claude/skills/synced`) zaten hesapla senkronlandığı için burada yok.
