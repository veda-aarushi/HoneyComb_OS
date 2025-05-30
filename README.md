# 🐻 HoneyComb\_OS

> **A cozy, bear‑themed flashcard app that learns *****with***** you**

HoneyComb\_OS combines a comforting visual style with AI‑powered spaced‑repetition to make studying feel less like a chore and more like a warm cup of honey‑infused tea.

---

## ✨ Features

| Category                | Highlights                                                                                                                     |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| **AI‑Powered Learning** | • Detect struggle patterns and resurface weak cards automatically.<br>• Adapt study intervals using spaced‑repetition science. |
| **Memory Game Mode**    | • Playful matching game makes review fun.<br>• Strengthens visual recall and engagement.                                       |
| **Bear‑Inspired UI**    | • Calming honeycomb palette & charming bear mascots.<br>• Clean, accessible layouts optimized for mobile.                      |
| **Organized Lessons**   | • Create unlimited lessons and decks.<br>• All content synced securely to Firestore.                                           |
| **Secure & Private**    | • You retain full control of your data.<br>• Google sign‑in is optional, not required.                                         |

---

## 🖼 Screenshots

|   |   |
| - | - |
|   |   |
|   |   |
|   |   |
|   |   |
|   |   |

---

## 🛠 Tech Stack

| Layer            | Technologies                                       |
| ---------------- | -------------------------------------------------- |
| **Frontend**     | Flutter (Dart)                                     |
| **Backend**      | Firebase Firestore · Firebase Auth                 |
| **AI Engine**    | Local inference + OpenAI (via **flutter\_dotenv**) |
| **Storage**      | Firestore collections (Lessons & Cards)            |
| **Architecture** | MVVM (Model · View · ViewModel)                    |

---

## 🚀 Getting Started

```bash
# 1. Clone
$ git clone https://github.com/veda-aarushi/HoneyComb_OS.git
$ cd HoneyComb_OS

# 2. Install dependencies
$ flutter pub get

# 3. Run the app (emulator or device)
$ flutter run
```

### Prerequisites

* Flutter 3.19+ with Dart 3
* A configured Firebase project (see `firebase/`)

---

## 🔐 Environment Variables

Create a `.env` file in the project root (never commit this file):

```ini
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Add `.env` to your `.gitignore` to keep your key safe.

---

## 📁 Project Structure

```
lib/
├── model/         # Data classes: FlashCard, Lesson, User
├── view/          # UI widgets: flashcards, memory game, navigation
├── viewmodel/     # Learning logic, spaced repetition, routing
├── services/      # Firebase wrappers, AI engine hooks
└── utils/         # Themes, constants, helper functions
```

---

## 🤝 Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b feat/amazing-feature`)
3. Commit changes (`git commit -m 'feat: Add amazing feature'`)
4. Push to branch (`git push origin feat/amazing-feature`)
5. Open a Pull Request

All PRs require passing CI and at least one approval.

---

## 📜 License

HoneyComb\_OS is released under the MIT License — see `LICENSE` for details.

---

Made with 🐻 & 🍯 by **Veda Aarushi** and contributors.

---

## 🗺 Roadmap

| Release                         | Target Date     | Key Deliverables                                                                                                          | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **v0.1 “Cub”**                  | **May 2025 ✓**  | - Flutter scaffold & theming<br>- Firebase Auth sign‑in/out<br>- Bear mascot & honey palette                               |                                 |                 |
| **v0.2 “Hive”**                 | **Jun 2025 ✓**  |  - Flashcard CRUD (create/edit/delete)<br>- Memory‑Game MVP<br>- Firestore schema finalized                                
|                                 |                 |
| **v0.3 “Forager”**              | **Jul 2025**    | - On‑device spaced‑repetition engine (Hive cache)<br>- Basic AI insight service (local heuristics)<br>- Dark‑mode &         |                                 |                 |    accessibility polish              
| **v0.5 “Swarm” – Closed Beta**  | **15 Aug 2025** | - Play Store internal testing release<br>- In‑app onboarding & permission flows<br>- Crashlytics + basic analytics          |                                 |                 |
| **v0.8 “Keeper” – Public Beta** | **Sep 2025**    | - AI‑powered weak‑card resurfacing<br>- Lesson sharing (read‑only)<br>- Offline progress sync                               |                                 |                 |
| **v1.0 “Harvest” – Stable**     | **Oct 2025**    | - Full multi‑user lesson creation & sharing<br>- Themed study streaks & gamification<br>- CI/CD → GitHub Actions + Firebase |                                 |                 |       + App Distribution                                                                                                    |                                 |                 |
| **v1.x Future**                 | *TBD*           | - Dual‑Password (normal vs. decoy)<br>- AI‑Decoy Mode (fake UI, silent SOS)<br>- Social “study hive” real‑time              |                                 |                 |   sessions<br>- Export flashcards to Anki/CSV 
