# SchoolPresentations

Παρουσιάσεις μαθηματικών (και φυσικής) Λυκείου στα Ελληνικά, φτιαγμένες με LaTeX Beamer.
Δημιουργός: **Κωνσταντίνος Λόλας** — 10ο ΓΕΛ Θεσσαλονίκης.

Αποθετήριο: [https://github.com/costasdroid/SchoolPresentations](https://github.com/costasdroid/SchoolPresentations)

---

## Γρήγορη εισαγωγή

Αυτό το αποθετήριο περιέχει έτοιμες παρουσιάσεις για την Α', Β' και Γ' Λυκείου και για Φυσική, με κοινό style και κοινή αρχιτεκτονική LaTeX/Beamer.

Το βασικό εργαλείο για να δουλέψεις σωστά είναι να ακολουθείς την ίδια δομή και τις ίδιες συμβάσεις σε όλα τα αρχεία.

---

## Δομή αποθετηρίου

```text
presentation.cls        ← Κεντρικό custom Beamer class (version 2.7)
Α Λυκείου/
  presentation.cls
  ...
Β Λυκείου/
  presentation.cls
  ...
Γ Λυκείου/
  presentation.cls
  ...
Φυσική/
  presentation.cls
  ...
```

Κάθε φάκελος τάξης:

- περιέχει το δικό του `presentation.cls` (κληρονομεί / εξειδικεύει το root)
- τα `.tex` αρχεία βρίσκονται απευθείας στον φάκελο ή σε κοινές θεματικές ομάδες
- δεν δημιουργούμε υποφάκελο για κάθε μεμονωμένη παρουσίαση
- η ονοματολογία είναι: `κεφάλαιο.ενότητα[.υποενότητα] Τίτλος.tex`

Παράδειγμα:

- `2.1 Παράγωγος.tex`
- `2.5.1 Θεώρημα Rolle.tex`
- `3.3 Αναγωγή στο 1ο Τεταρτημόριο.tex`

---

## Workflow: Fork → Clone → Αλλαγές → Push

### 1. Fork

Πήγαινε στο GitHub και κάνε fork στο δικό σου λογαριασμό:
[https://github.com/costasdroid/SchoolPresentations](https://github.com/costasdroid/SchoolPresentations)

### 2. Clone

```bash
git clone https://github.com/<your-username>/SchoolPresentations.git
cd SchoolPresentations
```

### 3. Δημιουργία branch

```bash
git checkout -b new-presentation
```

### 4. Αλλαγές

Δημιούργησε ή επεξεργάσου `.tex` αρχεία σύμφωνα με τις οδηγίες παρακάτω. Όταν τελειώσεις:

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

### 6. Pull Request

Άνοιξε Pull Request από το fork σου στο πρωτότυπο αποθετήριο.

### 7. Συγχρονισμός με το upstream

```bash
git remote add upstream https://github.com/costasdroid/SchoolPresentations.git
git fetch upstream
git merge upstream/master
```

---

## LaTeX — Οδηγίες συγγραφής

### Απαιτήσεις συστήματος

| Εργαλείο | Έκδοση |
| --- | --- |
| TeX distribution | TeX Live 2022+ ή MiKTeX |
| Compiler | **XeLaTeX** |
| Build tool | **latexmk** |
| Γραμματοσειρά | **Calibri** |

Απαιτούμενα πακέτα LaTeX (συνήθως περιλαμβάνονται στο TeX Live full):
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

> **Σημαντικό:** Πάντα `\documentclass{presentation}` χωρίς relative path. Δεν χρησιμοποιούμε `\date{}`.

### Custom εντολές & περιβάλλοντα

| Εντολή / Περιβάλλον | Περιγραφή |
| --- | --- |
| `\exercises` | Frame διαχωριστής "Ασκήσεις" |
| `\moodle` | Frame με οδηγία για Moodle |
| `\begin{askisi}...\end{askisi}` | Άσκηση (αυτόματη αρίθμηση) |
| `\begin{lisi}...\end{lisi}` | Λύση (αυτόματη αρίθμηση) |
| `\begin{apodiksi}[τίτλος]...\end{apodiksi}` | Απόδειξη (αυτόματη αρίθμηση) |
| `\begin{block}{Τίτλος}...\end{block}` | Θεώρημα / Ορισμός |

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

---

## Build & validation

Για να τρέξεις μια παρουσίαση από τον φάκελο του αρχείου:

```bash
xelatex -synctex=1 -interaction=nonstopmode -file-line-error "<όνομα-αρχείου>.tex"
```

Στο VS Code με LaTeX Workshop, το προεπιλεγμένο recipe είναι `xelatex` και περνά το basename του αρχείου από τον φάκελό του, ώστε να υποστηρίζονται κενά στο όνομα.

Πριν κάνεις commit:

- έλεγξε ότι το αρχείο χρησιμοποιεί σωστή ονοματολογία
- έλεγξε ότι το `\documentclass{presentation}` είναι σωστό
- έλεγξε ότι δεν έχεις αφήσει generated αρχεία (`.aux`, `.log`, `.nav`, `.pdf`, κλπ.) στο repo
- έλεγξε αν η παρουσίαση compiles χωρίς σφάλματα

---

## Αρχεία που αγνοούνται (`.gitignore`)

Το `.gitignore` αποκλείει αυτόματα όλα τα generated αρχεία του LaTeX:
`.aux`, `.log`, `.nav`, `.snm`, `.synctex.gz`, `.fdb_latexmk`, `.pdf`, κλπ.

**Μην κάνεις commit** generated αρχεία.

---

## VS Code — Ρύθμιση & Extensions

### Απαιτούμενα extensions

#### 1. LaTeX Workshop

**ID:** `James-Yu.latex-workshop`

#### 2. LTeX – Grammar/Spell Checker

**ID:** `valentjn.vscode-ltex`

#### 3. GitHub Copilot _(προαιρετικό)_

**ID:** `GitHub.copilot`

### Ρύθμιση LaTeX Workshop

Το ελάχιστο recipe στο `settings.json` του workspace είναι:

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
        "%DOCFILE_EXT%"
      ]
    }
  ],
  "latex-workshop.latex.workingDirectory": "%DIR%",
  "latex-workshop.latex.recipes": [
    {
      "name": "xelatex",
      "tools": ["xelatex"]
    }
  ],
  "latex-workshop.latex.recipe.default": "xelatex"
}
```

---

## Check-list πριν το commit

- [ ] σωστή ονοματολογία αρχείου
- [ ] σωστό `\documentclass{presentation}`
- [ ] δεν έχεις `\date{}`
- [ ] το περιεχόμενο είναι στα Ελληνικά
- [ ] τα frames είναι σύντομα και διδακτικά
- [ ] το άθροισμα / θεωρία / ασκήσεις είναι συνεπές
- [ ] η παρουσίαση compiles με XeLaTeX
- [ ] δεν έχεις generated αρχεία στο repo

---

## Μην...

- μην χρησιμοποιείς relative path στο `\documentclass`
- μην βάζεις `\date{}`
- μην δημιουργείς υποφάκελο για κάθε μεμονωμένη παρουσίαση
- μην επεξεργάζεσαι generated αρχεία
- μην γράφεις στα αγγλικά όταν το project είναι στα Ελληνικά
- μην αγνοείς τη δομή των υπαρχόντων υποφακέλων

---

## AI συγγραφική συμπεριφορά

Όταν δημιουργείς νέο εκπαιδευτικό υλικό:

- μιμήσου το ύφος των υπαρχουσών παρουσιάσεων
- χρησιμοποίησε ευρηματικούς τίτλους χωρίς να γεμίζεις κάθε frame με κείμενο
- κράτα σύντομο και προφορικό ύφος
- μην εισάγεις άσχετες τεχνικές ή ασκήσεις που δεν έχουν παρουσιαστεί
- συνέχισε τη σειρά και τη λογική των προηγούμενων διαφανειών

---

## Versioning

- το `presentation.cls` έχει version tracking
- η πληροφορία εμφανίζεται στην title slide

---

## Τελική παρατήρηση

Το repository λειτουργεί καλύτερα όταν η δομή, η ονοματολογία και ο τρόπος συγγραφής είναι συνεπείς σε όλα τα αρχεία. Αυτή η συνέπεια είναι που κάνει τα έτοιμα slides εύκολα να αναπαράγονται και να συντηρούνται.

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
