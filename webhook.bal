import ballerinax/trigger.asgardeo;
import ballerina/http;
import ballerina/log;

configurable asgardeo:ListenerConfig config = ?; 

listener http:Listener httpListener = new(8090);
listener asgardeo:Listener webhookListener = new(config, httpListener);

service asgardeo:RegistrationService on webhookListener {
    
    remote function onAddUser(asgardeo:AddUserEvent event ) returns error? {
      log:printInfo("onAddUser");
      log:printInfo(event.toJsonString());

        http:Client testClient = check new ("https://webhook.site/fe207fc1-1639-4b41-aa8f-8158d7688895");

        check testClient->post("/tests", event.toJsonString());
    }
    remote function onConfirmSelfSignup(asgardeo:GenericEvent event ) returns error? {
        log:printInfo(event.toJsonString());
    }
  
    remote function onAcceptUserInvite(asgardeo:GenericEvent event ) returns error? {
        log:printInfo(event.toJsonString());
    }
}

service /ignore on httpListener {}
