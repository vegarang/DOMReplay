app = angular.module 'TestApp', []

dr_object = DOMReplay_initial_load(true);

app.controller 'testCtrl', [
  '$scope',
  ($scope) ->
    console.log "running testCtrl"
    $scope.showblob1 = false

    $scope.run_alert = (msg) ->
      alert msg

    $scope.trigger_replay = ->
      dr_object.initialize_playback()

    $scope.log_to_console = (msg) ->
      console.log msg
  ]