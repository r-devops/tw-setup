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

    // Check AWS_DEFAULT_REGION
    try {
        println AWS_DEFAULT_REGION
    } catch(e) {
        println 'Variable AWS_DEFAULT_REGION is missing'
        sh 'false'
    }

    // Check RDS DB User 
    try {
        println RDS_USERNAME
    } catch(e) {
        println 'Variable RDS_USERNAME is missing'
        sh 'false'
    }

    // Check RDS DB Password
    try {
        println RDS_PASSWORD
    } catch(e) {
        println 'Variable RDS_PASSWORD is missing'
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
                terraform destroy -target=module.EC2 -auto-approve -var-file=proj-info.tfvars -var DBUSER=${RDS_USERNAME} -var DBPASS=${RDS_PASSWORD}
                terraform apply -auto-approve -var-file=proj-info.tfvars -var DBUSER=${RDS_USERNAME} -var DBPASS=${RDS_PASSWORD}
            '''
        }
    }
}