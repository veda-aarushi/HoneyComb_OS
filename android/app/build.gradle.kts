plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") version "4.4.2" apply false // ✅ ADD THIS
}

android {
    namespace = "com.example.my_updated_flashcard_app_fixed"
    compileSdk = 35
    ndkVersion = "27.0.12077973" // ✅ explicitly set based on plugin requirements

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8 // ⬅️ Java 11 is OK, but 1.8 is safer for Flutter plugins
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.example.my_updated_flashcard_app_fixed" +
                ""
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // or use your release config if ready
        }
    }
}

flutter {
    source = "../.."
}

// ✅ Only needed if you use Firebase
apply(plugin = "com.google.gms.google-services")
