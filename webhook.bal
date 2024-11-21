import ballerinax/trigger.asgardeo;
import ballerina/http;
import ballerina/log;
import ballerina/io;

configurable asgardeo:ListenerConfig config = ?; 

listener http:Listener httpListener = new(8090);
listener asgardeo:Listener webhookListener = new(config, httpListener);

service asgardeo:UserOperationService on webhookListener {
    
    remote function onRegisterUser(asgardeo:AddUserEvent event ) returns error? {
      log:printInfo("onAddUser");
      log:printInfo(event.toJsonString());

        //Test
        http:Client testClient = check new ("https://webhook.site/fe207fc1-1639-4b41-aa8f-8158d7688895");
        
        var res = check testClient->/test.post(event.toJsonString());
        io:println("\nPOST request:" + res.toJsonString());
    }
    // Implementações vazias para métodos obrigatórios
    remote function onDeleteUser(asgardeo:GenericEvent event) returns error? {}
    remote function onLockUser(asgardeo:GenericEvent event) returns error? {}
    remote function onUnlockUser(asgardeo:GenericEvent event) returns error? {}
    remote function onUpdateUserCredentials(asgardeo:UpdateUserCredentialsEvent event) returns error? {}
    remote function onUpdateUserGroup(asgardeo:UserGroupUpdateEvent event) returns error? {}
}

service /ignore on httpListener {}
