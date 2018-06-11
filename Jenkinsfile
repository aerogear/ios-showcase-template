/**
* IOS Jenkinsfile
*/

CODE_SIGN_PROFILE_ID = params?.BUILD_CREDENTIAL_ID?.trim()
BUILD_CONFIG = params?.BUILD_CONFIG?.trim()

PROJECT_NAME = "ios-showcase-template"
INFO_PLIST = "ios-showcase-template/Info.plist"
VERSION = "1.0.0"
SHORT_VERSION = "1.0"
BUNDLE_ID = "org.aerogear.ios-showcase-template"
OUTPUT_FILE_NAME="${PROJECT_NAME}-${BUILD_CONFIG}.ipa"
SDK = "iphoneos"

XC_VERSION = "" // use something like 8.3 to use a specific XCode version.
                                      // If this is not set, the default Xcode on the machine will be used

CLEAN = true // do a clean build and sign

if(BUILD_CONFIG.toLowerCase() == "debug"){
    BUILD_CONFIG = "Debug"
}
else if(BUILD_CONFIG.toLowerCase() == "release" || BUILD_CONFIG.toLowerCase() == "distribution"){
    BUILD_CONFIG = "Release"
}

node('ios') {
    stage('Checkout') {
        checkout scm
    }

    stage('Prepare') {
        sh 'pod install'
    }

    stage('Build') {
        withEnv(["XC_VERSION=${XC_VERSION}"]) {
            xcodeBuild(
                    cleanBeforeBuild: CLEAN,
                    src: './',
                    schema: "${PROJECT_NAME}",
                    workspace: "${PROJECT_NAME}",
                    buildDir: "build",
                    sdk: "${SDK}",
                    version: "${VERSION}",
                    shortVersion: "${SHORT_VERSION}",
                    bundleId: "${BUNDLE_ID}",
                    infoPlistPath: "${INFO_PLIST}",
                    xcodeBuildArgs: 'ENABLE_BITCODE=NO OTHER_CFLAGS="-fstack-protector -fstack-protector-all"',
                    autoSign: false,
                    config: "${BUILD_CONFIG}"
            )
        }
    }

    stage('CodeSign') {
        codeSign(
                profileId: "${CODE_SIGN_PROFILE_ID}",
                clean: CLEAN,
                verify: true,
                ipaName: "${OUTPUT_FILE_NAME}",
                appPath: "build/${BUILD_CONFIG}-${SDK}/${PROJECT_NAME}.app"
        )
    }

    stage('Archive') {
        archiveArtifacts "build/${BUILD_CONFIG}-${SDK}/${OUTPUT_FILE_NAME}"
    }
}
