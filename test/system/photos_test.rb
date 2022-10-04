require "application_system_test_case"

class PhotosTest < ApplicationSystemTestCase
  setup do
    @photo = photos(:one)
  end

  test "visiting the index" do
    visit photos_url
    assert_selector "h1", text: "Photos"
  end

  test "should create photo" do
    visit photos_url
    click_on "New photo"

    fill_in "Image url", with: @photo.image_url
    fill_in "Location", with: @photo.location_id
    fill_in "Post", with: @photo.post_id
    fill_in "Shooting time", with: @photo.shooting_time
    fill_in "Uploader", with: @photo.uploader_id
    click_on "Create Photo"

    assert_text "Photo was successfully created"
    click_on "Back"
  end

  test "should update Photo" do
    visit photo_url(@photo)
    click_on "Edit this photo", match: :first

    fill_in "Image url", with: @photo.image_url
    fill_in "Location", with: @photo.location_id
    fill_in "Post", with: @photo.post_id
    fill_in "Shooting time", with: @photo.shooting_time
    fill_in "Uploader", with: @photo.uploader_id
    click_on "Update Photo"

    assert_text "Photo was successfully updated"
    click_on "Back"
  end

  test "should destroy Photo" do
    visit photo_url(@photo)
    click_on "Destroy this photo", match: :first

    assert_text "Photo was successfully destroyed"
  end
end
