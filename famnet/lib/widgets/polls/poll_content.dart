//poll_content.dart
//declare Poll class

class Poll {
  String group;
  String topic;
  String option;
<<<<<<< HEAD
  List<String> options = []; 
=======
  List<String> options = List<String>(); 
>>>>>>> upstream/master

  Poll({this.group = "Default group", this.topic = '', this.option = ''});
}