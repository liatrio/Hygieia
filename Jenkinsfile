pipeline {
  agent none
  stages {
    stage('Build') {
      environment {
        HOME = '.'
      }
      agent {
        docker {
          image 'maven-docker-build:latest'
            args '-e INITIAL_ADMIN_USER -e INITIAL_ADMIN_PASSWORD -v /var/run/docker.sock:/var/run/docker.sock -u maven:staff --network=${LDOP_NETWORK_NAME}'
        }
      }
      steps {
        configFileProvider([configFile(fileId: 'nexus', variable: 'MAVEN_SETTINGS')]) {
          sh 'mvn -s $MAVEN_SETTINGS clean deploy package -DskipTests=true -B'
          sh 'mvn -s $MAVEN_SETTINGS docker:build'
        }
      }
    }
    stage('Docker Compose'){
      agent any 
      steps {
        sh 'docker-compose up -d'
      }
    }
    stage('Add database user') {
      agent any
      steps {
        sh 'docker cp dbusr.sh mongodb:/'
        sh 'docker exec -t mongodb bin/bash -c /dbusr.sh'
      } 
    }
     /*
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
      */
       /*
       stage('Run Sonar scanner') {
         agent {
             docker {
                 image 'sebp/sonar-runner'
                 args '-e SONAR_ACCOUNT_LOGIN -e SONAR_ACCOUNT_PASSWORD -e SONAR_DB_URL -e SONAR_DB_LOGIN -e SONAR_DB_PASSWORD --network=${LDOP_NETWORK_NAME}'
             }
         }
         steps {
           sh '/opt/sonar-runner-2.4/bin/sonar-runner -D sonar.login=${SONAR_ACCOUNT_LOGIN} -D sonar.password=${SONAR_ACCOUNT_PASSWORD} -D sonar.jdbc.url=${SONAR_DB_URL} -D sonar.jdbc.username=${SONAR_DB_LOGIN} -D sonar.jdbc.password=${SONAR_DB_PASSWORD}'
         }
       }
       */
   }
}

