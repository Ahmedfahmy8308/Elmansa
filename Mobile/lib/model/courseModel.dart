class CourseModel {
  String? heading;
  String? image;
  String? courseLink;
  String? succesRate;
  CourseModel({this.heading, this.image, this.courseLink, this.succesRate});
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      heading: json['heading'],
      image: json['image'],
      courseLink: json['courseLink'],
      succesRate: json['successRate'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "heading": this.heading,
      "image": this.image,
      "courseLink": this.courseLink,
      "successRate": this.succesRate,
    };
  }
}
