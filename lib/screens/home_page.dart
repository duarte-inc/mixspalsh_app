import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unspalsh_app/controller/home_contoller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 5.0, left: 30, right: 30, bottom: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icon.png",
                        fit: BoxFit.cover,
                        width: 45,
                        height: 40,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "MIXPLASH",
                        style: GoogleFonts.bebasNeue(
                          color: Colors.black,
                          fontSize: 30,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                // TODO:Impement Search here
                SizedBox(height: 5),
                Text(
                  "Explore",
                  style: GoogleFonts.bebasNeue(
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  child: Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.topicModel.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.toNamed("/topics", arguments: [
                            index,
                            "${controller.topicModel[index].id}",
                          ]);
                          // "${controller.topicModel[index].id}",
                          // "${controller.topicModel[index].title}",
                          // "${controller.topicModel[index].coverPhoto.urls.small}",
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 7),
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${controller.topicModel[index].coverPhoto.urls.regular}"),
                              fit: BoxFit.cover,
                              colorFilter: new ColorFilter.mode(
                                  Colors.black.withOpacity(0.7),
                                  BlendMode.dstATop),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "${controller.topicModel[index].title}",
                              style: GoogleFonts.bebasNeue(
                                color: Colors.white,
                                letterSpacing: 10,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Popular",
                  style: GoogleFonts.bebasNeue(
                    letterSpacing: 2,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Obx(() => StaggeredGridView.countBuilder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        itemCount: controller.photoModel.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                          onTap: () {
                            Get.toNamed("/details", arguments: [
                              "${controller.photoModel[index].description}",
                              "${controller.photoModel[index].urls.regular}",
                              "${controller.photoModel[index].user.name}",
                              "${controller.photoModel[index].likes}",
                              "${controller.photoModel[index].altDescription}",
                              "${controller.photoModel[index].user.profileImage.medium}",
                              "${controller.photoModel[index].user.location}",
                              "${controller.photoModel[index].id}"
                            ]);
                          },
                          child: new Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: new NetworkImage(
                                      "${controller.photoModel[index].urls.regular}"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.count(2, index.isEven ? 4 : 3),
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
