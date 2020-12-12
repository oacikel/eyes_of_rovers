enum eRoverName {
  ROVER_CURIOSITY,
  ROVER_OPPORTUNITY,
  ROVER_SPIRIT
}

enum eCamera {
  FHAZ,
  RHAZ,
  MAST,
  CHEMCAM,
  MAHLI,
  MARDI,
  NAVCAM,
  PANCAM,
  MINITES

}

String getCameraName(eCamera camera){
  switch (camera){

    case eCamera.FHAZ:
      return "Front Hazard Avoidance Camera";
      break;
    case eCamera.RHAZ:
      return "Rear Hazard Avoidance Camera";
      break;
    case eCamera.MAST:
      return "Mast Camera";
      break;
    case eCamera.CHEMCAM:
      return "Chemistry and Camera Complex";
      break;
    case eCamera.MAHLI:
      return "Mars Hand Lens Imager";
      break;
    case eCamera.MARDI:
      return "Mars Descent Imager";
      break;
    case eCamera.NAVCAM:
      return "Navigation Camera";
      break;
    case eCamera.PANCAM:
      return "Panoramic Camera";
      break;
    case eCamera.MINITES:
      return "Miniature Thermal Emission";
      break;
  }
}


