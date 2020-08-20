class Person {
  String title;
  String nidDontUse;
  String fieldPhotoImageSection;
  String path;
  String nid;

  Person(
      {this.title,
        this.nidDontUse,
        this.fieldPhotoImageSection,
        this.path,
        this.nid});

  Person.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    nidDontUse = json['nid_dont_use'];
    fieldPhotoImageSection = json['field_photo_image_section'];
    path = json['path'];
    nid = json['nid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['nid_dont_use'] = this.nidDontUse;
    data['field_photo_image_section'] = this.fieldPhotoImageSection;
    data['path'] = this.path;
    data['nid'] = this.nid;
    return data;
  }
}