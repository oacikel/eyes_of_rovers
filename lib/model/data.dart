import 'package:dio/dio.dart';
import 'package:eyes_of_rovers/model/enum.dart';
import 'package:eyes_of_rovers/model/model.dart';
import 'package:flutter/cupertino.dart';

class Data {
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
      API_KEY_PARAMETER: API_KEY
    }).catchError((error) {
      debugPrint("${LOG_TAG} Caught error: ${error.toString()}");
    });
    debugPrint("${LOG_TAG} Retrieved list: ${_response.data}");
    List<NasaImage> photos = [];
    for (var photo in _response.data["photos"]) {
      NasaImage image = NasaImage(photo[IMAGE_URL_PARAMETER]);
      photos.add(image);
    }
    return photos;
  }

  String _generateBaseURL(eRoverName name) {
    return "https://api.nasa.gov/mars-photos/api/v1/rovers/${getRoverNameForHTTP(name)}/photos";
  }
}
