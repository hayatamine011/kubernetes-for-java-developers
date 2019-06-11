import java.text.SimpleDateFormat

pipeline {

  options {
    buildDiscarder logRotator(numToKeepStr: '5')
    disableConcurrentBuilds()
  }
  agent {
    kubernetes {
      cloud "java-build"
      label "java-build"
      serviceAccount "build"
      yamlFile "KubernetesPod.yaml"
    }      
  }
  environment {
    project = "java"
    chartVer= "0.0.1"
  }
  stages {
    stage("build") {
       steps {
            node("cen") {
             sh ' git clone git@github.com:hayatamine011/kubernetes-for-java-developers.git.'
            sh  'whoami; docker image build  -t hayat/greeting:jre-slim .'
             
                          //withSonarQubeEnv('sonarServer') {
                          //sh "mvn sonar:sonar"
                          //                                  }
                          // timeout(time: 5, unit: 'MINUTES') {
                           //waitForQualityGate abortPipeline: true
                           //                                   }                                    
                           // }
                               }   
              // container("docker") {
               //echo "k8sBuildImageBeta" //(image, false)
                   //                }
             }
                    }
             }
   
   /*post {
        success {
            script {
                qualitygate = waitForQualityGate().status
                if (qualitygate != "OK") {
                    slackSend(channel: '#jenkins', color: 'danger', message: "*$JOB_NAME*, <$BUILD_URL|Build #$BUILD_NUMBER>: Code coverage threshold was not met! <http://sonar.192.168.1.151.nip.io |Review in SonarQube>.")
                } else {
                    slackSend(channel: '#jenkins', color: 'good', message: "*$JOB_NAME*, <$BUILD_URL|Build #$BUILD_NUMBER>: SUCCEFULL! <http://sonar.192.168.1.151.nip.io|Review in SonarQube>.")
                }
            }
        }
        unsuccessful {
            script {
                if (qualitygate != "OK") {
                    slackSend(channel: '#jenkins', color: 'danger', message: "*$JOB_NAME*, <$BUILD_URL|Build #$BUILD_NUMBER>: Code coverage threshold was not met! <http://sonar.192.168.1.151.nip.io|Review in SonarQube>.")
                } else {
                    slackSend(channel: '#jenkins', color: 'danger', message: "*$JOB_NAME*, <$BUILD_URL|Build #$BUILD_NUMBER>: FAILLED!")
                }
            }

        }

    }*/
  }

