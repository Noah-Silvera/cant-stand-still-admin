module JobHelpers
  include ActiveJob::TestHelper

  def enqueued_jobs
    queue_adapter.enqueued_jobs
  end
end
