
node {
    stage('Preparation') { 
        checkout([$class: 'GitSCM', branches: [[name: '*/helloworld']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'c7e60db1-4689-46b7-92dc-1cd7ffcc3f16', url: 'git@github.com:chaitu-papa/java.git']]])
   }
   stage('Build') {
      // Run the gradle build
      if (isUnix()) {
         sh 'chmod +x gradlew'
         sh "./gradlew clean build jacocoTestReport"
      } else {
         bat(/"gradlew.bat" clean build jacocoTestReport/)
      }
   }
    stage('code-analysis') {
      // Run the gradle sonar
      if (isUnix()) {
         sh 'chmod +x gradlew'
         echo "./gradlew sonar"
      } else {
         bat(/"gradlew.bat" clean build jacocoTestReport/)
      }
   }
    stage('snapshot-publish') {
      // Run the gradle upload
      if (isUnix()) {
        env.SNAPSHOT=""
        env.BUILD_NUM="$env.BUILD_NUMBER"
        
        sh 'chmod +x gradlew'
        sh "./gradlew upload"
      } else {
         bat(/"gradlew.bat" upload/)
      }
   }
    stage('DEV-ENV-Provision') {
      // Run the 
      parallel (
        tech_approval: { input 'tech lead: can this proceed?' },
        failFast: true
        )

      if (isUnix()) {
         sh 'chmod +x gradlew'
         echo "./gradlew provisioning"
      } else {
         bat(/"gradlew.bat" clean build jacocoTestReport/)
      }
   }
   }
