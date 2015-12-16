require 'test_helper'

class SongRequestsControllerTest < ActionController::TestCase
  setup do
    @song_request = song_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:song_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song_request" do
    assert_difference('SongRequest.count') do
      post :create, song_request: { dedicated_to: @song_request.dedicated_to, file_id: @song_request.file_id, message: @song_request.message, requestor: @song_request.requestor, song_url: @song_request.song_url }
    end

    assert_redirected_to song_request_path(assigns(:song_request))
  end

  test "should show song_request" do
    get :show, id: @song_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @song_request
    assert_response :success
  end

  test "should update song_request" do
    patch :update, id: @song_request, song_request: { dedicated_to: @song_request.dedicated_to, file_id: @song_request.file_id, message: @song_request.message, requestor: @song_request.requestor, song_url: @song_request.song_url }
    assert_redirected_to song_request_path(assigns(:song_request))
  end

  test "should destroy song_request" do
    assert_difference('SongRequest.count', -1) do
      delete :destroy, id: @song_request
    end

    assert_redirected_to song_requests_path
  end
end
