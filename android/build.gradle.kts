plugins {
    id("com.android.application") version "8.7.0" apply false  // Added version for the Android plugin
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false  // Kotlin plugin version
    id("dev.flutter.flutter-gradle-plugin") version "1.0.0"  // Specified Flutter plugin version
    id("com.google.gms.google-services")  // Ensure Google services plugin is added
}

pluginManagement {
    repositories {
        google()  // Ensure Google's repository is included
        mavenCentral()  // Include Maven Central repository
        gradlePluginPortal()  // Include Gradle plugin portal
    }
}

android {
    namespace = "com.example.niral_prj"
    compileSdk = 34  // Use the latest SDK you are targeting
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.niral_prj"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")  // For debug signing
        }
    }

    flutter {
        source = "../.."  // Ensure this path is correct
    }
}

dependencies {
    classpath("com.android.tools.build:gradle:7.4.2")  // Update to a version compatible with Gradle 7.4.2
    classpath("com.google.gms:google-services:4.4.0")  // Ensure Google services plugin is included
}
