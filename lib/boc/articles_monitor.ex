defmodule Boc.ArticlesMonitor do
  use GenServer

  require Logger

  @throttle_timeout_ms 100

  defmodule State do
    defstruct [:throttle_timer, :file_events, :watcher_pid]
  end

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [])
  end

  @impl GenServer
  def init([]) do
    {:ok, watcher_pid} =
      FileSystem.start_link(dirs: [Boc.articles_path()])

    FileSystem.subscribe(watcher_pid)
    Logger.debug("Boc articles monitor started.")
    {:ok, %State{watcher_pid: watcher_pid}}
  end

  @impl GenServer
  def handle_info({:file_event, watcher_pid, {path, events}}, %{watcher_pid: watcher_pid} = state) do
    matching_extension? = Path.extname(path) === ".md"

    matching_event? = :modified in events

    state =
      if matching_extension? && matching_event? do
        maybe_recomplete(state)
      else
        state
      end

    {:noreply, state}
  end

  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    Logger.debug("Boc articles monitor stopped.")
    {:noreply, state}
  end

  def handle_info(:throttle_timer_complete, state) do
    Boc.Articles.DB.reset()

    state = %State{state | throttle_timer: nil}
    {:noreply, state}
  end

  defp maybe_recomplete(%State{throttle_timer: nil} = state) do
    throttle_timer = Process.send_after(self(), :throttle_timer_complete, @throttle_timeout_ms)
    %State{state | throttle_timer: throttle_timer}
  end

  defp maybe_recomplete(%State{} = state), do: state
end
