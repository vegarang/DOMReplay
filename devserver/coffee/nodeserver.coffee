express = require "express"
mongoose = require "mongoose"
bodyParser = require "body-parser"

app = express()
app.use bodyParser.json()

PORT = 3000

mongoose.connect('mongodb://localhost:27017/domreplay');

Blob = mongoose.model "Blob",
  userid: Number
  sessionid: Number
  data: [
    {
      event_type: String
      id: String
      value: String
    }
  ]

app.get('/', (req, res) ->
  res.send "Got a get request to '/'"
)

app.post('/', (req, res) ->
  console.log "got post!"

  console.log "ids: user: #{req.body.user_id}, session: #{req.body.session_id}"
  console.log req.body.data
  res.send "Got post, ids: user: #{req.body.user_id}, session: #{req.body.session_id}"
)

server = app.listen PORT, () ->
  console.log "server running on port #{PORT}"
  return
