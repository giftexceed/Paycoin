import 'package:flutter/material.dart';

import 'texts.dart';

class Services {
  Widget sectionHeader({
    required String title,
    required IconData icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: sectionHeaderStyle,
        ),
        Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
      ],
    );
  }

  Widget loading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: 30,
              child: Text('MW', style: welcomeStyle)),
        ),
        const SizedBox(height: 10 / 2),
        const Text(
          'loading...',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }

  // scaffold messenger
  scaffoldMessage(context, message) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: Colors.white, width: 2),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      );
  }

  Widget noInternet({bool isDeviceConnected = false, void Function()? onTap}) {
    return Center(
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(left: 30, right: 30),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off,
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              'No internet connection...',
              style: sectionHeaderStyle,
            ),
            const SizedBox(height: 10),
            Text(
              'Check your internet connection to stream music!',
              style: sectionHeaderSub,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 11, 85, 11),
                      Color.fromARGB(255, 7, 19, 7)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Refresh',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  shaderMask() {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0)
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightGreen.shade200,
              Colors.lightGreen.shade600,
              const Color.fromARGB(255, 57, 96, 16),
              const Color.fromARGB(255, 22, 48, 2),
              const Color.fromARGB(255, 13, 14, 14),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  navigation({required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          top: 30,
          right: 20,
        ),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget coverPage({
    required String coverImage,
    required void Function()? onTap,
    required String text,
    required BuildContext context,
  }) {
    bool isLoading = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 125,
                  width: 135,
                  margin: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Stack(
                    children: [
                      Image.network(
                        coverImage,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            isLoading = false;
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(coverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else if (isLoading) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey,
                                ),
                                child: const Icon(
                                  Icons.hourglass_empty,
                                  size: 80,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(coverImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.white,
                              size: 45,
                            ),
                          );
                        },
                      ),
                      const Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.play_circle,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  //cover rows
  Widget coverRows({
    required String coverImage,
    required void Function()? onTap,
    required String text,
    required BuildContext context,
  }) {
    bool isLoading = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Stack(
                  children: [
                    Image.network(
                      coverImage,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          isLoading = false;
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(coverImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        } else if (isLoading) {
                          return Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                              child: const Icon(
                                Icons.hourglass_empty,
                                // color: Colors.white,
                                size: 70,
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(coverImage),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 35,
                          ),
                        );
                      },
                    ),
                    const Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.play_circle,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  //gridpage
  Widget gridPage({
    required String coverImage,
    required void Function()? onTap,
    required String text,
  }) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(
            top: 5,
            bottom: 5,
          ),
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(5)),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              coverImage.isNotEmpty
                  ? Image.network(
                      coverImage,
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                            child: const Icon(
                              Icons.hourglass_empty,
                              // color: Colors.white,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: const Icon(
                          Icons.hourglass_empty,
                          // color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
