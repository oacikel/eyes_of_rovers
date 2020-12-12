import 'package:dio/dio.dart';
import 'package:eyes_of_rovers/model/enum.dart';
import 'package:eyes_of_rovers/model/model.dart';
import 'package:flutter/cupertino.dart';

class MockData {
  static DateTime _mockDate1 = DateTime(1989, 19, 10);
  static final String LOG_TAG = "OCULCAN - Mock Data: ";
  static final String API_KEY = "DEMO_KEY";
  Response _response;
  Dio _dio = new Dio();
  static final String SOL_PARAMETER = "sol";
  static final String EARTH_DATE_PARAMETER = "earth_date";
  static final String CAMERA_PARAMETER = "camera";
  static final String PAGE_PARAMETER = "page";
  static final String API_KEY_PARAMETER = "api_key";
  static final String IMAGE_URL_PARAMETER = "img_src";

  Future<List<NasaImage>> getListOfPhotos(
      eRoverName name, int sol, eCamera camera, int page) async {
    _response = await _dio.get(_generateBaseURL(name), queryParameters: {
      SOL_PARAMETER: sol,
      CAMERA_PARAMETER: getCameraNameForHTTP(camera),
      PAGE_PARAMETER: page,
      API_KEY_PARAMETER:API_KEY
    }).catchError((error) {
      debugPrint("${LOG_TAG} Caught error: ${error.toString()}");
    });
    debugPrint("${LOG_TAG} Retrieved list: ${_response.data}");
    List<NasaImage> photos=[];
    for(var photo in _response.data["photos"]){
        NasaImage image=NasaImage(photo[IMAGE_URL_PARAMETER]);
        photos.add(image);
    }
    return photos;
  }

  String _generateBaseURL(eRoverName name) {
    return "https://api.nasa.gov/mars-photos/api/v1/rovers/${getRoverNameForHTTP(name)}/photos";
  }

  static List<NasaImage> getMockCuriosityImages() {
    debugPrint("${LOG_TAG} Gathering mock curiosity images");
    return [
      CuriosityImage(_mockDate1, 101,
          "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG"),
      CuriosityImage(_mockDate1, 102,
          "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/fcam/FRB_486615455EDR_F0481570FHAZ00323M_.JPG"),
      CuriosityImage(_mockDate1, 103,
          "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/rcam/RLB_486615482EDR_F0481570RHAZ00323M_.JPG"),
      CuriosityImage(_mockDate1, 104,
          "http://mars.jpl.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01004/opgs/edr/rcam/RRB_486615482EDR_F0481570RHAZ00323M_.JPG"),
      CuriosityImage(_mockDate1, 101,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631090503669E02_DXXX.jpg"),
      CuriosityImage(_mockDate1, 102,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631100305207E01_DXXX.jpg"),
      CuriosityImage(_mockDate1, 103,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631100503670E02_DXXX.jpg"),
      CuriosityImage(_mockDate1, 104,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631110503671E02_DXXX.jpg"),
      CuriosityImage(_mockDate1, 101,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631120503672E01_DXXX.jpg"),
      CuriosityImage(_mockDate1, 102,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631120305209E02_DXXX.jpg"),
      CuriosityImage(_mockDate1, 103,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631130305210E01_DXXX.jpg"),
      CuriosityImage(_mockDate1, 104,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631130503673E01_DXXX.jpg"),
    ];
  }

  static List<NasaImage> getMockOpportunityImages() {
    debugPrint("${LOG_TAG} Gathering mock Oppurtunity images");
    return [
      OpportunityImage(_mockDate1, 105,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631300503690E01_DXXX.jpg"),
      OpportunityImage(_mockDate1, 106,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631300305227E03_DXXX.jpg"),
      OpportunityImage(_mockDate1, 107,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631140305211E02_DXXX.jpg"),
      OpportunityImage(_mockDate1, 108,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631140503674E01_DXXX.jpg"),
      OpportunityImage(_mockDate1, 105,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631300503690E01_DXXX.jpg"),
      OpportunityImage(_mockDate1, 106,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631150305212E01_DXXX.jpg"),
      OpportunityImage(_mockDate1, 107,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631150503675E02_DXXX.jpg"),
      OpportunityImage(_mockDate1, 108,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631160503676E02_DXXX.jpg"),
      OpportunityImage(_mockDate1, 105,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631170305214E01_DXXX.jpg"),
      OpportunityImage(_mockDate1, 106,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631170503677E03_DXXX.jpg"),
      OpportunityImage(_mockDate1, 107,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631180305215E01_DXXX.jpg"),
      OpportunityImage(_mockDate1, 108,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631180503678E01_DXXX.jpg"),
    ];
  }

  static List<NasaImage> getMockSpritImages() {
    debugPrint("${LOG_TAG} Gathering mock Spirit images");
    return [
      SpiritImage(_mockDate1, 105,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631190305216E04_DXXX.jpg"),
      SpiritImage(_mockDate1, 106,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631190503679E04_DXXX.jpg"),
      SpiritImage(_mockDate1, 107,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631200305217E01_DXXX.jpg"),
      SpiritImage(_mockDate1, 108,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631290305226E03_DXXX.jpg"),
      SpiritImage(_mockDate1, 105,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631300503690E01_DXXX.jpg"),
      SpiritImage(_mockDate1, 106,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631300305227E03_DXXX.jpg"),
      SpiritImage(_mockDate1, 107,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631290503689E01_DXXX.jpg"),
      SpiritImage(_mockDate1, 108,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631290305226E03_DXXX.jpg"),
      SpiritImage(_mockDate1, 105,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631300503690E01_DXXX.jpg"),
      SpiritImage(_mockDate1, 106,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631300305227E03_DXXX.jpg"),
      SpiritImage(_mockDate1, 107,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000MR0044631290503689E01_DXXX.jpg"),
      SpiritImage(_mockDate1, 108,
          "http://mars.jpl.nasa.gov/msl-raw-images/msss/01000/mcam/1000ML0044631290305226E03_DXXX.jpg"),
    ];
  }
}
