Dynamo.under_test(Nurblizer.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Nurblizer.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
