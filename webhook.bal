import ballerinax/trigger.asgardeo;
import ballerina/http;
import ballerina/log;

configurable asgardeo:ListenerConfig config = ?; 

listener http:Listener httpListener = new(8090);
listener asgardeo:Listener webhookListener = new(config, httpListener);

service asgardeo:RegistrationsService on webhookListener {
    
    remote function onAddUser(asgardeo:AddUserEvent event ) returns error? {
      log:printinfo("onAddUser");
      log:printinfo(event.toJsonString());
    }
    remote function onSelfSignupConfirm(asgardeo:GenericEvent event ) returns error? {
      log:printinfo("onSelfSignupConfirm");
      log:printinfo(event.toJsonString());
    }
    remote function onAskPasswordConfirm(asgardeo:GenericEvent event ) returns error? {
      log:printinfo("onAskPasswordConfirm");
      log:printinfo(event.toJsonString());
    }
}

service /ignore on httpListener {}
