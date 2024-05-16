# Domain

```mermaid
mindmap
  root((domain))
    HOME
      No Selected Building -> Force select (Local storage)
      Selected Building -> redirect to BUILDINGS
    USERS
      Register
      Login
    LOCATIONS
      Joined
        Select
      Invitation
        Join
      Owned
        Create
    BUILDINGS
      tasks
      chats
      calendars
      others
        rooms (realtime people position)
          chats
          members
            Invite
        chat(MVP2)
      schedules (building/room)
        tasks
        report(MVP3)
    NOTIFICATION-DEEPLINK
```
