/// Model class for onboarding page
class OnboardingPageModel {
  /// Constructor for OnboardingPageModel
  OnboardingPageModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });

  /// Path to the image file
  final String imagePath;

  /// Page title
  final String title;

  /// Page description
  final String description;
}
