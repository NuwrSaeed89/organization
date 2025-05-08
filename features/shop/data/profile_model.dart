import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileModel {
  String? userId;
  String organizationName;
  String bio;
  String bannerImage;
  String profileImage;
  bool isOrganization;
  String website;
  String youtube;
  String x;
  String facebook;
  String instagram;
  String linkedIn;
  ProfileModel({
    this.organizationName = '',
    userId = '',
    this.bio = '',
    this.bannerImage = '',
    this.profileImage = '',
    this.isOrganization = false,
    this.website = '',
    this.youtube = '',
    this.x = '',
    this.facebook = '',
    this.instagram = '',
    this.linkedIn = '',
  });

  factory ProfileModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return ProfileModel.empty();
    final map = document.data()!;
    return ProfileModel(
        organizationName: map['organizationName'] as String,
        bio: map['bio'] as String,
        bannerImage: map['bannerImage'] as String,
        profileImage: map['profileImage'] as String,
        isOrganization: map['isOrganization'] as bool,
        website: map['website'] as String,
        youtube: map['youtube'] as String,
        x: map['x'] as String,
        facebook: map['facebook'] as String,
        instagram: map['instagram'] as String,
        linkedIn: map['linkedIn'] as String);
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) => ProfileModel(
      organizationName: map['organizationName'] ?? '',
      bio: map['bio'] ?? '',
      bannerImage: map['bannerImage'] ?? '',
      profileImage: map['profileImage'] ?? '',
      isOrganization: map['isOrganization'] ?? false,
      website: map['website'] ?? '',
      youtube: map['youtube'] ?? '',
      x: map['x'] ?? '',
      facebook: map['facebook'] ?? '',
      instagram: map['instagram'] ?? '',
      linkedIn: map['linkedIn'] ?? '');

  toJson() {
    return {
      'organizationName': organizationName,
      'bio': bio,
      'bannerImage': bannerImage,
      'profileImage': profileImage,
      'isOrganization': isOrganization,
      'website': website,
      'youtube': youtube,
      'x': x,
      'facebook': facebook,
      'instagram': instagram,
      'linkedIn': linkedIn,
    };
  }

  static ProfileModel empty() => ProfileModel();
}
