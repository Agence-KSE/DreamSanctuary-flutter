class Message {
  String username = "";
  String timestamp = "";
  String message = "";

  Message({required username, timestamp, message}) {
    this.username = username;
    this.timestamp = timestamp;
    this.message = message;
  }

  @override
  String toString() {
    return username + " - " + timestamp + " - " + message;
  }
}
