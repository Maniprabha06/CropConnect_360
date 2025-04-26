android {
    compileSdk = 33
    defaultConfig {
        applicationId = "com.example.niral_prj"
        minSdk = 23
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    apply plugin: 'com.google.gms.google-services'
}

dependencies {
    implementation platform('com.google.firebase:firebase-bom:31.0.1')
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.firebase:firebase-firestore'
}
