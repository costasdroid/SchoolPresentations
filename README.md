# SchoolPresentations

Παρουσιάσεις μαθηματικών (και φυσικής) Λυκείου στα Ελληνικά, φτιαγμένες με LaTeX Beamer.
Δημιουργός: **Κωνσταντίνος Λόλας** — 10ο ΓΕΛ Θεσσαλονίκης.

Αποθετήριο: [https://github.com/costasdroid/SchoolPresentations](https://github.com/costasdroid/SchoolPresentations)

---

## Δομή αποθετηρίου

```
presentation.cls        ← Κεντρικό custom Beamer class (version 2.7)
Α Λυκείου/              ← Παρουσιάσεις Α΄ Λυκείου
  presentation.cls      ← Τοπικό cls (κληρονομεί από root)
  ...
Β Λυκείου/              ← Παρουσιάσεις Β΄ Λυκείου
  presentation.cls
  ...
Γ Λυκείου/              ← Παρουσιάσεις Γ΄ Λυκείου
  presentation.cls
  ...
Φυσική/                 ← Παρουσιάσεις Φυσικής
  presentation.cls
  ...
```

Κάθε φάκελος τάξης:

- Περιέχει το δικό του `presentation.cls` (κληρονομεί / εξειδικεύει το root)
- Όλα τα `.tex` αρχεία βρίσκονται **επίπεδα** (flat) στον φάκελο — χωρίς υποφακέλους ανά θέμα
- Ονοματολογία: `κεφάλαιο.ενότητα[.υποενότητα] Τίτλος.tex` (π.χ. `2.5.1 Θεώρημα Rolle.tex`)

---

## Workflow: Fork → Clone → Αλλαγές → Push

### 1. Fork

Μπες στη σελίδα του αποθετηρίου στο GitHub:
[https://github.com/costasdroid/SchoolPresentations](https://github.com/costasdroid/SchoolPresentations)

Κάνε κλικ στο κουμπί **Fork** (πάνω δεξιά). Το GitHub θα δημιουργήσει ένα προσωπικό αντίγραφο στο λογαριασμό σου.

### 2. Clone

```bash
git clone https://github.com/<your-username>/SchoolPresentations.git
cd SchoolPresentations
```

### 3. Δημιουργία branch (προαιρετικό αλλά προτεινόμενο)

```bash
git checkout -b new-presentation
```

### 4. Αλλαγές

Δημιούργησε ή επεξεργάσου `.tex` αρχεία σύμφωνα με τις οδηγίες παρακάτω. Μόλις τελειώσεις:

```bash
git add .
git commit -m "Add: 3.6 Τριγωνομετρικές Ανισώσεις"
```

### 5. Push

```bash
git push origin new-presentation
```

Αν δουλεύεις απευθείας στο `master`:

```bash
git push origin master
```

### 6. Pull Request (για συνεισφορά στο πρωτότυπο)

Αν θέλεις να προτείνεις τις αλλαγές σου στο αρχικό αποθετήριο, άνοιξε **Pull Request** από το GitHub UI του fork σου.

### 7. Συγχρονισμός με το upstream (αν έχεις κάνει fork)

```bash
git remote add upstream https://github.com/costasdroid/SchoolPresentations.git
git fetch upstream
git merge upstream/master
```

---

## LaTeX — Οδηγίες συγγραφής

### Απαιτήσεις συστήματος

| Εργαλείο         | Έκδοση                                                  |
| ---------------- | ------------------------------------------------------- |
| TeX distribution | TeX Live 2022+ ή MiKTeX                                 |
| Compiler         | **XeLaTeX**                                             |
| Build tool       | **latexmk**                                             |
| Γραμματοσειρά    | **Calibri** (πρέπει να είναι εγκατεστημένη στο σύστημα) |

Απαιτούμενα πακέτα LaTeX (περιλαμβάνονται συνήθως στο TeX Live full):
`beamer`, `fontspec`, `unicode-math`, `xltxtra`, `xgreek`, `tikz`, `pgfplots`, `tkz-tab`, `polynom`, `multicol`, `appendixnumberbeamer`, `cancel`, `pgffor`, `ifthen`, `ulem`, `hyperref`

### Boilerplate νέας παρουσίασης

```latex
\documentclass{presentation}

\title{Τίτλος στα Ελληνικά}
\subtitle{Υπότιτλος}
\author[Λόλας]{Κωνσταντίνος Λόλας}
\institute[$10^ο$ ΓΕΛ]{$10^ο$ ΓΕΛ Θεσσαλονίκης}

\begin{document}

\begin{frame}
  \titlepage
\end{frame}

\section{Θεωρία}

% frames θεωρίας...

\moodle

\section{Ασκήσεις}

\exercises

\begin{askisi}
  Κείμενο άσκησης...
\end{askisi}

\end{document}
```

> **Σημαντικό:** Πάντα `\documentclass{presentation}` — χωρίς relative path. Δεν χρησιμοποιείται `\date{}`.

### Custom εντολές & περιβάλλοντα

| Εντολή / Περιβάλλον                         | Περιγραφή                    |
| ------------------------------------------- | ---------------------------- |
| `\exercises`                                | Frame-διαχωριστής "Ασκήσεις" |
| `\moodle`                                   | Frame με οδηγία για Moodle   |
| `\begin{askisi}...\end{askisi}`             | Άσκηση (αυτόματη αρίθμηση)   |
| `\begin{lisi}...\end{lisi}`                 | Λύση (αυτόματη αρίθμηση)     |
| `\begin{apodiksi}[τίτλος]...\end{apodiksi}` | Απόδειξη (αυτόματη αρίθμηση) |
| `\begin{block}{Τίτλος}...\end{block}`       | Θεώρημα / Ορισμός            |

### Progressive reveal

```latex
\begin{itemize}
  \item<1-> Πρώτο σημείο
  \item<2-> Δεύτερο σημείο
  \item<3-> Τρίτο σημείο
\end{itemize}

% Ή αυτόματα:
\begin{enumerate}[<+->]
  \item Πρώτο
  \item Δεύτερο
\end{enumerate}
```

### Piecewise συνάρτηση

```latex
f(x)=\begin{cases}
  x^2+2, & x<2 \\
  \frac{2}{\sin x}, & x>5
\end{cases}
```

### Σύστημα εξισώσεων

```latex
\begin{cases}
  2x+y=4 \\
  5x+2y=10
\end{cases}
```

### Ονοματολογία αρχείων

`κεφάλαιο.ενότητα[.υποενότητα] Τίτλος.tex`

Παραδείγματα:

- `2.1 Παράγωγος.tex`
- `2.5.1 Θεώρημα Rolle.tex`
- `3.3 Αναγωγή στο 1ο Τεταρτημόριο.tex`

### Αρχεία που αγνοούνται (`.gitignore`)

Το `.gitignore` αποκλείει αυτόματα όλα τα generated αρχεία του LaTeX:
`.aux`, `.log`, `.nav`, `.snm`, `.synctex.gz`, `.fdb_latexmk`, `.pdf`, κλπ.

**Μην κάνεις commit** generated αρχεία.

---

## VS Code — Ρύθμιση & Extensions

### Απαιτούμενα extensions

#### 1. LaTeX Workshop

**ID:** `James-Yu.latex-workshop`
Το βασικό extension για LaTeX. Παρέχει compile on save, SyncTeX (μετάβαση PDF ↔ κώδικας), syntax highlighting, IntelliSense για εντολές.

#### 2. LTeX – Grammar/Spell Checker

**ID:** `valentjn.vscode-ltex`
Ορθογραφικός και γραμματικός έλεγχος για Ελληνικά (και άλλες γλώσσες) μέσα σε LaTeX αρχεία.

#### 3. GitHub Copilot _(προαιρετικό)_

**ID:** `GitHub.copilot`
AI autocomplete — χρήσιμο για επαναλαμβανόμενα LaTeX patterns.

---

### Ρύθμιση LaTeX Workshop

Πρόσθεσε τα παρακάτω στο αρχείο `settings.json` του VS Code (File → Preferences → Settings → Open Settings JSON):

```json
{
  "latex-workshop.latex.tools": [
    {
      "name": "xelatex",
      "command": "xelatex",
      "args": [
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    },
    {
      "name": "latexmk-xelatex",
      "command": "latexmk",
      "args": [
        "-xelatex",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-file-line-error",
        "%DOC%"
      ]
    }
  ],
  "latex-workshop.latex.recipes": [
    {
      "name": "latexmk (xelatex)",
      "tools": ["latexmk-xelatex"]
    },
    {
      "name": "xelatex",
      "tools": ["xelatex"]
    }
  ],
  "latex-workshop.latex.recipe.default": "latexmk (xelatex)",
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.synctex.afterBuild.enabled": true,
  "latex-workshop.latex.autoBuild.run": "onSave",
  "latex-workshop.latex.clean.fileTypes": [
    "*.aux",
    "*.bbl",
    "*.blg",
    "*.idx",
    "*.ind",
    "*.lof",
    "*.lot",
    "*.out",
    "*.toc",
    "*.acn",
    "*.acr",
    "*.alg",
    "*.glg",
    "*.glo",
    "*.gls",
    "*.ist",
    "*.fls",
    "*.log",
    "*.fdb_latexmk",
    "*.nav",
    "*.snm",
    "*.synctex.gz"
  ]
}
```

### Χρήσιμα shortcuts (LaTeX Workshop)

| Συντόμευση           | Ενέργεια                  |
| -------------------- | ------------------------- |
| `Ctrl+Alt+B`         | Build (compile)           |
| `Ctrl+Alt+V`         | Άνοιγμα PDF viewer        |
| `Ctrl+Alt+J`         | SyncTeX: από κώδικα → PDF |
| `Ctrl+Click` στο PDF | SyncTeX: από PDF → κώδικα |
| `Ctrl+Alt+C`         | Clean auxiliary files     |

### Ρύθμιση LTeX (Ελληνική ορθογραφία)

```json
{
  "ltex.language": "el",
  "ltex.enabled": ["latex"]
}
```

---

## Σημειώσεις

- Η `presentation.cls` βρίσκεται τόσο στο root όσο και σε κάθε φάκελο τάξης. Το XeLaTeX βρίσκει αυτόματα το σωστό αρχείο αν το κάθε `.tex` μεταγλωττίζεται από τον φάκελο του.
- Η τρέχουσα έκδοση του class είναι **2.7**. Η έκδοση εμφανίζεται αυτόματα στην title slide δίπλα στην ημερομηνία.
- Όλο το περιεχόμενο γράφεται στα **Ελληνικά** — τίτλοι, σχόλια, εντολές.

## Άδεια χρήσης

[![CC BY-SA 4.0](https://licensebuttons.net/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)

Το περιεχόμενο αυτού του αποθετηρίου διατίθεται υπό την άδεια
**Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)**.

Αυτό σημαίνει ότι μπορείς ελεύθερα να:

- **Μοιραστείς** — αντιγράψεις και αναδιανείμεις το υλικό σε οποιοδήποτε μέσο ή μορφή
- **Προσαρμόσεις** — αναμείξεις, μετασχηματίσεις και δημιουργήσεις νέο υλικό πάνω σε αυτό

Με τους εξής όρους:

- **Αναφορά (BY)** — Πρέπει να αναφέρεις τον δημιουργό (Κωνσταντίνος Λόλας) και να παρέχεις σύνδεσμο στην άδεια
- **Ίδια Άδεια (SA)** — Αν αναμείξεις ή προσαρμόσεις το υλικό, πρέπει να διανείμεις τη συνεισφορά σου υπό την **ίδια άδεια**

Πλήρης άδεια: [https://creativecommons.org/licenses/by-sa/4.0/](https://creativecommons.org/licenses/by-sa/4.0/)
