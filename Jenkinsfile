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
    hubUser= "hayat"
    
  }
  stages {
    stage("build") {
       steps {
            node("cen") {
              checkout scm
               //sh  'docker image build  -t hayat/greeting:jre-slim2 .'
               sh "docker image build -t ${hubUser}/${project}:beta-${env.BRANCH_NAME}-${env.BUILD_NUMBER} ."
              withCredentials([usernamePassword(
            credentialsId: "docker",
            usernameVariable: "USER",
            passwordVariable: "PASS"
               )]) {
                      sh "docker login -u '$USER' -p '$PASS'"
                   }
              sh "docker image push ${hubUser}/${project}:beta-${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
           (returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim();
              //echo  shortCommit
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

