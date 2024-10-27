class User
    attr_accessor :name, :email, :password, :rooms
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = [] # เก็บห้องที่ผู้ใช้เข้าร่วม
    end
  
    def enter_room(room)
      unless @rooms.include?(room)
        @rooms << room
        room.add_user(self) # เพิ่มผู้ใช้ในห้อง
        puts "#{@name} has entered the room: #{room.name}"
      else
        puts "#{@name} is already in the room: #{room.name}"
      end
    end
  
    def send_message(room, content)
      message = Message.new(self, room, content)
      room.broadcast(message) # ส่งข้อความไปยังห้อง
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
      @users = [] # เก็บผู้ใช้ที่เข้าร่วมห้อง
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
        user.acknowledge_message(self, message) # ให้ผู้ใช้ทุกคนยืนยันข้อความ
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
  
  # ตัวอย่างการใช้งาน
  if __FILE__ == $0
    user1 = User.new("Alice", "alice@example.com", "password123")
    user2 = User.new("Bob", "bob@example.com", "password456")
  
    room = Room.new("General", "This is a general chat room.")
  
    user1.enter_room(room)  # Alice เข้าห้อง
    user2.enter_room(room)  # Bob เข้าห้อง
  
    user1.send_message(room, "Hello everyone!")  # Alice ส่งข้อความ
  end
  