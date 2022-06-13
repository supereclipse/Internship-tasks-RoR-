require 'sqlite3'

class StopVmService
  def self.call(payload)
    puts 'Starting really slow task!'
    puts "Payload: #{payload}"

    4.times do
      putc '.'
      sleep 1
    end

    # HW 8 part 2
    db = SQLite3::Database.open './db/development.sqlite3'
    db.execute "UPDATE vms SET state = 'stopped' WHERE id = #{payload}"

    puts 'Slow task finished'
  end
end
