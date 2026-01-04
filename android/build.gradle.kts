buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.1.1")
        classpath("com.google.gms:google-services:4.3.15") // Plugin Google Services
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Déplacement du buildDir pour Flutter Desktop/Web, optionnel
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

// Tâche clean
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
