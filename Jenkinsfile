pipeline {
    agent none
 
   environment {
         GITHUB_REPO = 'github.com/brandtkeller/snippets.git'
    }
    options {
        skipStagesAfterUnstable()
        skipDefaultCheckout false
    }
    stages {
        stage('Mirror Stage') {
            agent { label 'jenkins-base-agent' }
            stages {
                stage('Mirror to public Github') {
                    when { branch 'master' }
                        steps {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                            withCredentials([usernamePassword(credentialsId: 'git_token', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                                    sh 'git fetch --prune'
                                    sh 'git push --prune https://$GIT_USERNAME:$GIT_PASSWORD@$GITHUB_REPO +refs/remotes/origin/*:refs/heads/* +refs/tags/*:refs/tags/*'
                                }
                            }
                        }
                }
            }
        }
    }
}