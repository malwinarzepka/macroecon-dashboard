# 📊 Dashboard Makroekonomiczny ALK w Quarto (`format: dashboard`) 🚀
### Projekt Laboratoryjny: Nowoczesne Raportowanie BI & Wdrożenie na GitHub Pages
**Uczelnia:** Akademia Leona Koźmińskiego (ALK)  
**Środowisko:** Antigravity IDE & Quarto CLI  
**Technologie:** Quarto, R, tidyverse, plotly, YAML, GitHub Pages, GitHub Actions  

---

## 🎯 Cel Projektu
Projekt demonstruje budowę responsywnego, interaktywnego panelu biznesowego (**Executive Dashboard**) z wykorzystaniem standardu **Quarto Dashboards**:
1. **Karty KPI (Value Boxes):** Dynamicznie wyliczane wskaźniki (Wzrost PKB, Inflacja CPI, Bezrobocie, PKB per capita).
2. **Interaktywne Wykresy (Plotly):** Obsługa zoomu, najechania myszką (hover tooltips), filtrowania serii i dynamicznych legend.
3. **Układ Wielozakładkowy (Tabsets / Pages):** Osobna strona dla wskaźników Polski oraz strona porównania regionalnego (Polska, Niemcy, Czechy, USA).
4. **Pasek boczny (Sidebar):** Prezentacja założeń metodologicznych, źródeł danych (Bank Światowy) oraz autorów.
5. **Ciągłe Wdrażanie (CI/CD):** Automatyczna kompilacja i publikacja dashboardu na **GitHub Pages** pod publicznym adresem URL.

---

## 🚀 Uruchomienie i Podgląd na Żywo w Antigravity

### 1. Przygotowanie środowiska:
W terminalu Antigravity (PowerShell):
```powershell
# Sprawdzenie instalacji R:
Rscript --version

# Instalacja pakietów R (jednorazowo):
Rscript -e "install.packages(c('tidyverse', 'plotly', 'knitr', 'rmarkdown'), repos = 'https://cloud.r-project.org')"
```

### 2. Podgląd na żywo w czasie rzeczywistym (Live Preview):
```powershell
quarto preview dashboard.qmd
```
*Quarto uruchomi lokalny serwer WWW (zwykle pod adresem http://localhost:4200) z funkcją **Hot Reload** – każda zmiana w kodzie `.qmd` natychmiast odświeża dashboard w przeglądarce!*

### 3. Kompilacja do pliku produkcyjnego HTML:
```powershell
quarto render dashboard.qmd --output-dir docs --output index.html
```

---

## 🔄 Aktualizacja danych (opcjonalnie)
Plik `data/macro_data.csv` jest dołączony do projektu. Aby pobrać świeże wskaźniki z API Banku Światowego:
```powershell
Rscript fetch_data.R
```

---

## 🌐 Publikacja na GitHub Pages
Po wypchnięciu kodu na GitHuba workflow `.github/workflows/deploy_dashboard.yml` automatycznie skompiluje dashboard i udostępni go pod adresem:  
`https://TWOJ_LOGIN.github.io/NAZWA_REPOZYTORIUM/`
