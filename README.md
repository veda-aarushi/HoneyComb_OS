@@ -1,16 +1,66 @@


# my_updated_flashcard_app


# 🐻 HoneyComb_OS: A Bear-Themed AI-Powered Flashcards App for Focused Learning




A new Flutter project.


**HoneyComb_OS** is a warm and whimsical bear-themed flashcard app built with Flutter — combining the charm of cozy UI with the intelligence of AI-driven learning.





![image](https://github.com/user-attachments/assets/3213db82-8d95-4051-a241-7eec06814910)


![image](https://github.com/user-attachments/assets/1e2b11c0-6308-4ec7-8929-817e3b8dc996)


![image](https://github.com/user-attachments/assets/b6f738d4-912a-423d-ac80-55d76828f09e)


![image](https://github.com/user-attachments/assets/85ebdee7-d5be-483c-a4b2-38f1926ff491)


![image](https://github.com/user-attachments/assets/acfa9441-22af-498c-a309-5fedc04d99da)


![image](https://github.com/user-attachments/assets/ece4529f-8885-48cd-926a-7166c1a41726)


![image](https://github.com/user-attachments/assets/10f0ba93-af16-49b9-9bd1-aa4b7e6feb89)


![image](https://github.com/user-attachments/assets/0a3bc402-ce1c-45de-af20-940c7a339872)


![image](https://github.com/user-attachments/assets/f002874f-2c76-43a1-99c9-3521d9692701)




## Getting Started


Unlike typical flashcard apps, HoneyComb_OS doesn't just quiz you — it *learns from you*. Using AI to detect which cards you struggle with most, it applies **spaced repetition** techniques to optimize your long-term memory retention.




This project is a starting point for a Flutter application.


---




A few resources to get you started if this is your first Flutter project:


## ✨ Features




- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)


- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


### 🧠 AI-Powered Learning Insights


- Tracks your interactions with each flashcard to detect struggle patterns.


- AI intelligently surfaces weaker cards more frequently for review.


- Learns and adapts to your progress — just like a smart study buddy.




For help getting started with Flutter development, view the


[online documentation](https://docs.flutter.dev/), which offers tutorials,


samples, guidance on mobile development, and a full API reference.


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
