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
           sh 'echo \'hello world\''
         }
       }*/
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
       stage('run mongo container') {
         agent any
         steps {
//           sh 'docker run -p 27017:27017 -d --network=${LDOP_NETWORK_NAME} -v /root//mongo/data/db mongo:latest  mongod --smallfiles'
           sh 'docker run -p 8080:8080 --link mongodb:mongo -v /root/logs/hygieia/logs -i capitaloneio/hygieia-api:latest'
           //sh 'mongo < mongosrc.js'
         }
       }
/*       stage('Build Downstream Containers') {
         agent {
             docker {
                 image 'liatrio/selenium-firefox'
                 args '--network=${LDOP_NETWORK_NAME}'
             }
         }
         steps {
           sh 'echo running Selenium'
         }
       }*/
   }
}

