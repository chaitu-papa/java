
node {
    stage('Preparation') { 
        checkout([$class: 'GitSCM', branches: [[name: "*/$env.BRANCH_NAME"']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '90a00d85-372b-421a-8299-3d310b3ff072', url: 'git@github.com:chaitu-papa/java.git']]])
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
		 withCredentials([string(credentialsId: 'sonar-token', variable: 'Sonar_token')]) {
		 "sh ./gradlew sonarqube -Dsonar.host.url=$env.SONAR_URL -Dsonar.login=$Sonar_token --info " }        
      } else {
         bat(/"gradlew.bat" clean build jacocoTestReport/)
      }
   }
    stage('snapshot-publish') {
      // Run the gradle upload
      if (isUnix()) {
        env.SNAPSHOT="SNAPSHOT"
        env.BUILD_NUM="$env.BUILD_NUMBER"
        
        sh 'chmod +x gradlew'
        sh "./gradlew upload"
      } else {
         bat(/"gradlew.bat" upload/)
      }
   }
    stage('dev-deploy') {
      // Run the 
      parallel (
        tech_approval: { input 'tech lead: can this proceed?' },
        failFast: true
        )

      if (isUnix()) {
          withCredentials([file(credentialsId: 'ec2-user', variable: 'Secret')]) {
        sh "chmod 600 $Secret"
        sh 'ssh -o StrictHostKeyChecking=no ec2-user@52.73.109.102 -i $Secret "sudo chef-client -o recipe[example::docker-build]"'  
        sh 'ssh -o StrictHostKeyChecking=no ec2-user@52.73.109.102 -i $Secret "sudo chef-client -o recipe[example::docker-run]"' }
          
      } else {
         bat(/"gradlew.bat" clean build jacocoTestReport/)
      }
   }
	stage('qa-deploy') {
      // Run the 
      parallel (
        qa_approval: { input 'qa lead: can this proceed?' },
        failFast: true
        )

      if (isUnix()) {
          withCredentials([file(credentialsId: 'ec2-user', variable: 'Secret')]) {
        sh "chmod 600 $Secret"
        sh 'ssh -o StrictHostKeyChecking=no ec2-user@52.73.109.102 -i $Secret "sudo chef-client -o recipe[example::docker-build]"'  
        sh 'ssh -o StrictHostKeyChecking=no ec2-user@52.73.109.102 -i $Secret "sudo chef-client -o recipe[example::docker-run]"' }
          
      } else {
         bat(/"gradlew.bat" clean build jacocoTestReport/)
      }
   }
   }
