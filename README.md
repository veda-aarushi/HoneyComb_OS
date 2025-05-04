# 🐻 HoneyComb_OS: A Bear-Themed AI-Powered Flashcards App for Focused Learning

**HoneyComb_OS** is a warm and whimsical bear-themed flashcard app built with Flutter — combining the charm of cozy UI with the intelligence of AI-driven learning.

Unlike typical flashcard apps, HoneyComb_OS doesn't just quiz you — it *learns from you*. Using AI to detect which cards you struggle with most, it applies **spaced repetition** techniques to optimize your long-term memory retention.

---

## ✨ Features

### 🧠 AI-Powered Learning Insights
- Tracks your interactions with each flashcard to detect struggle patterns.
- AI intelligently surfaces weaker cards more frequently for review.
- Learns and adapts to your progress — just like a smart study buddy.

### 🐾 Bear-Inspired UI & UX
- Delightful bear and honeycomb visual themes.
- Soothing interface designed to reduce anxiety and make studying fun.
- Clean, accessible layouts optimized for mobile learning.

### 🎮 Memory Game Mode
- Match cards in an engaging, interactive game.
- Strengthens recall and adds joy to the review process.
- Great for visual and kinesthetic learners.

### 📚 Organized Lessons
- Create your own lessons and decks.
- All data is securely stored in Firebase Firestore.
- Seamlessly browse, select, and study any topic.

---

## 🛠 Tech Stack

| Layer         | Tech                          |
|---------------|-------------------------------|
| Frontend      | Flutter (Dart)                |
| Backend       | Firebase Firestore, Firebase Auth |
| AI Engine     | Local + OpenAI-influenced logic (via `flutter_dotenv`) |
| Storage       | Firestore (Lessons, Cards)    |
| Architecture  | MVVM (Model-View-ViewModel)   |

---
### Views
![image](https://github.com/user-attachments/assets/6c74b411-d3fb-46ee-9ce8-57efe0df2997)
![image](https://github.com/user-attachments/assets/caa3718a-097e-47c2-98f7-cce827dc8f5f)


🚀 Getting Started

```bash
git clone https://github.com/veda-aarushi/HoneyComb_OS.git
cd HoneyComb_OS
flutter pub get
flutter run

🔐 .env Setup
To enable optional AI-based features:
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxx

📁 Folder Structure
bash
Copy
Edit
lib/
├── model/              # FlashCard, Lesson, User models
├── view/               # Flashcard UI, Memory game, Navigation views
├── viewmodel/          # Learning logic, spaced repetition, routing
├── services/           # Firebase integration, AI engine hooks
├── utils/              # Themes, constants, helpers
