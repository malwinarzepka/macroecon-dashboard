# Skrypt aktualizacji danych makroekonomicznych dla Quarto Dashboard
# Źródło: API Banku Światowego (The World Bank)
# Uruchomienie w terminalu: Rscript fetch_data.R

library(tidyverse)
library(jsonlite)

kraje <- c(
  POL = "Polska",
  DEU = "Niemcy",
  CZE = "Czechy",
  USA = "Stany Zjednoczone"
)

wskazniki <- c(
  "NY.GDP.MKTP.KD.ZG" = "Wzrost_PKB_proc",
  "FP.CPI.TOTL.ZG"    = "Inflacja_CPI_proc",
  "SL.UEM.TOTL.ZS"    = "Bezrobocie_proc",
  "NY.GDP.PCAP.CD"    = "PKB_per_capita_USD"
)

# Pobiera jeden wskaźnik dla jednego kraju i zwraca ramkę: Rok + kolumna wskaźnika
pobierz_wskaznik <- function(kod_kraju, kod_wskaznika, nazwa_kolumny) {
  url <- paste0(
    "https://api.worldbank.org/v2/country/", kod_kraju,
    "/indicator/", kod_wskaznika,
    "?format=json&date=2012:2025&per_page=100"
  )
  tryCatch(
    {
      odpowiedz <- fromJSON(url)
      # Odpowiedź API to lista: [[1]] metadane, [[2]] tabela z danymi
      odpowiedz[[2]] |>
        as_tibble() |>
        transmute(Rok = as.integer(date), "{nazwa_kolumny}" := round(value, 2)) |>
        filter(!is.na(.data[[nazwa_kolumny]]))
    },
    error = function(e) {
      message("    [Ostrzeżenie] ", kod_kraju, " - ", nazwa_kolumny, ": ", conditionMessage(e))
      tibble(Rok = integer(), "{nazwa_kolumny}" := numeric())
    }
  )
}

aktualizuj_dane <- function(sciezka = "data/macro_data.csv") {
  message("--> Pobieranie świeżych wskaźników z API Banku Światowego...")

  dane <- map_dfr(names(kraje), function(kod_kraju) {
    df_kraj <- tibble(Rok = 2012:2025, Kraj = kod_kraju, Nazwa_Kraju = kraje[[kod_kraju]])
    for (kod_wskaznika in names(wskazniki)) {
      df_kraj <- left_join(
        df_kraj,
        pobierz_wskaznik(kod_kraju, kod_wskaznika, wskazniki[[kod_wskaznika]]),
        by = "Rok"
      )
    }
    df_kraj
  })

  dane <- arrange(dane, Kraj, Rok)
  dir.create(dirname(sciezka), showWarnings = FALSE, recursive = TRUE)
  write_csv(dane, sciezka, na = "")
  message("[OK] Zaktualizowano plik: ", sciezka)
}

aktualizuj_dane()
