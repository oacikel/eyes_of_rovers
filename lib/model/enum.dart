enum eRoverName {
  ROVER_CURIOSITY,
  ROVER_OPPORTUNITY,
  ROVER_SPIRIT
}

String getRoverNameForHTTP(eRoverName name){
  switch (name){

    case eRoverName.ROVER_CURIOSITY:
      return "curiosity";
      break;
    case eRoverName.ROVER_OPPORTUNITY:
      return "opportunity";
      break;
    case eRoverName.ROVER_SPIRIT:
      return "spirit";
      break;
  }
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

String getCameraNameForHTTP(eCamera camera){
  switch (camera){

    case eCamera.FHAZ:
      return "fhaz";
      break;
    case eCamera.RHAZ:
      return "rhaz";
      break;
    case eCamera.MAST:
      return "mast";
      break;
    case eCamera.CHEMCAM:
      return "chemcam";
      break;
    case eCamera.MAHLI:
      return "mahli";
      break;
    case eCamera.MARDI:
      return "mardi";
      break;
    case eCamera.NAVCAM:
      return "navcam";
      break;
    case eCamera.PANCAM:
      return "pancam";
      break;
    case eCamera.MINITES:
      return "minites";
      break;
  }
}


