import consumer from "channels/consumer";
const chatElement = document.getElementById("chat");
const chatRoomId = chatElement.dataset.chatRoomId;

consumer.subscriptions.create(
  { channel: "MessagesOfChatChannel", chat_room_id: chatRoomId },
  {
    connected() {
      console.log("Connected to MessagesOfChatChannel");
      console.log(chatRoomId);
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      console.log("Disconnected from MessagesOfChatChannel");
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      console.log(data)
    },
  }
);
