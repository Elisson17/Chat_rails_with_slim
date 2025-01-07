import consumer from "channels/consumer";
const unreadElement = document.getElementById("unread-badge");
const userId = Number(unreadElement.dataset.userId);
const chatRoomId = Number(unreadElement.dataset.chatRoomId);
consumer.subscriptions.create(
  { channel: "NotificationsChannel", current_user: userId },
  {
    connected() {
      console.log("Connected to NotificationsChannel");
      console.log(userId);
      console.log(chatRoomId);
    },

    disconnected() {
      console.log("Disconnected from NotificationsChannel");
    },

    received(data) {
      console.log(data);
      const unreadCountElement = document.querySelector(
        `#unread-badge[data-chat-room-id="${data.chat_room_id}"]`
      );
      if (unreadCountElement) {
        let unreadBadge = unreadCountElement.querySelector("span");

        if (unreadBadge) {
          console.log(unreadBadge);
          unreadBadge.textContent = data.unread_count;
        } else {
          unreadBadge = document.createElement("span");
          console.log(unreadBadge);
          unreadBadge.classList.add(
            "bg-blue-500",
            "text-white",
            "rounded-full",
            "p-[6px]",
            "text-xs"
          );
          unreadBadge.textContent = data.unread_count;
          unreadCountElement.appendChild(unreadBadge);
        }
      }
    },
  }
);
