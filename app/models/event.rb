class Event < ActiveRecord::Base
  has_many :batches
  has_and_belongs_to_many :users

  def switchify
    
  end

  # shield your eyes... the following is horrifying
  def batchify
    total = self.users.count
    last_u = nil
    nth = 1
    batch = self.batches.create
    if total == 2
      Pairing.create(batch:batch, users:[self.users.first, self.users.last])
    else
      self.users.shuffle.each do |u|
        if total == 1 && batch.pairings.count == 0
          Pairing.create(batch:batch, users:[u])
        elsif total == 1 && batch.pairings.count >= 1 && batch.pairings.last.users.count == 1
          batch.pairings.last.users.push(u)
        else
          if nth.odd?
            last_u = u
          else      
            Pairing.create(batch:batch, users:[last_u, u])
          end
          total -= 1
          nth += 1
        end
      end
    end
  end
end
