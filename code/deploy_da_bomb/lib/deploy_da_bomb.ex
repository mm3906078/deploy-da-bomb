defmodule DeployDaBomb do
  def start do
    IO.puts("Starting time display loop...")
    print_time_in_loop()
  end

  defp print_time_in_loop do
    IO.puts("Current time: #{Time.utc_now()}")

    Process.sleep(60_000)

    print_time_in_loop()
  end
end
