require "test_helper"

class ProcessPriceImportJobTest < ActiveJob::TestCase
  test "deve enfileirar o job corretamente" do
    assert_enqueued_with(job: ProcessPriceImportJob) do
      ProcessPriceImportJob.perform_later("{\"product_name\":\"Test Product\", \"price\":100}")
    end
  end

  test "deve processar os preços corretamente" do
    perform_enqueued_jobs do
      ProcessPriceImportJob.perform_later("{\"product_name\":\"Test Product\", \"price\":100}")
    end
  end
end
