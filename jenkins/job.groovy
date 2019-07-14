node() {

    def check_vars = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
    for (item in check_vars) {
        try {
            println ${item}
        } catch(e) {
            println "Variable " item "missing"
            System.exit(1)
        }
    }

    stage('Infra Setup - Terraform') {
        sh '''
            ls
        '''
    }
}