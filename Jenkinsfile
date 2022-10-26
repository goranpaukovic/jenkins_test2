
/* import shared library */
//@Library('jenkins-shared-library')_

pipeline {
  agent {
      label 'oe-build-gm-ccu-PoC'
  }
  
  options {
    buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '10'))
    durabilityHint('PERFORMANCE_OPTIMIZED')
    copyArtifactPermission('smoke-test')
  }
  
  stages {
    stage('Build sama5d27-wlsom1-ek') {
      steps {
        // csSlackNotifier('STARTED', true)
        sh '''
           echo "...Build..."
           id
           mkdir -p deploy-sama5d27-wlsom1-ek
           touch deploy-sama5d27-wlsom1-ek/build_file.obj
           date >> deploy-sama5d27-wlsom1-ek/build_file.obj
           docker ps
        '''
        // docker run -i -v /opt/yocto_shares/sstate-cache:/opt/yocto_shares/sstate-cache -v /opt/yocto_shares/downloads:/opt/yocto_shares/downloads -v $PWD:/workdir --workdir=/workdir oe-build-goran:1.0 ./build_oe-core.sh
        // sh "./scripts/build-release-sama5d27-wlsom1-ek.sh"
      }
    }
    stage('Unit Tests') {
      steps {
        sh '''
           echo "Started Unit Tests"
           echo "Finished Unit Tests"
        '''
      }
    }
    stage('Smoke Test') {
      steps {
        sh '''
          echo "Started smoke tests"
          echo "......"
          echo "Finished smoke tests"
        '''
        build job: 'smoke-test', parameters: [string(name: 'targetEnvironment', value: 'stage123')]
        //copyArtifacts(projectName: 'smoke-test', selector: specific("${build.number}"));
        //build job: 'oe-build'
      }
    }
    stage('Copy artifacts sama5d27-wlsom1-ek') {
      steps {
        sh '''
          echo "Copy artifacts"
        '''
        //sh "./scripts/package-release-sama5d27-wlsom1-ek.sh"
      }
    }
    stage('Sync sources GM') {
      when {
        branch comparator: 'REGEXP', pattern: '^(master|ccu/.*|r.*)$'
      }
      steps {
        sh '''
          echo "Sync"
        '''
        //sh "./scripts/sync-sources-gm-ccu.sh"
      }
    }
    stage('Delivery to an artifactory') {
        steps {
      sh '''
        echo "Upload artifacts to the Artifactory"
      '''
    }
    }
  }
  post {
    success {
      archiveArtifacts 'deploy-sama5d27-wlsom1-ek/**/*.*'
    }
    always {
      // Put MS Teams notification
      //csSlackNotifier(currentBuild.currentResult)
      sh '''
        echo "Finished"
      '''
    }
  }
}
