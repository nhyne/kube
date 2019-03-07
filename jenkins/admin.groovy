#!groovy

import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule

def instance = Jenkins.getInstance()

def user = new File("/opt/jenkins-admin/username").text.trim()
def pass = new File("/opt/jenkins-admin/password").text.trim()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(user, pass)
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()

Jenkins.instance.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)
