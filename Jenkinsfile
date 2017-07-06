pipeline {
    agent none
    stages {
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
                   sh 'mvn -s $MAVEN_SETTINGS -e clean deploy -DskipTests=true -B'
               }
           }
       }
/*       stage('Build Downstream Containers') {
         agent {
             docker {
                 image 'maven:3.5.0'
                 args '-e INITIAL_ADMIN_USER -e INITIAL_ADMIN_PASSWORD --network=${LDOP_NETWORK_NAME}'
             }
         }
         steps {
           sh 'mvn docker:build'
         }
       }*/
   }
}

