defmodule Boc.MarkdownTest do
  use ExUnit.Case, async: true

  @markdown_with_front_matter """
  ---
  author: Robson
  title: "Test now"
  ---
  # this is markdown
  """

  test "can parse front matter" do
    assert {:ok,
            %{
              meta: %{"author" => "Robson", "title" => "Test now"},
              markdown: "# this is markdown\n",
              html: "<h1>\nthis is markdown</h1>\n"
            }} = Boc.Markdown.parse(@markdown_with_front_matter)
  end

  test "works without front matter" do
    assert {:ok,
            %{
              meta: %{},
              markdown: "# this is markdown with no front matter",
              html: "<h1>\nthis is markdown with no front matter</h1>\n"
            }} = Boc.Markdown.parse("# this is markdown with no front matter")
  end
end
