import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

export function newChannel(socket, subtopic, screen_name) {
  return socket.channel(`game:${subtopic}`, { screen_name })
}

export function join(channel) {
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
}

export function leave(channel) {
  channel.leave()
    .receive("ok", resp => { console.log("Left successfully", resp) })
    .receive("error", resp => { console.log("Unable to leave", resp) })
}

export function sayHello(channel, event, greeting) {
  channel.push(event, {message: greeting})
    .receive("ok", resp => { console.log("Hello: ", resp.message) })
    .receive("error", resp => { console.log("Unable to say hello", resp) })
}

socket.connect()

export default socket