# Small Talk

[Demo Page](https://seanperfecto.github.io/applandingpage/)  
[Back-end Repo](https://github.com/seanperfecto/smalltalk-backend)

Splash screen              |  Home screen
:-------------------------:|:-------------------------:
![video](http://res.cloudinary.com/dqr2mejhc/image/upload/v1498017130/IMG_4171_bnqdzh.jpg)  |  ![categories](http://res.cloudinary.com/dqr2mejhc/image/upload/v1498017130/IMG_4175_m6wwxa.jpg)

Small Talk is a mobile video chat application that allows users to connect to other users via common subjects. With our category filters, our goal at Small Talk is to allow strangers to bond over similar interests.

## Technologies Used

The back end API was built using Python's Django framework while the front end was constructed using React Native. React Native is useful for building performant iOS and Android apps. Transition and loading animations were incorporated to offer a polished experience for our users. WebSockets were used to dynamically connect users to the signaling server in order to transfer vital connection information. Once the initial connection was established, WebRTC was incorporated to allow users to continually transfer video and audio information without the use of an intermediary server.

## Features

#### WebRTC

To establish a video and peer-to-peer connection, WebRTC was implemented on top of Django Channels.  WebRTC is a technology that allows for peer-to-peer teleconferencing without requiring the user to install plug-ins or any other third-party software.  It's made up of a number of APIs and protocols that operate together in order to make this possible.  Most notably, the RTCPeerConnection interface represents the connection itself - mapping the local computer to the remote peer.  This object provides methods to connect to a remote peer, maintain and monitor the connection, and close the connection once it's no longer needed.  The process of connecting peers initially takes place through an external signaling server, where WebSockets are used to exchange important information about each user's media and connectivity options.  Whereas the recipient of the connection is typically explicitly specified by the user before the connection is made, our application does this work on the backend.  

#### Django Channels

![video](http://res.cloudinary.com/dqr2mejhc/image/upload/v1498018075/normal_cn6vwt.gif)

In order to implement WebRTC, it was necessary to set up a signaling server so that two
users could establish a peer to peer connection. This involved implementing Django Channels, which
handles WebSocket connections. Redis was used for the channel layer, and a Daphne interface server was used in order to support both HTTP and WebSocket requests. Additional single-threaded worker servers were also set up in order to speed up response time and prevent hanging.

Upon the initial handshake, users are dynamically placed into chatrooms with each other (with a maximum of two users per chatroom).  A "connection" model was created to store these chatrooms in the database to maintain a reference to each chat and each user in the chat (via foreign keys). Because only the initial request resembles HTTP, and the reference to current user lives in the cookies sent over HTTP, it was necessary to extract a reference to current user upon this initial handshake to associate it with the WebSocket reply channel. When a second user enters a chat, a message is sent to the group to begin Peer to Peer negotiations, after which the channel simply relays messages between the two users to mediate WebRTC negotiations until a connection is established. When a chatroom becomes empty, it is destroyed.


## Future Implementations

#### Friendships
The friendships feature would allow users to add each other as friends if
they would like to call each other for future chat sessions.
