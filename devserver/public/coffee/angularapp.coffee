app = angular.module 'TestApp', []

dr_object = DOMReplay_initial_load
  debugmode: true
  server:
    session_id: "561d14e2585bbfce0ef888fb"
    user_id: 42
    url: "http://localhost:3000/api"

app.controller 'testCtrl', [
  '$scope',
  ($scope) ->
    console.log "running testCtrl"
    $scope.showblob1 = false
    $scope.showblob2 = false
    $scope.added_elements_count = 0;

    $scope.replay_object = dr_object.get_playback_object()

    $scope.run_alert = (msg) ->
      alert msg

    $scope.trigger_record = ->
      dr_object.initialize_tracking()

    $scope.start_replay = ->
      $scope.replay_object.play()

    $scope.stop_replay = ->
      $scope.replay_object.reset()

    $scope.pause_replay = ->
      $scope.replay_object.pause()

    $scope.stop_record = ->
      dr_object.set_operating_state_passive()

    $scope.add_elements = ->
      setup_test_buttons dr_object, "main_container", $scope.added_elements_count
      $scope.added_elements_count++

    $scope.log_to_console = (msg) ->
      console.log msg

    $scope.push_to_server = ->
      dr_object.push_to_server()

    $scope.load_from_server = ->
      dr_object.load_from_server()

    $scope.reset = ->
      dr_object.reset_storage()
  ]