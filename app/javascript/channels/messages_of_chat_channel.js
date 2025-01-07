import consumer from "channels/consumer";
let subscription = null;

function createSubscription(chatRoomId, userId) {
  if (subscription) {
    subscription.unsubscribe();
  }
  subscription = consumer.subscriptions.create(
    { channel: "MessagesOfChatChannel", chat_room_id: chatRoomId },
    {
      connected() {
        console.log(`Connected to chatRoomId: ${chatRoomId}`);
      },
      disconnected() {
        console.log(`Disconnected from chatRoomId: ${chatRoomId}`);
      },
      received(data) {
        const chatElement = document.getElementById("chat");
        if (!chatElement) return;

        const createdAt = new Date(data.message.created_at);
        const formattedTime = createdAt.toLocaleTimeString("pt-BR", {
          hour: "2-digit",
          minute: "2-digit",
        });

        const html = `
          <div class="flex items-start space-x-2 ${
            Number(userId) === data.message.user_id ? "justify-end" : ""
          }">
            <div class="rounded-lg p-2 max-w-[70%] ${
              Number(userId) === data.message.user_id
                ? "bg-blue-500 text-white"
                : "bg-gray-100"
            }">
              <p class="text-sm">${data.message.content}</p>
              <p class="text-xs items-start flex ${
                Number(userId) === data.message.user_id
                  ? "text-blue-100 justify-end"
                  : "text-gray-500"
              } mt-1">${formattedTime}</p>
            </div>
          </div>`;
        chatElement.insertAdjacentHTML("beforeend", html);
        chatElement.scrollTop = chatElement.scrollHeight;
      },
    }
  );
}
const chatElement = document.getElementById("chat");
if (chatElement) {
  const initialChatRoomId = chatElement.dataset.chatRoomId;
  const userId = chatElement.dataset.userId;
  createSubscription(initialChatRoomId, userId);
}
document.addEventListener("turbo:load", () => {
  const newChatElement = document.getElementById("chat");
  if (newChatElement) {
    const newChatRoomId = newChatElement.dataset.chatRoomId;
    const userId = newChatElement.dataset.userId;
    createSubscription(newChatRoomId, userId);
  }
});
