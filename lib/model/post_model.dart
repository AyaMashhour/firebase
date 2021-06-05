class PostModel {
  String name;
  String image;
  String uid;

  String dateTime;

  String text;

  String imagePost;

  PostModel({
    this.name,
    this.text,
    this.uid,
    this.image,
    this.imagePost,
    this.dateTime,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    name = json['name'];
    image = json['image'];

    uid = json['uid'];
    imagePost = json['imagePost'];
      dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'imagePost': imagePost,
      'dateTime': dateTime,
      'image':image,
      'text': text,
    };
  }
}
