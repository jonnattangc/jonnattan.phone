plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "cl.jonnattan.app_condominio"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "cl.jonnattan.app_condominio"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        val googleApiKey: String = (System.getenv("API_KEY_GOOGLE_MAPS") as? String) ?: "__NO_FOUND__"
        val mapBoxApiKey: String = (System.getenv("MAP_BOX_KEY") as? String) ?: "__NO_FOUND__"
        
        println("=====================================================")
        println("DEBUG: Google API Key: $googleApiKey")
        println("DEBUG: Mapbox API Key: $mapBoxApiKey")
        println("=====================================================")

        resValue("string", "google_maps_api_key", googleApiKey)
        resValue("string", "mapbox_api_key", mapBoxApiKey)
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
