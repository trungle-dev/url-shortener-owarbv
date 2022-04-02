class Incremental
  include Mongoid::Document
  include Mongoid::Locker

  field :idx, type: Integer
  field :consumer_id, type: String
  field :locking_name, type: String
  field :locked_at, type: Time

  scope :by_service, ->() { where(consumer_id: ENV['incremental_consumer_id']) }

  locker(
    locking_name_field: :locking_name,
    locked_at_field: :locked_at,
    lock_timeout: 500,
  )

  def self.get_new_idx
    consumer_id = ENV['incremental_consumer_id']

    current_inc = Incremental.by_service.first || Incremental.create(
      idx: ENV['incremental_min_value'].to_i,
      consumer_id: consumer_id
    )

    # Make noise if the maximum index is reached
    if current_inc.idx >= ENV['incremental_max_value'].to_i
      raise "Consumer #{consumer_id} reach maximum limit #{current_inc.idx}"
    end

    current_inc.with_lock do
      current_inc.idx += 1
      current_inc.save!
    end

    current_inc.idx
  end
end
