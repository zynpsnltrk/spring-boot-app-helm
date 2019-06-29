currentBuild.displayName = "${BUILD_NUMBER} - image: spring-boot-app - version: ${version}"
currentBuild.description = "${BUILD_NUMBER} - image: spring-boot-app - version: ${version}"
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                script {
                    def DOCKER_TAG = build (
                        propagate: true,
                        wait: true,
                        job: 'build',
                        parameters: [string(name: 'version', value: params.version)]
                    ).getBuildVariables().DOCKER_TAG
                    sh "export KUBECONFIG=/var/lib/jenkins/.kube/spting-boot-app-kubeconfig.yaml && helm upgrade ${env.BUILD_NAME} -f helm_vars/values.yaml --set image.tag=${DOCKER_TAG} ."
                }
            }
        }
    }
}