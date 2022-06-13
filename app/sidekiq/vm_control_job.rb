class VmControlJob
  include Sidekiq::Job

  def perform(*_args)
    StopVmService.call('jjj')
  end
end
