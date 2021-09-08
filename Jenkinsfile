pipeline {
  agent {
    node {
      label 'secdev-server-agent'
    }
  }  
  stages {
    stage ('OCI modified confirmation') {
      steps {
          ////sh '/e/fin-ci/jenkins/scripts/oci-updated.sh "$GIT_COMMIT" "$GIT_PREVIOUS_COMMIT" "$GIT_BRANCH"'
          sh '/c/projects/jenkins-oci/fin-ci/jenkins/scripts/oci-updated.sh "$GIT_COMMIT" "$GIT_PREVIOUS_COMMIT" "$GIT_BRANCH"'
      }
    }
    stage ('OCI build') {
      steps {
          script {
              def changeLogSets = currentBuild.changeSets;
              def commitMessages = ''
            for (int i = 0; i < changeLogSets.size(); i++) {
                def entries = changeLogSets[i].items
                for (int j = 0; j < entries.length; j++) {
                    def entry = entries[j]
                    commitMessages+= "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}\n"
                    echo commitMessages
                }
            }
            if (!commitMessages){
                commitMessages = "No New Changes"
            }
            slackSend (channel: 'team-financials-ci-notification-poc', color: "good", message: "Build Successful.\n Changes:\n ${commitMessages}" + "\n\n Check console output at: (${env.BUILD_URL})/console" + "\n")
            
                //getCurrentBuildGitDetails()
            }
          //sh '/e/fin-ci/jenkins/scripts/oci-frontend.sh'
      }
    }
  }
}

@NonCPS
def getCurrentBuildGitDetails() {
    echo "getting SCM changes ***********************"
    def changeLogSets = currentBuild.changeSets
    for (int i = 0; i < changeLogSets.size(); i++) {
        def entries = changeLogSets[i].items
        for (int j = 0; j < entries.length; j++) {
            def entry = entries[j]
            echo "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}"
            def files = new ArrayList(entry.affectedFiles)
            for (int k = 0; k < files.size(); k++) {
                def file = files[k]
                echo "  ${file.editType.name} ${file.path}"
            }
        }
    }
}
