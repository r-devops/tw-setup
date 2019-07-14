node() {

    def check_vars = ["AWS_ACCESS_KEY_ID", "AWS_SECRET_ACCESS_KEY"]
    for (item in check_vars) {
        try {
            def x = "${item}"
            def z = Eval.me('x', x, '"' + script + '".toString()')
            println z
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