namespace :sweep do
  desc "Event model delete"
  task :event => :environment do
    def self.sweep(time = 30.days, old = 30.minutes)
      if time.is_a?(String)
        time = time.split.inject { |count, unit| count.to_i.send(unit) }
      end

      if old.is_a?(String)
        old = old.split.inject { |count, unit| count.to_i.send(unit) }
      end

      Event.delete_all "updated_at < '#{time.ago.to_s(:db)}' OR start_date < '#{old.ago.to_s(:db)}'"
    end
    sweep
  end
end
