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




![image](https://github.com/user-attachments/assets/3213db82-8d95-4051-a241-7eec06814910)


![image](https://github.com/user-attachments/assets/1e2b11c0-6308-4ec7-8929-817e3b8dc996)


![image](https://github.com/user-attachments/assets/b6f738d4-912a-423d-ac80-55d76828f09e)


![image](https://github.com/user-attachments/assets/85ebdee7-d5be-483c-a4b2-38f1926ff491)


![image](https://github.com/user-attachments/assets/acfa9441-22af-498c-a309-5fedc04d99da)


![image](https://github.com/user-attachments/assets/ece4529f-8885-48cd-926a-7166c1a41726)


![image](https://github.com/user-attachments/assets/10f0ba93-af16-49b9-9bd1-aa4b7e6feb89)


![image](https://github.com/user-attachments/assets/0a3bc402-ce1c-45de-af20-940c7a339872)


![image](https://github.com/user-attachments/assets/f002874f-2c76-43a1-99c9-3521d9692701)


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
