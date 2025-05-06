class FlashCard {
  final String question;
  final String answer;
  int timesSeen;
  int timesCorrect;
  int timesWrong;
  bool isLastChoiceCorrect;

  FlashCard({
    required this.question,
    required this.answer,
    this.timesSeen = 0,
    this.timesCorrect = 0,
    this.timesWrong = 0,
    this.isLastChoiceCorrect = false,
  });

  // Factory to create from Firestore document
  factory FlashCard.fromMap(Map<String, dynamic> data) {
    return FlashCard(
      question: data['question'] ?? '',
      answer: data['answer'] ?? '',
      timesSeen: data['timesSeen'] ?? 0,
      timesCorrect: data['timesCorrect'] ?? 0,
      timesWrong: data['timesWrong'] ?? 0,
      isLastChoiceCorrect: data['isLastChoiceCorrect'] ?? false,
    );
  }

  // Optional: Convert back to Map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'timesSeen': timesSeen,
      'timesCorrect': timesCorrect,
      'timesWrong': timesWrong,
      'isLastChoiceCorrect': isLastChoiceCorrect,
    };
  }
}
