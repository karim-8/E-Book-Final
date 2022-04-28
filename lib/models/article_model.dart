import 'package:gesturesfinalproject/utilities/constants.dart';

class ArticleModel {
  String topicHeader;
  String topicBody;
  String image;

  ArticleModel(this.topicHeader, this.topicBody, this.image);

  static List<ArticleModel> getData() {
    return [
      ArticleModel(Constants.xcodeSimulatorHeader, Constants.xcodeSimulatorBody,
          Constants.xcodeSimulatorImage),
      ArticleModel(
          Constants.pixelHeader, Constants.pixelBody, Constants.pixelImage),
      ArticleModel(Constants.animationHeader, Constants.animationBody,
          Constants.animationImage),
      ArticleModel(Constants.darkModeHeader, Constants.darkModeBody,
          Constants.darkModeImage),
      ArticleModel(Constants.sharingLocationHeader,
          Constants.sharingLocationBody, Constants.sharingLocationImage)
    ];
  }
}
