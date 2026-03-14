# PSYC2001 Assignment Marker Helper

A [Shiny](https://shiny.posit.co/) web app designed to help PSYC2001 markers verify student assignment results. Given a student's z-number, the app regenerates the unique dataset that was provided to that student and reruns the required statistical analyses, so markers can quickly cross-check submitted answers.

**Live app:** <https://unsw-psych.shinyapps.io/PSYC2001_assignment-marker-helper_2026/>

---

## How It Works

1. The student's z-number (the digits, without the leading "z") is used as a random seed.
2. A dataset of 100 simulated participants (50 per group) is generated — every student receives a different but reproducible dataset.
3. The app automatically runs the key statistical tests and displays the results.

---

## Statistical Tests Displayed

| Section | Test |
|---|---|
| Key Results | Paired t-test (v1 vs v2) |
| Key Results | Independent samples t-test (v1 ~ group) |
| Key Results | One-sample t-test (v1, µ = 0) |
| Key Results | Pearson correlation (v1 vs v2) |
| Back Up | Independent samples t-test (v2 ~ group) |
| Back Up | One-sample t-test (v2, µ = 0) |

---

## Using the App

1. Open the live app link above (or run it locally — see below).
2. Enter the student's **7-digit z-number** (numbers only, no "z") in the sidebar.
3. The main panel updates instantly with all test results for that student's dataset.

---

## Repository Structure

```
.
├── app.R                  # Shiny UI and server definition
├── assets/
│   ├── dataGen.R          # Data generation function (seeded by student z-number)
│   └── performStats.R     # Statistical analysis function
├── index.htm              # Landing page (used by shinyapps.io)
└── manifest.json          # shinyapps.io deployment manifest
```

---

## Running Locally

### Prerequisites

Install the required R packages:

```r
install.packages(c("shiny", "zip", "scales", "here", "tidyverse"))
```

### Launch the app

```r
shiny::runApp()
```

or, from the R console in the repo root:

```r
source("app.R")
```

---

## Deployment

The app is deployed to [shinyapps.io](https://www.shinyapps.io/) under the `unsw-psych` account. To redeploy after making changes:

```r
library(rsconnect)
rsconnect::deployApp()
```

---

## Dataset Details

The generated dataset (`dat`) contains 100 rows with the following columns:

| Column | Description |
|---|---|
| `subID` | Participant identifier (1–100) |
| `group` | Group assignment (1 or 2; 50 participants per group) |
| `v1` | Continuous variable 1 (rescaled to roughly 0.2–0.95) |
| `v2` | Continuous variable 2 (correlated with v1; rescaled to 0.1–0.9) |

The seed is set via `set.seed(zID)` at the start of `dataGen()`, ensuring every student receives a unique but fully reproducible dataset.

---

## Related Repositories

- [PSYC2001 Computing Lab Book](https://github.com/garner-code/PSYC2001_ComputingLabBook) — example analysis code that students follow in the labs.
