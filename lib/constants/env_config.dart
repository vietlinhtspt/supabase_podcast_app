enum Evironment { DEV, PRODUCT }

class TargetBuild {
  static var environment = Evironment.DEV;
  static var supabaseCacheSize = 20;
}
