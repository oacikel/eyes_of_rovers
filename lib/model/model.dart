import 'package:eyes_of_rovers/model/enum.dart';
import 'package:flutter/cupertino.dart';

abstract class NasaImage {
  eRoverName getRoverName();
  List<eCamera> getCameras();
  final DateTime earthDate;
  final int marsDate;
  final String photoUrl;

  NasaImage(this.earthDate, this.marsDate, this.photoUrl);
}

class CuriosityImage extends NasaImage{
  CuriosityImage(DateTime earthDate, int marsDate, String photoImage) : super(earthDate, marsDate, photoImage);

  @override
  eRoverName getRoverName() {
  return eRoverName.ROVER_CURIOSITY;
  }

  @override
  List<eCamera> getCameras() {
   return [eCamera.FHAZ,eCamera.RHAZ,eCamera.MAST,eCamera.CHEMCAM,eCamera.MAHLI,eCamera.MARDI,eCamera.NAVCAM];
  }
}

class OpportunityImage extends NasaImage{
  OpportunityImage(DateTime earthDate, int marsDate, String photoImage) : super(earthDate, marsDate, photoImage);

  @override
  eRoverName getRoverName() {
    return eRoverName.ROVER_OPPORTUNITY;
  }

  @override
  List<eCamera> getCameras() {
    return [eCamera.FHAZ,eCamera.RHAZ,eCamera.NAVCAM,eCamera.PANCAM,eCamera.MINITES];
  }
}

class SpiritImage extends NasaImage{
  SpiritImage(DateTime earthDate, int marsDate, String photoImage) : super(earthDate, marsDate, photoImage);

  @override
  eRoverName getRoverName() {
    return eRoverName.ROVER_SPIRIT;
  }

  @override
  List<eCamera> getCameras() {
    return [eCamera.FHAZ,eCamera.RHAZ,eCamera.NAVCAM,eCamera.PANCAM,eCamera.MINITES];
  }
}