class Event < ActiveRecord::Base
  has_many :batches
  has_and_belongs_to_many :users

  def batchify
    total = self.users.count
    last_u = nil
    nth = 1
    batch = self.batches.create
    self.users.each do |u|
      if total == 1 && batch.pairings.count >= 1 && batch.pairings.last.users.count == 0
        Pairing.create(batch:batch, users:[u])
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
