require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "Should not save book without title" do
    book = Book.new
    assert_not book.save, "Saved Book without a title"
  end

  test "Should not save a book with an identical isbn" do
    book = Book.new(
      author: "Test",
      title: "Test",
      isbn: books(:turing).isbn,
      year: 2012
    )
    assert_not book.save, "Saved Book with conflicting isbn"
  end
end
