class DummyMessageVO {
  String? message;
  bool? isMe;

  DummyMessageVO({required this.message, required this.isMe});

  @override
  String toString() {
    return 'DummyMessageVO{message: $message, isMe: $isMe}';
  }
}