plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")  // Apply Google services plugin here
}

android {
    namespace = "com.example.niral_prj"
    compileSdk = 34  // Ensure this matches your target SDK version
    defaultConfig {
        applicationId = "com.example.niral_prj"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro')
        }
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:1.8.22"  // Ensure the correct Kotlin version is added
    implementation "com.google.firebase:firebase-analytics:21.0.0"  // Example Firebase dependency
    implementation "com.android.support:appcompat-v7:28.0.0"  // Example support library
}
