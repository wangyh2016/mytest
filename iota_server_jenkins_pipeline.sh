pipeline {
    agent {
        label 'dockernode-220'
    }
    environment {
        dockerhome = "./Trias-dag_master/streamNet-build/"
        deployhosts = "../../template/Trias-dag-server/hosts-tp"
        
    }
    
    stages {
        stage('remove workspace octa web coding '){   //remove workspace
            steps {
               sh 'rm -rf dag_dev' 

            }
        }
       
        stage('get code octa-web-portal') {
            steps {
            checkout([                      // 获取git repo
                $class: 'GitSCM', 
                branches: [[name: '*/dev']], 
                doGenerateSubmoduleConfigurations: false, 
                extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'dag_dev/'],[$class: 'CloneOption', timeout: 40],[$class: 'CheckoutOption', timeout: 50]], 
                submoduleCfg: [], 
                userRemoteConfigs: [[
                credentialsId: 'f84214cc-c319-4269-ba94-a0b1f6e55101', 
                url: 'https://github.com/triasteam/StreamNet.git'
            ]]
            ])
            }
        }
    
        stage('mvn jar'){  
            steps {
               dir("./dag_dev") {
                   sh 'mvn clean'
                   sh 'mvn package'
                   sh 'cp target/iri-1.5.5.jar ../streamNet-build/'
               }
            }
        }
   
        stage('build'){   //builde bitcore-wallet-service
            steps {
                dir("./streamNet-build"){
                   sh "docker build -t 192.168.1.201:5000/streamnet-server:$BUILD_NUMBER ."
                }
            }
        }

        stage('pull '){
            steps{
                sh "docker push 192.168.1.201:5000/streamnet-server:$BUILD_NUMBER"

                sh "docker rmi -f 192.168.1.201:5000/streamnet-server:$BUILD_NUMBER"
            }
        }

        stage('Deploy'){
            steps{
                sh "cp -av $deployhosts ./trias_deploy_ubt/hosts"
                sh "sed -i 's/<BUILD_TAG>/$BUILD_NUMBER/' ./trias_deploy_ubt/hosts"
               
                dir("./trias_deploy_ubt"){
                   sh "ansible 'oat-client' -m command -a 'docker rm -f streamnet-svr'"
                   sh "ansible-playbook -i hosts site.yml --limit oat-client --tag streamnet"
                }
            }
        }
    }
}
