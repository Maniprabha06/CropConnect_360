pluginManagement {
    val flutterSdkPath: String = settings.extra[""]?.toString()
            ?: System.getenv("FLUTTER_SDK")
            ?: throw GradleException("Flutter SDK path not defined. Add 'flutter.sdk' to local.properties or set FLUTTER_SDK environment variable")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven {
            url = uri("E:/Cropconnect/android/flutter.gradle")
        }
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "Cropconnect"
include(":app")
