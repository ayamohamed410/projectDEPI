import '../../../core/constants/assets_app.dart';

class OnboardingModel {
  String image;
  String header;
  String? description;

  OnboardingModel({
    required this.image,
    required this.header,
    this.description,
  });

  static List<OnboardingModel> onboardingList = [

    OnboardingModel(
      image: AssetsApp.onboardingOne,
      header: "Your Home, in Expert Hands.",
      description:
      "Home repairs made easy. Reliable help is just a tap away.",
    ),
    OnboardingModel(
      image: AssetsApp.onboardingTwo,
      header: "Describe Your Problem",
      description:
      "Tell us what needs fixing, from plumbing to electrical issues.",
    ),
    OnboardingModel(
      image: AssetsApp.onboardingThree,
      header: "Find the Right Expert",
      description:
      "Our smart assistant helps match your problem with the right technician.",
    ),
    OnboardingModel(
      image: AssetsApp.onboardingOne,
      header: "Choose Your Technician",
      description:
      "Compare nearby professionals and choose the right expert for you.",
    ),
    OnboardingModel(
      image: AssetsApp.onboardingOne,
      header: "Track Every Step",
      description:
      "Stay updated from request acceptance to arrival and job completion.",
    ),
    OnboardingModel(
      image: AssetsApp.onboardingSix,
      header: "Your Home, Sorted.",
      description:
      "Trusted technicians. Less stress. More comfort.",
    ),


  ];
}