import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';
import 'appshimmereffect.dart';





class RoundedImage extends StatelessWidget {
   RoundedImage({
    super.key,
    this.width ,
    this.height = 200 ,
    required this.imageUrl,
    this.applyImageRaius = true,
    this.border,
    this.backgroundColor ,
    this.fit = BoxFit.cover,
    this.padding = const EdgeInsets.all(AppSizes.defaultspace) ,
    this.isNetworkImage = false,
    this.onpressed, this.borderRadius = AppSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRaius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry padding;
  final bool isNetworkImage;
  final VoidCallback? onpressed;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Padding(
        padding: padding,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ClipRRect(
              borderRadius: applyImageRaius
                  ? BorderRadius.circular(borderRadius)
                  : BorderRadius.zero,
              child: isNetworkImage
              ? CachedNetworkImage(
                fit: fit,
                  imageUrl: imageUrl,
                progressIndicatorBuilder: (context,url,downloadProgress) => AppShimmerEffect(width: width ?? 10, height: height ?? 10,radius: borderRadius,),
                errorWidget: (context, url,error) => Icon(Icons.error),
              )
              :Image(
                image: AssetImage(imageUrl) as ImageProvider,
                fit: fit,
              )),
        ),
      ),
    );
  }
}
