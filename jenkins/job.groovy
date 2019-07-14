node() {
    // Check AWS_ACCESS_KEY_ID 
    try {
        println AWS_ACCESS_KEY_ID
    } catch(e) {
        println 'Variable AWS_ACCESS_KEY_ID is missing'
        sh 'false'
    }

    // Check AWS_SECRET_ACCESS_KEY
    try {
        println AWS_SECRET_ACCESS_KEY
    } catch(e) {
        println 'Variable AWS_SECRET_ACCESS_KEY is missing'
        sh 'false'
    }

    // Check AWS_DEFAULT_REGION="us-east-1"
    try {
        println AWS_DEFAULT_REGION
    } catch(e) {
        println 'Variable AWS_DEFAULT_REGION is missing'
        sh 'false'
    }

    stage('Clone Repo') {
        git 'https://github.com/r-devops/tw-setup.git'
    }

    stage('Infra Setup - Terraform') {
        wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
            sh '''
                cd terraform 
                terraform init
                terraform apply -auto-approve -var-file=proj-info.tfvars
            '''
        }
    }
}