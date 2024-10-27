class User
    attr_accessor :name, :email, :password, :rooms
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []
    end
  
    def enter_room(room)
      unless @rooms.include?(room)
        @rooms << room
        room.add_user(self) 
        puts "#{@name} has entered the room: #{room.name}"
      else
        puts "#{@name} is already in the room: #{room.name}"
      end
    end
  
    def send_message(room, content)
      message = Message.new(self, room, content)
      room.broadcast(message) 
    end
  
    def acknowledge_message(room, message)
      puts "#{@name} acknowledged the message: '#{message.content}' in room: #{room.name}"
    end
  end
  
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = [] 
    end
  
    def add_user(user)
      unless @users.include?(user)
        @users << user
        puts "#{user.name} has been added to the room: #{@name}"
      end
    end
  
    def broadcast(message)
      puts "Broadcasting message in room: #{@name}"
      @users.each do |user|
        user.acknowledge_message(self, message) 
      end
    end
  end
  
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
  
  if __FILE__ == $0
    user1 = User.new("Alice", "alice@example.com", "password123")
    user2 = User.new("Bob", "bob@example.com", "password456")
  
    room = Room.new("General", "This is a general chat room.")
  
    user1.enter_room(room)  
    user2.enter_room(room) 
  
    user1.send_message(room, "Hello everyone!") 
  end
  
