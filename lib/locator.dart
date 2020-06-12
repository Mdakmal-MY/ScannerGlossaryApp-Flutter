import 'package:get_it/get_it.dart';
import 'package:ocrglossary/core/models/userImage.dart';
import 'package:ocrglossary/core/services/analyticsprocessapi.dart';
import 'package:ocrglossary/core/services/processapi.dart';
import 'package:ocrglossary/core/services/storageServices.dart';
import 'package:ocrglossary/core/viewmodel/CRUDmodel.dart';
import 'package:ocrglossary/core/viewmodel/imageModel.dart';
import 'package:ocrglossary/core/viewmodel/signupmodel.dart';
import 'package:ocrglossary/core/services/userprocessapi.dart';
import 'package:ocrglossary/core/services/FeedbackApi.dart';
import 'package:ocrglossary/core/viewmodel/feedbackModel.dart';
import 'package:ocrglossary/core/viewmodel/bookmarkModel.dart';
import 'package:ocrglossary/core/services/bookmarkApi.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => ProcessApi('Glossary'));
  locator.registerLazySingleton(() => CRUDmodel());
  locator.registerLazySingleton(() => UserProcessApi('Users'));
  locator.registerLazySingleton(() => SignUpModel());
  locator.registerLazySingleton(() => AnalyticsProcessApi());
  locator.registerLazySingleton(() => FeedbackApi('Feedback'));
  locator.registerLazySingleton(() => FeedbackModel());
  locator.registerLazySingleton(() => BookmarkApi('Bookmark'));
  locator.registerLazySingleton(() => BookmarkModel());
  locator.registerLazySingleton(() => StorageServices('UserImage'));
  locator.registerLazySingleton(() => ImageModel());
}