class ArticleModel {
  String topicHeader;
  String topicBody;
  String image;

  ArticleModel(this.topicHeader, this.topicBody, this.image);

  static List<ArticleModel> getData() {
    return [
      ArticleModel(
          "The Xcode Simulator is one of the tools used most widely by developers:",
          "Running and testing apps on the simulator has become part of every developer’s daily routine."
              " Becoming familiar with various simulator options is vital for any developer. Did you know"
              " you can create and configure simulators from the command line as well? In this tutorial, you’ll learn:"
              "What a simulator is"
              "Insights into useful simulator options"
              "To create and configure simulators from the command line"
              "To stream and capture logs using the command line"
              "To create a Bash script to automate launching the app on a simulator in different locales."
              "Getting Started"
              "Download the project by clicking the Download Materials button at the top or bottom of this page."
              " Open the RayWonders project. Build and run.  ",
          "images/ray1.png"),
      ArticleModel(
          "Pixel Accurate",
          "In this mode, the window size changes to the same number"
              " of pixels as the physical device. Each pixel on the simulated device maps"
              " to one pixel on your Mac’s display. This causes simulators to appear"
              " larger on screen if your Mac’s display has a lower pixel density than "
              "the simulated device. You can use this mode to check the alignment of images"
              " and controls in your app.",
          "images/ray2.png"),
      ArticleModel(
          "Slow Animations",
          "Animations are an integral part of an app experience."
              " Build and run RayWonders in the Demo simulator."
              "Tap the Photos tab. Next, tap a picture of one of the wonders of"
              "the world to present a view of details about the place. Dismiss the view by sliding it down."
              "To simulate slow animations, select the Debug ▸ Slow Animations option in the Simulator menu.,",
          "images/ray3.png"),
      ArticleModel(
          "Dark Mode",
          "provides a great viewing experience in low-light environments. "
              "The simulator provides an option to view your app in Dark Mode."
              "Select Features ▸ Toggle Appearance. This toggles the appearance "
              "to Dark Mode. Now, tap the Map tab in RayWonders.You’ll notice that"
              " the map has changed to a dark appearance. Easy, isn’t it? This is "
              "a handy way to test your app in Dark Mode."
              " To change the appearance back to default, deselect Features ▸ Toggle appearance."
              " To learn how to support Dark Mode",
          "images/ray4.png"),
      ArticleModel(
          "Sharing Locations From the Maps App",
          "The Maps app on macOS provides an easy way to share locations "
              "with your simulator."
              "Follow these steps:"
              " Open the Maps app."
              " Enter Machu Picchu in the search text."
              " Click the Share button next to the search field."
              "Choose Simulator from the drop-down."
              "In the location prompt, select Demo as the simulator.",
          "images/ray5.png")
    ];
  }
}
