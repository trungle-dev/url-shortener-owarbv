class IncrementalService
  prepend SimpleCommand

  def call
    # at the assigment scope using simple solution as opstimistic locking to generate uniq id
    Incremental.get_new_idx

    # TODO: For real production usage, considering using another approach eg: zookeeper
  end
end
