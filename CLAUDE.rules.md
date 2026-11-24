<!-- claude-setup:start -->
## Yetenek kullanımı (tüm projeler)

Yetenekleri kullanıcı istemeden, işin aşamasına göre bu sırayla kendin çağır. Önce işin boyutunu belirle, sonra yalnızca o aşamaya ait yetenekleri kullan.

**Her zaman açık:** `ponytail` (full) her kodlama işinde varsayılan mod. Diğer yetenekler ne yapılacağını belirler; ponytail ne kadarının yazılacağını sınırlar. Çatışmada ponytail'in "en küçük tam değişiklik" kuralı geçerli, ama test, güvenlik ve doğrulama asla atlanmaz.

**İşin boyutu:**
- Küçük iş (tek dosya, net istek, basit düzeltme): planlama aşamalarını atla, doğrudan 3. aşamadan başla.
- Büyük iş (yeni proje, birden fazla dosyaya yayılan özellik, belirsiz istek): 1. aşamadan başla.

**1. Anlama** (sadece istek belirsizse)
1. `interview-me`: kim için, neden, başarı ölçütü belli değilse.
2. `idea-refine`: fikir hâlâ ham ise.

**2. Tasarım ve plan** (sadece büyük işlerde)
3. Mevcut kod tabanında çalışıyorsan önce bağlam: `graphify-out/` varsa `graphify` ile sorgula, yoksa kodu oku.
4. `spec-driven-development`: spec yoksa yaz.
5. `api-and-interface-design`: yeni API veya modül sınırı varsa.
6. `planning-and-task-breakdown`: spec'i sıralı görevlere böl.

**3. Uygulama**
7. `source-driven-development`: kullanılan framework/kütüphanenin güncel resmî dokümanını kontrol et.
8. `incremental-implementation`: birden fazla dosyaya dokunuyorsa ince dilimler halinde ilerle.
9. `test-driven-development`: mantık değişikliği veya bug fix'te önce başarısız testi yaz.
10. Alana göre: kullanıcı girdisi/auth/veri için `security-and-hardening`. Arayüz için:
    - Yeni arayüz veya görsel yeniden tasarım: önce `frontend-design` (görsel yön, tipografi), sonra `frontend-ui-engineering` (bileşen, state, erişilebilirlik).
    - React/Next.js kodu: `vercel-react-best-practices` kurallarını yazarken uygula.

**4. Hata durumunda** (herhangi bir aşamada)
- `debugging-and-error-recovery`: test kırılırsa, build bozulursa veya beklenmedik hata çıkarsa; tahmin etme, kök nedeni bul.

**5. Doğrulama ve inceleme**
11. Tarayıcıda çalışan bir şeyse gerçek tarayıcıda doğrula:
    - Kendi yerel uygulamamızın tekrarlanabilir testi (script, ekran görüntüsü, konsol logu): `webapp-testing` (Python Playwright).
    - Hızlı keşif, tıklama, form doldurma, veri çekme: `agent-browser` CLI.
    - Kullanıcının kendi oturum açık Chrome'u gerekiyorsa: Claude in Chrome araçları.
    - Chrome DevTools MCP kuruluysa performans/ağ analizi: `browser-testing-with-devtools`.
    - Arayüz kodu bittiyse: `web-design-guidelines` ile `dosya:satır` denetimi.
12. İnceleme: tek değişiklik için `ponytail-review`, tüm repo için `ponytail-audit`. `code-review-and-quality` ve yerleşik `code-review` sadece kullanıcı adıyla isterse.
13. `code-simplification`: inceleme gereksiz karmaşıklık bulduysa.
14. `doubt-driven-development`: sadece yüksek riskli işlerde (auth, ödeme, veri silme, geri alınamaz migration).

**6. Teslim**
15. `git-workflow-and-versioning`: commit, branch, PR, sürüm.
16. `documentation-and-adrs`: önemli bir mimari karar alındıysa veya public API değiştiyse.

**7. Canlıya alma** (sadece production'a gidecekse)
17. `ci-cd-and-automation` → `observability-and-instrumentation` → `shipping-and-launch`.

**Duruma bağlı (sırası yok):**
- `performance-optimization`: ölçülmüş bir yavaşlık varsa.
- `accessibility-engineering`: arayüz yayına çıkmadan önce veya istenirse.
- `deprecation-and-migration`: eski sistem/API kaldırılırken.
- `constraint-driven-development`: kalite standardı yazılı değilse ve kullanıcı isterse.
- `context-engineering`: kural dosyası (CLAUDE.md vb.) kurulurken.
- `ponytail-debt`: biriken `shortcut:` yorumları sorulduğunda.
- `find-skills`: bir iş için kurulu yetenek yoksa veya kullanıcı yetenek ararsa. Bulduğunu öner ama kullanıcı onaylamadan `npx skills add` çalıştırma; kurmadan önce SKILL.md'yi oku, global kur (`~/.claude/skills`) ve bu sıraya ekle.

**Kural:** Bir yeteneği atlıyorsan nedenini tek satırda söyle. Kullanıcı bir yeteneği adıyla isterse bu sıranın önüne geçer.
<!-- claude-setup:end -->
