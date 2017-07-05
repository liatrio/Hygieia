pipeline {
    agent none
    stages {
       stage('Build Downstream Containers') {
         steps {
           agent {
               docker {
                   image 'maven:3.5.0'
                   args '-e INITIAL_ADMIN_USER -e INITIAL_ADMIN_PASSWORD --network=${LDOP_NETWORK_NAME}'
               }
           }
           parallel (
             sh 'mvn clean package -pl UI docker:build'
             sh 'mvn clean package -pl api docker:build'
             sh 'mvn clean package -pl collectors/scm/subversion docker:build'
             sh 'mvn clean package -pl collectors/scm/gitlab docker:build'
             sh 'mvn clean package -pl collectors/scm/github docker:build'
             sh 'mvn clean package -pl collectors/scm/bitbucket docker:build'
             sh 'mvn clean package -pl collectors/misc/chat-ops docker:build'
             sh 'mvn clean package -pl collectors/library-policy/nexus-iq-collector docker:build'
             sh 'mvn clean package -pl collectors/feature/versionone docker:build'
             sh 'mvn clean package -pl collectors/feature/jira docker:build'
             sh 'mvn clean package -pl collectors/feature/gitlab docker:build'
             sh 'mvn clean package -pl collectors/deploy/xldeploy docker:build'
             sh 'mvn clean package -pl collectors/deploy/udeploy docker:build'
             sh 'mvn clean package -pl collectors/build/jenkins docker:build'
             sh 'mvn clean package -pl collectors/build/sonar docker:build'
             sh 'mvn clean package -pl collectors/build/bamboo docker:build'
             sh 'mvn clean package -pl collectors/build/jenkins-cucumber docker:build'
             sh 'mvn clean package -pl collectors/artifact/artifactory docker:build'
           )
         }
       }
       stage('Build') {
           environment {
             HOME = '.'
           }
           agent {
               docker {
                   image 'maven:3.5.0'
                   args '-e INITIAL_ADMIN_USER -e INITIAL_ADMIN_PASSWORD --network=${LDOP_NETWORK_NAME}'
               }
           }
           steps {
               configFileProvider(
                       [configFile(fileId: 'nexus', variable: 'MAVEN_SETTINGS')]) {
                   sh 'mvn -s $MAVEN_SETTINGS clean deploy -DskipTests=true -B'
               }
           }
       }
   }
}

