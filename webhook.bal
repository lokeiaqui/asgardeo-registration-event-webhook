import ballerinax/trigger.asgardeo;
import ballerina/http;

configurable asgardeo:ListenerConfig config = ?; 

listener http:Listener httpListener = new(8090);
listener asgardeo:Listener webhookListener = new(config, httpListener);

service asgardeo:RegistrationsService on webhookListener {
    
    remote function onAddUser(asgardeo:AddUserEvent event ) returns error? {
      //Not Implemented
    }
    remote function onSelfSignupConfirm(asgardeo:GenericEvent event ) returns error? {
      //Not Implemented
    }
    remote function onAskPasswordConfirm(asgardeo:GenericEvent event ) returns error? {
      //Not Implemented
    }
}

service /ignore on httpListener {}