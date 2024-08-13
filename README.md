# README
	

Ruby Version ruby "3.3.4"

Rails Version "7.0.6"


In order to run the application just run docker-compose up


For Testing APIs


 Application 

1- create an application: POST http://localhost:3000/applications
				 Headers:Content-Type: application/json
			for the body {
 					 "application": {
  					  "name": ""
   					 
 							 }
					}
2- show all applications GET  http://localhost:3000/applications

3- view application GET  http://localhost:3000/applications/token

4- update application PUT http://localhost:3000/applications/token

	for the body {
  			"application": {
   			 "name": ""
  					}
					}

5- delete an application DELETE  PUT http://localhost:3000/applications/token


Chats 

1- to create a chat POST http://localhost:3000/applications/app-token/chats
	 ##"there shouldn't be a body "remember to fix this before submission
                    for the body {
  			"chat": {
  			  "number": 
  				}
				}
2- to list all chats GET  http://localhost:3000/applications/app-token/chats


3- view a chat GET http://localhost:3000/applications/app-token/chats/chat-id




4- Delete a chat DELETE http://localhost:3000/applications/app-token/chats/chat-id



 Messages

1- Create a Message POST http://localhost:3000/applications/app-token/chats/chat-id/messages
  		and for the body {
  			"message": {
   			 "body": ""
   			  
  				}
				}

2- show all messages GET http://localhost:3000/applications/app-token/chats/chat-id/messages


3- show a message GET http://localhost:3000/applications/app-token/chats/chat-id/messages/message-id

4-update a message PUT http://localhost:3000/applications/app-token/chats/chat-id/messages/message-id
	and for the body {
  			"message": {
   			 "body": ""
  				}
				}

5- delete a message DELETE  http://localhost:3000/applications/app-token/chats/chat-id/messages/message-id



