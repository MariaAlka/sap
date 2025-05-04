plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.first"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.first"
        minSdk = 21 // placeholder, will be overridden
        targetSdk = 34 // placeholder, will be overridden
        versionCode = 1 // placeholder, will be overridden
        versionName = "1.0" // placeholder, will be overridden
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// Ensure flutter extension is available before use
afterEvaluate {
    val flutterExtension = extensions.findByName("flutter") as? Map<*, *> ?: return@afterEvaluate
    val defaultConfig = android.defaultConfig
    defaultConfig.minSdk = flutterExtension["minSdkVersion"] as Int
    defaultConfig.targetSdk = flutterExtension["targetSdkVersion"] as Int
    defaultConfig.versionCode = flutterExtension["versionCode"] as Int
    defaultConfig.versionName = flutterExtension["versionName"] as String
}

flutter {
    source = "../.."
}
