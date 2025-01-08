import consumer from "channels/consumer";
const unreadElement = document.getElementById("unread-badge");
const userId = Number(unreadElement.dataset.userId);
consumer.subscriptions.create(
  { channel: "NotificationsChannel", current_user: userId },
  {
    connected() {
      console.log("Connected to NotificationsChannel");
    },

    disconnected() {
      console.log("Disconnected from NotificationsChannel");
    },

    received(data) {
      console.log(data);
      // Atualizar o contador de mensagens não lidas no chat selecionado
      const unreadCountElement = document.querySelector(
        `#unread-badge[data-chat-room-id="${data.chat_room_id}"]`
      );
      if (unreadCountElement) {
        let unreadBadge = unreadCountElement.querySelector("span");

        if (unreadBadge) {
          unreadBadge.textContent = data.unread_count;
        } else {
          unreadBadge = document.createElement("span");
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


      //atualiza a ultima mensagem do chat
      const lastMessageElement = document.querySelector(
        `#last-message[data-chat-room-id="${data.chat_room_id}"]`
      );
      console.log(lastMessageElement)
      if (lastMessageElement) {
        const lastMessage = lastMessageElement.querySelector("p");
        if (lastMessage) {
          lastMessage.textContent = data.message.content;
        }
      }
    },
  }
);
