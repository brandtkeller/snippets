# Setting up jenkins to trust a root CA

The httpskeystore logic is more tailored to setting up https for the application and less for trusted self-signed certificates.
These directions are modifications to the values.yaml file (see jenkins-values.yaml in this directory) for trusting root CA certificates.

## Helm chart
This logic pertains to chart `version: 3.0.14`
* Update image tag
    * tag: "2.270"
* Modify controller.javaOpts
    * javaOpts: "-Djavax.net.ssl.trustStore=/var/jenkins_keystore/keystore.jks -Djavax.net.ssl.trustStorePassword=changeit"
* Create a secret w/ certs to trust
    * kubectl create secret generic trusted-certificates --from-file=~/ca.crt -n <namespace>
* Create a volume mount that mounts the secret to pod
    volumes:
    - name: certificates
      type: Secret
      secretName: root-ca-cert
* Create an customerInitContainer for an image with keytool cli available
  customInitContainers:
  - name: keytool-container
    image: adoptopenjdk/openjdk8:alpine
    imagePullPolicy: IfNotPresent
    command: ["/bin/sh", "-c", "for i in $(find /var/jenkins_keystore/ -name *.crt); do 
              (keytool -delete -alias $(basename $i) -keystore /var/jenkins_home/keystore.jks -storepass changeit -noprompt || echo 'Cert not in keystore') && 
              (keytool -import -trustcacerts -alias $(basename $i) -file $i -keystore /var/jenkins_home/keystore.jks -storepass changeit -noprompt); done"]
    volumeMounts:
    - name: jenkins-home
      mountPath: "/var/jenkins_home"
    - name: certificates-mount
      mountPath: "/var/jenkins_keystore"
* Add JCASC configurations for LDAPS
  JCasC:
    defaultConfig: true
    configScripts:
      ldap-settings: |
        jenkins:
          securityRealm:
            ldap:
              configurations:
              - groupMembershipStrategy:
                  fromGroupSearch:
                    filter: "(| (member={0}) (uniqueMember={0}) (memberUid={1}))"
                groupSearchBase: "cn=groups,cn=accounts"
                inhibitInferRootDN: false
                managerDN: "uid=home_svc,cn=users,cn=accounts,dc=home,dc=local"
                managerPasswordSecret: "skynet"
                rootDN: "dc=home,dc=local"
                server: "ldaps://freeipa.home.local:636"
                userSearchBase: "cn=users,cn=accounts"
* Add essentiall plugins
  installPlugins:
    - kubernetes:1.27.6
    - workflow-aggregator:2.6
    - git:4.4.5
    - configuration-as-code:1.46
    - ldap:2.2
* Modify Ingress

* Testing

* Installation