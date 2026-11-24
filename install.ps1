# Windows kurulumu: yetenekler, CLAUDE.md kuralları, araçlar.
# Çalıştırma: powershell -ExecutionPolicy Bypass -File install.ps1
# Tekrar çalıştırmak güvenli; güncellemek için: git pull; ardından bu script.
$ErrorActionPreference = 'Continue'
Set-Location $PSScriptRoot
$ClaudeDir = if ($env:CLAUDE_CONFIG_DIR) { $env:CLAUDE_CONFIG_DIR } else { Join-Path $HOME '.claude' }
$Utf8 = New-Object System.Text.UTF8Encoding($false)
function Write-Warn($m) { Write-Host "  ! $m" -ForegroundColor Yellow }
function Test-Cmd($n) { [bool](Get-Command $n -ErrorAction SilentlyContinue) }

Write-Host "==> Yetenekler -> $ClaudeDir\skills"
$skillsDst = Join-Path $ClaudeDir 'skills'
New-Item -ItemType Directory -Force $skillsDst | Out-Null
$skills = Get-ChildItem -Directory skills
foreach ($s in $skills) {
  $dst = Join-Path $skillsDst $s.Name
  if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }   # sadece bu repodaki isimler
  Copy-Item -Recurse $s.FullName $dst
}
Write-Host "  $($skills.Count) yetenek kopyalandı"

Write-Host "==> CLAUDE.md kuralları"
$md = Join-Path $ClaudeDir 'CLAUDE.md'
$rules = [IO.File]::ReadAllText((Join-Path $PSScriptRoot 'CLAUDE.rules.md'), $Utf8).TrimEnd()
$cur = if (Test-Path $md) { [IO.File]::ReadAllText($md, $Utf8) } else { '' }
$pattern = '(?s)<!-- claude-setup:start -->.*?<!-- claude-setup:end -->'
if ($cur -match $pattern) {
  $new = [regex]::Replace($cur, $pattern, { param($m) $rules })
  Write-Host "  güncellendi"
} else {
  $new = $cur.TrimEnd() + "`n`n" + $rules + "`n"
  Write-Host "  eklendi"
}
[IO.File]::WriteAllText($md, $new, $Utf8)

if ($env:SKIP_TOOLS) { Write-Host "Araçlar atlandı (SKIP_TOOLS)."; return }

Write-Host "==> graphify"
$py = if (Test-Cmd 'python') { 'python' } elseif (Test-Cmd 'py') { 'py' } else { $null }
if (Test-Cmd 'uv') { uv tool install --upgrade graphifyy }
elseif ($py) {
  & $py -m pip install --user --upgrade graphifyy
  # pip --user exe'leri PATH'te olmayabilir: kullanıcı Scripts klasörünü ekle
  $scripts = & $py -c "import site,os;print(os.path.join(os.path.dirname(site.getusersitepackages()),'Scripts'))"
  $userPath = [Environment]::GetEnvironmentVariable('Path', 'User')
  if ($scripts -and (($userPath -split ';') -notcontains $scripts)) {
    [Environment]::SetEnvironmentVariable('Path', ($userPath.TrimEnd(';') + ';' + $scripts), 'User')
    Write-Host "  PATH'e eklendi: $scripts"
  }
  $env:Path += ";$scripts"
} else { Write-Warn "Python yok, graphify atlandı (Python 3.11+ kurun)" }
if (Test-Cmd 'graphify') { graphify install } elseif ($py) { & $py -m graphify install }

Write-Host "==> agent-browser"
if (Test-Cmd 'npm') { npm i -g agent-browser; agent-browser install }
else { Write-Warn "npm yok, agent-browser atlandı (Node.js kurun)" }

Write-Host "==> Playwright (webapp-testing)"
if ($py) { & $py -m pip install --user --upgrade playwright; & $py -m playwright install chromium }
else { Write-Warn "Python yok, Playwright atlandı" }

Write-Host ""
Write-Host "Bitti. Claude Code'u yeniden başlatın (PATH değiştiyse terminali de)."
